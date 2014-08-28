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
        set session_name=`echo $ws | sed -e "s/\./-/g"`

        alias create_workspace \
             "tmux has-session -t $session_name 2> /dev/null; \\
             if ( $? == 1 ) then \\
                echo \"Create project workspace for ${PROJECT}...\" \\
                tmux new-session -d -s $session_name \\
                foreach i ( `seq 1 4` ) \\
                    tmux new-window -t \"$session_name:$i\" \\
                end \\
                tmux new-window -t \"$session_name:5\" -n \"TEST\" \\
             endif \\
             tmux select-window -t \"$session_name:0\" \\
             ttmux -2 attach -t \"$session_name\""
        # alias ws_$ws "$PRE_SCREEN_CMD; tmux new -AD -s $session_name; setenv PROJECT $OLD_PROJECT"
        alias ws_$ws "$PRE_SCREEN_CMD; create_workspace; setenv PROJECT $OLD_PROJECT"
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
