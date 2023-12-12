#!/bin/bash
# I use this as a function in my .zshrc

# This is heavily inspired by thePrimeagen tmux-sessionizer
# So I tried to call this from inside nvim but couldn't find it so
# IF in the future I want to start using this in that way I would need to
# create is own file and add it to the PATH

project_name=$(ls ${repo_folder} | fzf )

if [[ -z $project_name ]]; then
	return 1
fi

if [[ -z ${TMUX} ]]; then
	tmux new -As $project_name -c "$repo_folder/$project_name"
	return 0
fi

if ! tmux has-session -t=$project_name 2> /dev/null ; then
	tmux new-session -ds $project_name -c "$repo_folder/$project_name"
fi
	tmux switch-client -t $project_name
