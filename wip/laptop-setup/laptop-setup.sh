#!/bin/sh

###############################################################################
# Usage:
#   (TODO)
###############################################################################

###############################################################################
# Installs via Homebrew: git, postgres, redis, the_silver_searcher, vim, ctags,
#   tmux, reattach-to-user-namespace, imagemagick, qt, hub, node, rbenv,
#   ruby-build, openssl, libyaml, phantomjs.
# Adds alias, environment variables, and path changes to bashrc/zshrc file by
#   sourcing the files in this repo.
# Using fancy (edited) thoughtbot script to do all the sweet brew/rbenv/etc.
###############################################################################
curl --remote-name https://raw.githubusercontent.com/DavidRagone/shell-stuff/master/laptop-setup/aliases
curl --remote-name https://raw.githubusercontent.com/DavidRagone/shell-stuff/master/laptop-setup/env_vars
curl --remote-name https://raw.githubusercontent.com/DavidRagone/shell-stuff/master/laptop-setup/path
touch ~/.laptop.local
echo "
brew_install_or_upgrade 'phantomjs'
append_to_zshrc_or_bashrc 'source $HOME/laptop-setup/aliases' 1
append_to_zshrc_or_bashrc 'source $HOME/laptop-setup/env_vars' 1
append_to_zshrc_or_bashrc 'source $HOME/laptop-setup/path' 1
gem_install_or_update 'pivotal_git_scripts'
" > ~/.laptop.local

curl --remote-name https://raw.githubusercontent.com/DavidRagone/laptop/master/mac
sh mac 2>&1 | tee ~/laptop.log


###############################################################################
# Postgres setup
#   Creates "postgres" user
###############################################################################
psql -d postgres << EOF
CREATE ROLE "postgres" LOGIN CREATEDB SUPERUSER;
EOF


###############################################################################
# Git && Pivotal Git Scripts setup
#   - Creates ~/.pairs & ~/.gitignore files
#   - Adds some default things to ignore in the global ~/.gitignore file
#   - Defaults git output to color, rebase on pull, and provides a nice `lg` log
#       alias
###############################################################################
touch $HOME/.pairs
touch $HOME/.gitignore

gitignore="$HOME/.gitignore"
for setting in '.DS_Store' 'tags' 'custom_plan.rb' 'zeus.json' '.sass-cache' '.lvimrc' '*.db' '.tags'
do
  if ! grep -Fqs $setting "$gitignore"; then
    printf "%s\n" "$setting" >> "$gitignore"
  fi
done
git config --global color.ui auto
git config --global pull.rebase true
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


###############################################################################
# Installs ruby versions
#   As many as your heart desires. Just add them to the list
###############################################################################
for ruby_version in '2.2.0'
do
  if ! rbenv versions | grep -Fq "$ruby_version"; then
    rbenv install -s "$ruby_version"
    gem install bundler
  fi
done


###############################################################################
# Things left for the user to do manually
###############################################################################
next_step() {
  local text
  local log="$HOME/setup-next-steps"
  if [ "$1" -eq 0 ]; then
    text="$2"
  else
    text="$1) $2"
  fi

  printf "$text\n"
  if ! grep -Fqs "$text" "$log"; then
    printf "%s\n" "$text" >> "$log"
  fi
}
next_step 0 "You will need to complete each of the following steps manually:"
next_step 1 "Set up github for ssh push/pull by adding keys"
next_step 2 "Install iTerm2 and set it as your default terminal application"
next_step 3 "In Chrome, add the Postman extension"
next_step 4 "Copy your public and private keys into ~/.ssh"
