#!/bin/tcsh

# ######################################################################
# Create project workspaces
# ######################################################################
if ( $?TMUX == 0 ) then
    # Old workspace to restore after un-workspaced from GNU screen.
    set OLD_PROJECT=$PROJECT

    # Create aliases to start workspaces for StarRC release branch.
    foreach p ( $PROJECT_LIST_0 )
        set ws="$p.0"
        set PRE_SCREEN_CMD="setenv PROJECT $ws; setenv XORELEASE $p; setenv XOBRANCH 0"
        set patched_ws=`echo $ws | sed -e "s/\./-/g"`
        alias ws_$ws "$PRE_SCREEN_CMD; tmux new -AD -s $patched_ws; setenv PROJECT $OLD_PROJECT"
    end
    unset ws

    # workspace variants for head branch
    foreach p ( $PROJECT_LIST_1 $DEFAULT_PROJECT )
        set PRE_SCREEN_CMD="setenv PROJECT head.$p; setenv XORELEASE 2012.12; setenv XOBRANCH 1"
        alias ws_$p "$PRE_SCREEN_CMD; tmux new -AD -s $p; setenv PROJECT $OLD_PROJECT"
    end

    unset PRE_SCREEN_CMD
    unset OLD_PROJECT
endif