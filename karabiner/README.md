# Karabiner-Elements

A powerful and stable keyboard customizer for OS X.

- Source-code: https://github.com/tekezo/Karabiner-Elements
- Website: https://karabiner-elements.pqrs.org/

## Installation

For macOS Sierra see https://github.com/tekezo/Karabiner-Elements

__Note__: For **old** OS X 10.11, 10.10, 10.9 see https://pqrs.org/osx/karabiner/

## Karabiner-Elements (for MacOS Sierra)

- Documentation: https://karabiner-elements.pqrs.org/docs/
- Karabiner Configuration Reference Manual: https://karabiner-elements.pqrs.org/docs/json/

Make sure to view my custom [`karabiner.json`](./karabiner.json).

---

## Karabiner (Legacy)

:warning: **Use Karabiner Legacy only if you have an old macOS!**

Everything is inside the [./legacy](./legacy) directory.

### Legacy Custom Options (private.xml)

You can create your own custom options that will appear within Karabiner.
These options won't activate until you enable them in the settings menu.

```sh
cd "~/Library/Application Support/Karabiner"
ln -sfv ~/.config/karabiner/legacy/private.xml
/Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml
```

### Legacy Restore Keyboard Settings

You can import stored settings that will automatically select saved options:

- [Truly Ergonomic Keyboard]: `sh ~/.config/karabiner/legacy/import-teck.sh`
- [MacBook] and [Apple Keyboards]: `sh ~/.config/karabiner/legacy/import-macbook.sh`

### Legacy Backup Keyboard Settings

Karabiner features a command-line tool that can help:

```sh
/Applications/Karabiner.app/Contents/Library/bin/karabiner export > import.sh
chmod ug+x import.sh
```

Now all you need to do is run `import.sh` to restore your saved settings.

### Legacy Reference

- Documentation: https://pqrs.org/osx/karabiner/document.html.en
- Custom options: https://pqrs.org/osx/karabiner/document.html.en#privatexml

[Karabiner-Elements]: https://karabiner-elements.pqrs.org/
[Karabiner]: https://pqrs.org/osx/karabiner/
[Truly Ergonomic Keyboard]: https://www.trulyergonomic.com/
[MacBook]: https://www.apple.com/macbook/design/
[Apple Keyboards]: http://store.apple.com/us/mac/mac-accessories/mice-keyboards
