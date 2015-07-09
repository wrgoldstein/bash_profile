# specify git version
export PATH=/usr/local/git/bin:$PATH

# NVM
export NVM_DIR="/Users/williamgoldstein/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# VIRTUALENV
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh 

# POWERLINE (see https://github.com/wrgoldstein/powerline-shell)
function _update_ps1() {
       export PS1="$(~/projects/powerline-shell/powerline-shell.py $? 2> /dev/null)"
    }
export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
export CLICOLOR=1

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Environment variables for systems
export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

# Environment variables for projects
# redacted.

# Convenience variables for oft used directories
# mostly redacted, but they all look like this:
export force=$Artsy/force


# Convenience aliases

# sometimes the audio daemon fails to play nice w/ google hangouts, this is a fix.
alias no-audio='sudo killall coreaudiod'

# yeah there's a subl CLT, but all I need is this part of it.  Use like `subl $force`.
alias subl='open -a Sublime\ Text'

# crucial.
alias bp='subl ~/.bash_profile'
alias .bp='source ~/.bash_profile'

# misc
alias cd-d='cd ~/Downloads'
alias cd-a='cd ~/Artsy'
alias nb='ipython notebook'
alias be='bundle exec'
alias brc='bundle exec rails c'
alias hr='heroku run'
alias smartcop='git diff --name-only | xargs rubocop'
alias smartspec='git diff --name-only | grep spec | xargs rspec'

# Opens the github page for the current git repository in your browser
# (Yes, there's also a CLT for this, but again too bloated)
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi
 
  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl/tree/$branch
  open $giturl
}
