# Project-based Configuration around Console and EmacsDaemon.

## Shell configuration

Several projects/workspaces can be created via shell aliases. For instances, the following projects are registered

| Workspace name | Purpose         | Alias |
|----------------|-----------------|-----|
| bozaalarm      | my android app  | ws_bozaalarm |
| tallycounter   | my android app  | ws_tallycounter |
| iosched        | for Google I/O 2014 code study | ws_iosched |
| default        | default workspace | ws_default |

To use it, create a link at the user root directory
```
ln -s ~/Settings/bash/bashrc .bashrc
or
ln -s ~/Settings/csh/cshrc .cshrc
```

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

