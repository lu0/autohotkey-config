# AutoHotKey scripts and configuration

AutoHotKey scripts I use to mimic my Linux Keybindings and Workspaces on Windows 10.


## Initial setup

1. Create at least 8 workspaces (virtual desktops) on Windows.
    There's no need to name them, but these are the ones I use:
    1. Web
    2. Art
    3. Coffee
    4. Files
    5. Terminal
    6. Social
    7. Games
    8. Music

1. Install [AutoHotKey](https://www.autohotkey.com).
    This repo is tested with [version `1.1.33.10`](https://www.autohotkey.com/download/1.1/AutoHotkey_1.1.33.10_setup.exe).

1. Clone the repository and its submodules.
```cmd
git clone --recursive https://github.com/lu0/autohotkey-config
```

1. Run each `*.ahk` script by double-clicking on them:
    - For all `*.ahk` scripts in folders `key-remappings`, `miscellaneous`, `toggle-win-terminal`, and `window-control`.
    - For `desktop_switcher.ahk`, contained in the `workspaces` folder.


### Run at startup

These scripts can run at startup by copying or linking them to the startup folder:

1. Open the repository in the file explorer.
1. Open the startup folder in **another** explorer

   - either by running the following command in CMD:

    ```cmd
    explorer.exe %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
    ```

   - or by pressing keys `WIN` + `R` and running `shell:startup`

1. Create a **shortcut** for each `*.ahk` script by selecting the `*.ahk` files and then,
    **while pressiong `Ctrl` + `Shift`**, dragging them from the repository folder to the startup folder.
    - For all `*.ahk` scripts in folders `key-remappings`, `miscellaneous`, `toggle-win-terminal`, and `window-control`.
    - For only the script `desktop_switcher.ahk`, contained in the `workspaces` folder.

1. Reboot
