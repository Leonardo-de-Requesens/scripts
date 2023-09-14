# I use this as a function in my .zshrc

separation="============"
echo "Starting auto fixup!"
echo $separation

maxCommits=0
counter=0
commitNumber=""
log_output=""

log_output=$(git --no-pager log --format=oneline -10)

while IFS= read -r line; do
    echo "($counter) $line"
    ((counter+=1))
done <<< "$log_output"

echo $separation

if [ "$0" = "bash" ]; then
# Why std error?
    read -p "Which commit do you want?: " commitNumber 
else
    vared -p "Which commit do you want?: " -c commitNumber 
fi

selectedCommit=$(git --no-pager log --format=oneline --skip=$commitNumber -1 | awk '{print $1}')

if git commit --fixup=${selectedCommit} 2>&1 1>/dev/null; then
    echo "Everything went well, don't forget to rebase --autosquash "
else
    echo "Finished with issue, have you added files to git?"
fi

