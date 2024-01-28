alias yt="$DOTDOTDOT/.venvs/youtube-dl/bin/youtube-dl --add-metadata -i"
alias docker-stop-all="docker stop $(docker ps -aq)"
alias git-url="git config --get remote.origin.url"
alias public-ip="curl ifconfig.co"
alias public-ip-json="curl ifconfig.co/json"
alias ppython="time python -m cProfile -o /tmp/pyprofile"
# alias clear-bash-history="cat /dev/null > ~/.bash_history && history -c && exit"
alias clear-zsh-history="cat /dev/null > ~/.zsh_history && history -c && exit"
alias jupyter-clear="jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace"
alias jupyter-clear-all="find . -name \"*.ipynb\" | grep -v .ipynb_checkpoints | xargs -I {} jupyter nbconvert --ClearOutputPreprocessor.enabled=True --inplace {}"
alias sshj="ssh -L 8888:localhost:8888"
alias fix-holding-keys="xset r on"
alias ashex="od -A n -t x1"
alias sysrq-level="cat /proc/sys/kernel/sysrq"
alias kill-all-zombie-parents="kill -HUP $(ps -A -o stat,ppid | grep -e '[zZ]'| awk '{ print $2 }')"
alias get-nice="ps -o pid,comm,nice -p"
