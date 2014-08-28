#!/bin/tcsh -f
set session_name=$1
tmux has-session -t "$session_name" >& /dev/null
# $status the return status of last command
if ( $status == 1 ) then
    echo "Create project workspace for $session_name ..."
    tmux new-session -d -s "$session_name"
    foreach i ( `seq 1 4` ) 
        tmux new-window -t "${session_name}:$i"
    end
    tmux new-window -t "${session_name}:5" -n TEST
endif
tmux select-window -t "${session_name}:0"
tmux -2 attach -t "$session_name"
