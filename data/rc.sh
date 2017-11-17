# Main vars
export VISUAL=vim
export EDITOR=$VISUAL

# Extra functions
function newless() {
  if [ $# != 1 ]
  then
    echo "Incorrect parameters (1 expected, $# given). Usage: less my_file."
    return 1
  fi

  if [ -d $1 ]
  then
    ls -lha $1
  elif [ -f $1 ]
  then
    colorize $1 | less
  else
    echo "$1: No such file or directory."
    return 2
  fi

  return 0
}

# Aliases
alias ll='ls -lha'
alias sudo='sudo '
alias vi='vim'
alias less='newless'
alias top='htop'
alias ps='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias mkdir='mkdir -pv'
alias histgrep='history | grep'
alias du='ncdu'
alias df='pydf'

