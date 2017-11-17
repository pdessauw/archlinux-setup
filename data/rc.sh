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
    ls $1
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
alias sudo='sudo '
alias vi='vim'
alias less='newless'
alias top='htop'

