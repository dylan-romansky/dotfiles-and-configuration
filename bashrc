#
# ~/.bashrc
#

[ -f ~/Documents/soft/google-cloud-sdk/path.bash.inc ] && . ~/Documents/soft/google-cloud-sdk/path.bash.inc
[ -f ~/Documents/soft/google-cloud-sdk/completion.bash.inc ] && . ~/Documents/soft/google-cloud-sdk/completion.bash.inc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# make tab cycle through commands after listing
bind '"\t":menu-complete'
bind '"\e[Z": menu-complete-backward'
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"

# Setup extract alias
x () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1" ;;
      *.tar.gz)    tar xzf "$1" ;;
      *.bz2)       bunzip2 "$1" ;;
      *.rar)       rar x "$1" ;;
      *.gz)        gunzip "$1" ;;
      *.tar)       tar xvf "$1" ;;
      *.tbz2)      tar xjf "$1" ;;
      *.tgz)       tar xzf "$1" ;;
      *.zip)       unzip "$1" ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7za x "$1" ;;
      *.xz)        xz -d "$1" ;;
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
	case $# in
		2)
			builtin cd "${PWD/$1/$2}"
			;;
		*)
			DIR="$1"
			DIR=${DIR:-"$HOME"}
			builtin cd "$DIR"
			;;
	esac
	[[ $? -eq 0 ]] && ls --color=auto
}

