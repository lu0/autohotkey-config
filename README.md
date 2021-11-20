# autohotkey-config

AutoHotKey scripts I use to mimic my Linux Keybindings and Workspaces on Windows 10.

## Initial setup
1. Create 8 workspaces (virtual desktops) on windows. I use the following ones:
    - Web
    - Art
    - Coffee
    - Files
    - Terminal
    - Social
    - Games
    - Music

3. Install [AutoHotKey](https://www.autohotkey.com).
4. Clone the repository and its submodules.
```sh
git clone --recursive https://github.com/lu0/autohotkey-config
```
5. Run each `*.ahk` file of the root folder.
6. Run `desktop_switcher.ahk` of the `workspaces` folder.

### Run on startup
Setup windows shortcuts from the startup folder to each compiled script.

1. Compile each `*.ahk` file of the root folder using the context menu of the file explorer.
2. Compile `desktop_switcher.ahk` of the `workspaces` folder.
3. Open the following path in **another** file explorer.
```sh
%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
```
4. Paste every `*.exe` file (scripts compiled in step `2`) in the startup folder.
5. Reboot
