# Config triage

Rules for deciding what belongs in this repo. Run this review every ~6 months,
or whenever `git status` gets noisy.

```sh
just audit-secrets   # credentials in untracked files
just triage          # untracked files grouped by app, with age
```

## The decision

For each untracked file, in order. First match wins.

### 1. Delete

- Backup dirs: `*.bak`, `*.old`, `*.older`, `*.bka`. Keep one in `_archive/`
  if it has sentimental value, never in the tree root.
- Configs for tools uninstalled more than ~2 years ago. Git history has them
  if they were ever committed.

### 2. Ignore

- **Secrets.** Tokens, keys, passwords. Ignore the file, or register it with
  the vault filter in `.gitattributes` if it also holds real config.
- **State.** Databases, caches, histories, lockfiles, `*.db`, `*.log`,
  session and recovery files.
- **Machine identity.** UUIDs, telemetry IDs, device registrations, absolute
  paths to this machine, LAN hostnames and IPs.
- **Vendored defaults.** Upstream's shipped config or themes, unmodified.
  The tool already has them; committing pins a stale copy. Do not add an
  ignore rule: leaving them untracked keeps them visible in `git status` as
  a reminder to delete them by hand.
- **Generated output.** Anything a build step produces, e.g. bundles.

### 3. Commit

Everything else, meaning hand-written config for a tool still in use.

Prefer committing a config with its secret scrubbed over ignoring the whole
file, so the structure stays documented.

## Commit style

[Conventional commits][cc]. One app per commit, `type(scope): summary`, max
50 chars, imperative. Scope is the app or directory.

- `feat` new config or capability
- `fix` correct broken or leaking config
- `chore` gitignore, cleanup, archival
- `docs` notes and documentation

Body only when the *why* is not obvious, wrapped at 72. No narration, no
file lists, no comments restating the diff.

```text
feat(wezterm): introduce config

Split from a single file into config/ and events/.
```

[cc]: https://www.conventionalcommits.org

## Notes

- Tracking a config for a tool not installed on *this* machine is fine when
  the tool runs on another (Linux WM configs, systemd units).
- Dumped defaults (`*-default.toml`, `defaults*.yaml`) stay untracked and
  unignored on purpose. Rafi deletes them manually.
- Prefer a rule that names the offending file over one that hides a whole
  directory. `/glab-cli/` also hid hand-written aliases;
  `/glab-cli/config.yml` does not.
- Judgment calls currently ignored, revisit if they become annoying:
  `gopass/config` (real settings, but one absolute mount path) and
  `ruroco/*.pem` (the public half is harmless, kept with its private key).

## Recovering a clobbered file

If an uncommitted edit is lost and the file was last edited in Neovim, the
undo file holds a SHA-256 of the saved buffer:

```sh
ls ~/.local/state/nvim/undo/ | grep <filename>
```

Bytes 11..43 are `sha256(concat(line + "\0"))` over the buffer's lines. That
verifies whether a reconstruction is byte-exact, and `:earlier 999` recovers
the text directly when the file on disk still matches.
