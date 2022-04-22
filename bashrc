#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set up the colors for `ls` to use
[[ -f $HOME/.dircolors ]] && eval "$(dircolors $HOME/.dircolors)"

# make tab cycle through commands after listing
bind '"\t":menu-complete'
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"

# Setup extract alias
x () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1 ;;
      *.tar.gz)    tar xzf $1 ;;
      *.bz2)       bunzip2 $1 ;;
      *.rar)       rar x $1 ;;
      *.gz)        gunzip $1 ;;
      *.tar)       tar xvf $1 ;;
      *.tbz2)      tar xjf $1 ;;
      *.tgz)       tar xzf $1 ;;
      *.zip)       unzip $1 ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7za x $1 ;;
      *.xz)        xz -d $1 ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

function cd () {
	DIR="$1"
	DIR=${DIR:-"$HOME"}
	builtin cd "$DIR"
    [[ $? -eq 0 ]] && ls --color=auto
}

function mkcd () {
    DIR="$1"
    DIR=${DIR:-"$HOME"}
    [[ -d "$DIR" ]] && mkdir $DIR
    cd $DIR
}

function vcp () {
	if [ $# -eq 2 ]; then
		cp $1 $2
		vim $2
	fi
}

function vbak () {
	if [ $# -eq 2 ]; then
		cp $1 $2
		vim $1
	fi
}

function aur-install () {
cd $HOME/builds
	if [ $# -ge 1 ]; then
		for repo in "${@}"; do
			git clone $repo
			builtin cd $(basename $repo .git)
			makepkg -si --noconfirm
			builtin cd ..
		done
	fi
}

function daily-chal () {
mkdir $1
cd $1
vim challenge.txt
}


source $HOME/bin/ptheme/prompt_bigdigsquig.sh

# config

alias bconf='vim $HOME/.bashrc'
alias binit='source $HOME/.bashrc'
alias i3c='i3-var-update'
alias xconf='vim $HOME/.Xresources'
alias xreload='xrdb $HOME/.Xresources'
alias piconf='vim $HOME/.config/picom/picom.conf'

# always needs sudo

alias pacman='sudo pacman'
alias update='sudo pacman -Syu --noconfirm'
alias paccache='sudo paccache'
alias please='sudo $(history -p !!)'
alias assman='sudo systemctl'
alias gparted='sudo gparted'
alias vim='sudo vim'
alias chmod='sudo chmod'
alias cpu-x='sudo cpu-x'
alias fastboot='sudo fastboot'
alias fdisk='sudo fdisk'
alias iptables='sudo iptables'
alias du='sudo du'
alias netctl='sudo netctl'
alias ip='sudo ip'
alias lldb='sudo lldb'
alias iw='sudo iw'
alias powertop='sudo powertop'

# modified functionality (flags, better names, or otherwise)

alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias valor='valgrind --track-origins=yes'
alias rm='mv -ft $HOME/Trash'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias ping='ping -c 4'
alias shutdown='shutdown now'
alias logout='i3-msg exit'
alias calculator="gnome-calculator"
alias clone='git clone'
alias cpp='clang++ -Wall -Werror -Wextra'
alias dicc='diff -C0'
alias xclip='xclip -selection clip'
alias newsh='newscript -sh'
alias newpy='newscript -py3'
alias amend='git commit -a --amend; git pull; git push'

# renamed for easier memory

alias schootar='tar -zxvf'
alias xwinfo='xprop'
alias nut='python $HOME/Downloads/nut-2.6/nut.py'
alias mirrors='sudo reflector --sort age --country US --fastest 20 --protocol https --save /etc/pacman.d/mirrorlist'

# fun

alias clap='$HOME/Documents/scripts/clap.sh'
alias spongebob='$HOME/Documents/scripts/spongebob.sh'
alias haha="printf '\e[0;31;46mB00B135\e[0m\n'"

# games

alias mtgo='wine $HOME/Desktop/mtgo.exe'
alias minecraft='minecraft-launcher'
alias clean='make clean'
alias doom='chocolate-doom -iwad ~/Documents/dos/Doom/DOOM.WAD -window'
alias blipblop='cd $HOME/Documents/games/blip-blop/vc-projects/Blip_n_Blop_3/; ./blipblop; cd -'

# vm/ssh

alias skoger='VBoxManage startvm "skoger ryline" --type headless; ssh Nuthouse'
alias phone='ssh -i ~/.ssh/id_phone -p 8022'

# system related

alias sys-update='mirrors; repac; aur-update; pip-update'
alias disk='sudo du -hd1 /'
alias jctl='mate-terminal -t jctl -e "journalctl -f"; asciiquarium'
alias browse='(thunar $PWD &>/dev/null & disown)'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# complex tasks

alias jorb='cd projects/Python/scraping; ./get_a_job.py; ./open_links.py output/linkedin/$(date -I)/*; cd -'

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:pwd:clear:exit:shutdown:reboot:bconf:binit:i3c:xconf:xreload:please"
