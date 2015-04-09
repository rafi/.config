Karabiner
===
A powerful and stable keyboard customizer for OS X.

Installation
---
See https://pqrs.org/osx/karabiner/

### Custom Options
You can create your own custom options that will appear within Karabiner.
These options won't activate until you enable them in the settings menu.
```sh
cd "~/Library/Application Support/Karabiner"
ln -sfv ~/.config/karabiner/private.xml
/Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml
```

Restore Keyboard Settings
---
You can import stored settings that will automatically select saved options:
- [Truly Ergonomic Keyboard]: `sh ~/.config/karabiner/import-teck.sh`
- [MacBook] and [Apple Keyboards]: `sh ~/.config/karabiner/import-macbook.sh`

Backup Keyboard Settings
---
Karabiner features a command-line tool that can help:
```sh
/Applications/Karabiner.app/Contents/Library/bin/karabiner export > import.sh
chmod ug+x import.sh
```
Now all you need to do is run `import.sh` to restore your saved settings.

See Also
---
- Documentation: https://pqrs.org/osx/karabiner/document.html.en
- Custom options: https://pqrs.org/osx/karabiner/document.html.en#privatexml

[Truly Ergonomic Keyboard]: https://www.trulyergonomic.com/
[MacBook]: https://www.apple.com/macbook/design/
[Apple Keyboards]: http://store.apple.com/us/mac/mac-accessories/mice-keyboards
