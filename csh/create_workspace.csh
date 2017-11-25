#!/bin/tcsh -f
set session_name=$1

# tmux has-session -t "$session_name" >& /dev/null
# # $status the return status of last command
# if ( $status == 1 ) then

alias tmux "tmux -u"
set has_session=`tmux list-sessions | grep "${session_name}\:"`
if ( "$has_session" == "" ) then
    echo "Create project workspace for $session_name ..."
    tmux new-session -d -s "$session_name"
    foreach i ( `seq 1 4` )
        tmux new-window -t "${session_name}:$i"
    end
    # create a 3x3 pane layout on this QA window
    tmux new-window -t "${session_name}:5" -n Testing
    tmux split-window -h -p 50
    tmux split-window -h -p 50
    tmux split-window -h -p 50
    tmux select-layout tiled
endif
tmux select-window -t "${session_name}:0"
tmux -2 attach -d -t "$session_name"
unset has_session
unset session_name
