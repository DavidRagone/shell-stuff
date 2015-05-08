# bin/sh

# TODO - make this easily useable via command line (e.g., `init shell-stuff` to
#   load this repo

# TODO - pretty sure there's built-out options for tmux session initialization

#if [ tmux ls | grep 'dev' ]
#  # TODO - maybe have this pass in an argument?
#  tmux attach-session
#  #TODO - return
#fi

# Note: 'C-m' for character return (I think?)
tmux new-session -d -s 'rawr' -c 'startDirectory' -n 'windowName'\;\
  send-keys 'some command, e.g. gulp serve' 'C-m'\;\
  split-window -h -d -p 60 -c 'startDirectory'\;\
  select-pane -t 1\;\
  send-keys 'vim' 'C-m'\;\
  select-pane -t 0\;\
  split-window -v -d -c 'startDirectory' -p 80\;\
  select-pane -t 1\;\
  send-keys 'some command, e.g. gulp test' 'C-m'\;\
  select-pane -t 2\;\
\
  new-window -d -c 'startDirectory -n 'windowName'\;\
  select-window -t windowName:1\;\
  send-keys 'rails c' 'C-m'\;\
  split-window -h -d -p 60 -c 'startDirectory'\;\
  select-pane -t 1\;\
  send-keys 'vim' 'C-m'\;\
  select-pane -t 0\;\
  split-window -v -d -c 'rails s' -p 80\;\
  select-pane -t 1\;\
  send-keys 'rspec' 'C-m'\;\
  select-pane -t 2\;\
\
  attach





# TODO - where did I get this from?
#tmux new-session -d -s foo 'exec pfoo'
#tmux send-keys 'bundle exec thin start' 'C-m'
#tmux rename-window 'Foo'
#tmux select-window -t foo:0
#tmux split-window -h 'exec pfoo'
#tmux send-keys 'bundle exec compass watch' 'C-m'
#tmux split-window -v -t 0 'exec pfoo'
#tmux send-keys 'rake ts:start' 'C-m'
#tmux split-window -v -t 1 'exec pfoo'
#tmux -2 attach-session -t foo
#
