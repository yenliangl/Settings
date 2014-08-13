# Project-based Configuration around Console and EmacsDaemon.

## Shell configuration

Several projects/workspaces can be created via shell aliases. For instances, the following projects are registered

| Workspace name | Purpose         | Alias |
|----------------|-----------------|-----|
| bozaalarm      | [BozaAlarm](https://play.google.com/store/apps/details?id=org.startsmall.bozaalarm)  | ws_bozaalarm |
| tallycounter   | [TallyCounter](https://play.google.com/store/apps/details?id=org.startsmall.tallycounter) | ws_tallycounter |
| iosched        | for Google I/O 2014 code study | ws_iosched |
| default        | default workspace | ws_default |

To use it, create a link at the user root directory
```bash
ln -s ~/Settings/bash/bashrc .bashrc
or
ln -s ~/Settings/csh/cshrc .cshrc
```

After the creation of a workspace, the first time at which **et (alias of
emacsclient)** is invoked an Emacs server is created specifically for this
workspace. The edit of a file will be in the workspace (tmux/screen
session) only. If mutiplt workspaces are created in the same machine, multiple Emacs
servers are created.

### bash

Different platforms (*Cygwin* and *MacOSX*) are customized by different bash/bashrc.cygwin and bash/bashrc.darwin respectively.

### tcsh

## Tmux Configuration

Simple but effective setting.

![alt tag](https://raw.githubusercontent.com/yenliangl/Settings/master/image/tmux_screenshot1.png)

### Mouse support

```
setw -g mode-mouse on
set -g mouse-select-pane on
```
but to select and paste text as before, each terminal app has different configuration.

#### For MinTTY in Windows/Cygwin

Use Shift+LefButton to select and Shift+MiddleButton to paste.

![alt tag](https://raw.githubusercontent.com/yenliangl/Settings/master/image/mouse_pane_select_in_mintty.png)

#### For iTerm2 in MacOSX,

Use Option+LeftButton to select and Option+MiddleButton to paste.

![alt tag](https://raw.githubusercontent.com/yenliangl/Settings/master/image/iterm2_enable_mouse_reporting_setting.png)
![alt tag](https://raw.githubusercontent.com/yenliangl/Settings/master/image/iterm2_mouse_paste_setting.png)

### Features I need

- [ ] Show window list on the terminal's title bar.