function mkcd () {
	DIR="$1"
	DIR=${DIR:-"$HOME"}
	[[ -d "$DIR" ]] || mkdir "$DIR"
	cd "$DIR"
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
	if [ -z $1 ]; then
		echo "Usage: aur-install [repo(s)]"
		return
	fi
	THISPWD="$PWD"
	THISPREV="$OLDPWD"
	builtin cd $HOME/builds
	if [ $# -ge 1 ]; then
		for repo in "${@}"; do
			git clone $repo
			builtin cd $(basename $repo .git)
			makepkg -si --noconfirm
			builtin cd ..
		done
	fi
	builtin cd "$THISPWD"
	OLDPWD="$THISPREV"
}

function daily-chal () {
	mkdir $1
	cd $1
	vim challenge.txt
}

function getpid () {
	if [ -z $1 ]; then
		echo "usage: getpid [term]"
		return
	fi
	ps aux | grep "$@" | head -n -1
}

function jcurl () {
	curl "$@" | json_pp | pygmentize -l json
}

# I forgot killall exists when I wrote this.
# it has since been replaced with an alias

#function maim () {
#	if [ -n "$1" ]; then
#		for PARAM in "${@}"; do
#			for PID in $(getpid $PARAM | awk '{ print $2 }'); do
#				sudo kill -9 $PID
#			done
#		done
#	fi
#}

vman() {
  vim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}

# copying things in urxvt doesn't put them
# in your normal clipboard so this lets
# me copy small lines of text

function cb () {
	if [ -n "$1" ]; then
		echo -n "$*" > /tmp/txt
		clip /tmp/txt
	fi
}

function git-upload () {
	git commit -a -m "${*}"
	git push
}

function dice () {
	if [ -z $1 ]; then
		echo "Error: missing dice value"
	else
		echo "$(($RANDOM % $1 + 1))"
	fi
}

source $HOME/bin/ptheme/prompt_bigdigsquig.sh

# config

alias bconf='vim $HOME/.bashrc'
alias binit='source $HOME/.bashrc'
alias i3c='i3-var-update'
alias xconf='vim $HOME/.Xresources'
alias xreload='xrdb $HOME/.Xresources'
alias xmerge='xrdb merge $HOME/.Xresources'
alias piconf='vim $HOME/.config/picom/picom.conf'

# always needs sudo

alias pacman='sudo pacman'
alias update='sudo pacman -Syu --noconfirm'
alias paccache='sudo paccache'
alias please='sudo $(history -p !!)'
alias assman='sudo systemctl'
alias gparted='sudo gparted'
alias svim='sudo vim'
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
alias mount='sudo mount'
alias umount='sudo umount'
alias fdisk='sudo fdisk'

# modified functionality (flags, better names, or otherwise)

alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep -n --color=auto'
alias ip='ip -color=auto'
alias hexdump='hexdump -L'
alias fdisk='fdisk -L'
alias valor='valgrind --track-origins=yes'
alias rm='mv -ft $HOME/Trash'
alias del='sudo rm -rf'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias ping='ping -c 4'
alias shutdown='shutdown now'
alias logout='i3-msg exit'
alias calculator="xcalc"
alias clone='git clone'
alias cpp='clang++ -Wall -Werror -Wextra'
alias dicc='diff -C0'
alias xclip='xclip -selection clip'
alias newsh='newscript -sh'
alias newpy='newscript -py3'
alias newrfce='newscript -rfce'
alias amend='git commit -a --amend; git pull; git push'
alias maim='killall -9'
alias mkdir='mkdir -p'

# renamed for easier memory

alias schootar='tar -zxvf'
alias xwinfo='xprop'
alias nut='python $HOME/Downloads/nut-2.6/nut.py'
alias mirrors='sudo reflector --sort age --country US --fastest 20 --protocol https --save /etc/pacman.d/mirrorlist'
alias headphones='bluetoothctl power on; bluetoothctl connect 70:88:6B:90:BF:A6'
alias dbclear='sudo rm /var/lib/pacman/db.lck'

# fun

alias haha="printf '\e[0;31;46mB00B135\e[0m\n'"

# games

alias mtgo='wine $HOME/Desktop/mtgo.exe'
alias minecraft='minecraft-launcher'
alias doom='chocolate-doom -iwad ~/Documents/dos/Doom/DOOM.WAD -window'
alias blipblop='cd $HOME/Documents/games/blip-blop/vc-projects/Blip_n_Blop_3/; ./blipblop; cd -'

# vm/ssh

alias skoger='VBoxManage startvm "skoger ryline" --type headless; ssh Nuthouse'
alias phone='ssh -i ~/.ssh/id_phone -p 8022'

# system related

alias sys-update='repac; aur-update; pip-update; sudo mkinitcpio -P'
alias disk='sudo du -hd1 /'
alias jctl='mate-terminal -t jctl -e "journalctl -f"; asciiquarium'
alias browse='(thunar "$PWD" &>/dev/null & disown)'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias update-clock='timedatectl set-ntp true'

# kubernetes related

alias dockube='eval $(minikube -p minikube docker-env)'

function undockube () {
	export DOCKER_TLS_VERIFY=""
	export DOCKER_HOST=""
	export DOCKER_CERT_PATH=""
	export MINIKUBE_ACTIVE_DOCKERD=""
}

function redeploy () {
	if [ -z "$1" ]; then
		echo "Usage: redeploy <filename>"
		exit
	fi
	kubectl delete -f "$1"
	kubectl apply -f "$1"
}

# complex tasks

function jorb () {
	builtin cd $HOME/projects/Python/learning/scraping
	case $1 in

		CO)
			STATE="Colorado, United States"
			;;
		AB)
			STATE="Alberta, Canada"
			;;
		*)
			STATE="California, United States"
			;;
	esac
	./get_a_job.py -e "internship" -e "entry level" -t full-time -t part-time -t internship -l "$STATE" -u sre
	./get_a_job.py -e "internship" -e "entry level" -t full-time -t part-time -t internship -l "$STATE" -u it
	./get_a_job.py -e "internship" -e "entry level" -t full-time -t part-time -t internship -l "$STATE" -u software engineer
	./open_links.py output/linkedin/$(echo "$STATE" | cut -d, -f1)/sre/$(date -I)/* output/linkedin/$(echo "$STATE" | cut -d, -f1)/"software\ engineer"/$(date -I)/* output/linkedin/$(echo "$STATE" | cut -d, -f1)/it/$(date -I)/*
	cd -
}

function gethex () {
	echo -n "${@}" | hexdump -C | awk 'FNR==1 {for (i=2; i<NF; i++) printf $i " "}'; echo
}

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:pwd:clear:exit:shutdown:reboot:bconf:binit:i3c:xconf:xreload:please"

# Load Angular CLI autocompletion.
source <(ng completion script)
