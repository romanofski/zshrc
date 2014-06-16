# The default hostname to display in the shell prompt. Maybe override this
# later for specific hosts.
# http://www.gentoo.org/doc/en/zsh.xml

# Customize to your needs...

# bumped from 10000 on 2008-10-05
HISTSIZE=25000
SAVEHIST=25000
HISTFILE=~/.history
MAILCHECK=0

export EDITOR=vi
[[ -x $commands[vim] ]] && export EDITOR=vim
export PAGER=more
[[ -x $commands[less] ]] && export PAGER="less -R -X -I -F"

export BROWSER=lynx
[[ -n $DISPLAY ]] && export BROWSER=opera

# extra completion verbosity
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# I got this block of junk from some place.. don't know what it does, but maybe fun??
# copied from here: http://stackoverflow.com/questions/171563/whats-in-your-zshrc
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _expand _force_rehash _complete _approximate
zstyle ':completion:*' completer _expand _complete
# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'
# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'
# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse
# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion::approximate*:*' prefix-needed false

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# don't complete things that have already been completed
# and are thus on the current command line
zstyle ':completion:*:rm:*' ignore-line yes

# colored filename completion. This is the output of the dircolors command,
# which has been tweaked slightly
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.mpeg=01;35:*.wmv=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
export LS_COLORS
zstyle ':completion:*' list-colors $LS_COLORS

typeset -U fpath # no duplicates

# nice to have your own fpath dir
[[ ! -d ~/.fpath ]] && mkdir ~/.fpath
fpath+=( ~/.fpath )

# zln and zcp have to be symlinks to the zmv function
for name in zln zcp; do
    fn=~/.fpath/$name
    # this is a hack to see if it is a broken symlink
    # these symlinks will break when you upgrade your zsh
    # damn i wish i knew what this conditional actually means
    if [ -L $fn -a ! -e $fn ]; then
        rm $fn
    fi
    if [[ ! -a $fn ]]; then
        for dir in $fpath; do
            if [[ -a $dir/zmv ]]; then
                ln -s $dir/zmv $fn
                break
            fi
        done
    fi
done

# nifty functions
autoload -U compinit zargs zed zmv zln zcp

# enable extended completion system
compinit -u #ignore security of comp files

# NOTE: basic $path config is done in .zshenv

typeset -U classpath
typeset -T CLASSPATH classpath

# nice shell options. man zshoptions
setopt SHARE_HISTORY NO_BG_NICE HIST_IGNORE_ALL_DUPS AUTO_CD EXTENDED_GLOB
setopt BARE_GLOB_QUAL NO_BEEP AUTO_PUSHD PUSHD_IGNORE_DUPS PROMPT_SUBST
setopt TRANSIENT_RPROMPT COMPLETE_IN_WORD AUTO_LIST APPEND_HISTORY
setopt INC_APPEND_HISTORY HIST_REDUCE_BLANKS HIST_VERIFY
setopt correctall # correction

# some boxes use HOSTNAME instead of HOST
[[ -z $HOST ]] && HOST=$HOSTNAME

alias -g L='| less'
alias c="cd .."
alias l="ls -al"
alias less="less -R -I -X -F"
alias ls="ls --color=yes"
alias s='yum search'
alias virc="$EDITOR ~/.zshrc;source ~/.zshrc"
alias zcp='noglob zcp'
alias zln='noglob zln'
alias zmv='noglob zmv'
alias vim_update='vim +BundleInstall! +qall'
alias vim_bootstrap='git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle && vim_update'
alias ggrep='git grep --color'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github vi-mode)

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="afowler"

if [ -f $ZSH/zsh-custom ]
then
    source $ZSH/zsh-custom
else
    echo "couldn't find $ZSH/zsh-custom"
fi
source $ZSH/oh-my-zsh.sh

# enable emacs bindings
bindkey -e
