#!/bin/bash
# -------------------------------------------------
#
#       James' Excellent Bash Profile
#
#           Written: James Varoutsos 
#   Date: 1-Aug-2021        Version: 1.1
#
#   1.1 - Added pureline (bash) into profile
#   1.2 - Multiple logic fixes
#   1.3 - Added md5|sha|base64 shortcuts
#
# ------------------------------------------------- 

unset PS1           # To enable safe-swapping between shells
unset PURE_PATH     # Fixes edge-case where pureline dir gets scrubbed

# Set pre-program aliases
if [ -f /usr/bin/python3 ]; then
    alias python="python3"
    alias py="python3"
fi

# Display current terminal colors
function showColors {
    for x in {001..256}; do
        echo -ne "\033[38;5;$x""m(#$x) \\\e[38;5;$x""\e[0m""\033[48;5;$x""m\\\e[48;5;$x""\e[0m ";
        if ! ((${x##+(0)} % 3)); then echo -e "\e[0m"; fi
    done; echo
}

# Check if pureline is cloned anywhere
if [[ -d "$HOME/pureline" ]]; then
    PURE_PATH="$HOME/pureline"
elif [[ -d /etc/pureline ]]; then
    PURE_PATH="/etc/pureline"
# If pureline isn't cloned, set a default PS1
else
    # Set terminal PS1
    if [[ $(id -u) = 0 ]]; then
        export PS1="\[\033[38;5;7m\][\W]\[$(tput sgr0)\]\[\033[38;5;9m\]\u\[$(tput sgr0)\]\[\033[38;5;8m\]@\[$(tput sgr0)\]\[\033[38;5;14m\]\H\[$(tput sgr0)\]\[\033[38;5;8m\]\\$\[$(tput sgr0)\]"
    else
        export PS1="\[\033[38;5;7m\][\W]\[$(tput sgr0)\]\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;8m\]@\[$(tput sgr0)\]\[\033[38;5;14m\]\H\[$(tput sgr0)\]\[\033[38;5;8m\]\\$\[$(tput sgr0)\]"
    fi
fi

# For anything that isn't linux term & if pureline has been found
if [ "$TERM" != "linux" ] && [[ -n "${PURE_PATH+x}" ]]; then 
    # Use pureline to set PS1 if it exists
    if [ -f ~/.purelinerc ]; then
        source "$HOME"/pureline/pureline "$HOME"/.purelinerc
    elif [ -f "$HOME"/pureline/configs/powerline_full_256col.conf ]; then
        source "$HOME"/pureline/pureline "$HOME"/pureline/configs/powerline_full_256col.conf
    fi
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Source network functions definitions
if [ -f ~/.netfuncsrc ]; then
    source ~/.netfuncsrc
fi

# Source system functions definitions
if [ -f ~/.netfuncsrc ]; then
    source ~/.netfuncsrc
fi

# Term-friendly hash shortcuts
function md5cli { echo -n "$1" | md5sum | cut -f 1 -d ' '; }
function sha1cli { echo -n "$1" | sha1sum | cut -f 1 -d ' '; }
function sha2cli { echo -n "$1" | sha256sum | cut -f 1 -d ' '; }
function sha3cli { echo -n "$1" | sha512sum | cut -f 1 -d ' '; }

# Encodables (Dev/null-ing errors because padding characters are hard)
function b64enc { echo -n "$1" | base64 2> /dev/null; }             # Encode
function b64dec { echo -n "$1" | base64 -d 2> /dev/null; echo; }    # Decode

# Bash history set-up
export HISTFILE="$HOME/.bhistory.log"
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE="history:pwd"
export HISTTIMEFORMAT="%h %d %H:%M:%S -- "
export HISTSIZE=10000

# Add cool stuff to $PATH
export PATH=/home/vjmes/.local/bin:$PATH
    
# Standard aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias lsj="ls -lathr --color=auto"
alias grep="grep --color=auto"
alias dfj="df -h"
alias hist="history"
alias ghist="history | grep --color=auto"

# Checksum aliases
alias md5y="echo -n $1 | md5sum | cut -f 1 -d ' '"

# Set grep match color
export GREP_COLORS='mt=49;38;5;120:ln=49;38;5;75'

# Set ls colors
export LS_COLORS='rs=0:di=36;1:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=38;5:sg=38;5:ca=38;5:tw=38;5:ow=38;5:st=38;5:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';