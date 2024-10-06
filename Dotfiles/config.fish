#  _____      ___   ___       _____      
#  _   _| __ / _ \ / _ \ _ __|___ / _ __ 
#   | || '__| | | | | | | '_ \ |_ \| '__|
#   | || |  | |_| | |_| | |_) |__) | |   
#   |_||_|   \___/ \___/| .__/____/|_|   
#                       |_|              
#  Tr00p3r's Dotfiles
#  https://github.com/trooper86/Dottr00p3r
#    士兵    

##My fish config. Not much to see here just some standard stuff by Tr00p3r86.##

##Set fish Dracula theme## 
fish_config theme choose "Dracula Official"

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths

### EXPORT ###
set fish_greeting                # Supresses fish's intro message
set TERM "kitty"                # Sets the terminal type
set EDITOR "nvim"               # $EDITOR use spacevim in terminal
set VISUAL "code"               # $VISUAL use vscode in GUI mode

### SET MANPAGER
### Uncomment only one of these!

### "nvim" as manpager
set -x MANPAGER "nvim +Man!"

### "less" as manpager
# set -x MANPAGER "less"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  #bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Function for printing a column (splits input on whitespace)
# ex: echo 1 2 3 | coln 3
# output: 3
function coln
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

# Function for printing a row
# ex: seq 3 | rown 3
# output: 3
function rown --argument index
    sed -n "$index p"
end

# Function for ignoring the first 'n' lines
# ex: seq 10 | skip 5
# results: prints everything but the first 5 lines
function skip --argument n
    tail +(math 1 + $n)
end

# Function for taking the first 'n' lines
# ex: seq 10 | take 5
# results: prints only the first 5 lines
function take --argument number
    head -$number
end

#Function for man page
function man
    /usr/bin/man $argv; or help $argv
end

### END OF FUNCTIONS ###

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim 
alias vim='nvim'

#emacsclient
alias emacs='emacsclient -c -a 'vim''

# Changing "ls" to "eza"
alias ls='eza -al --color=always --group-directories-first --icons' # my preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.='eza -a | grep -E "^\."'                                  # List only dot files
alias ld='ls -d */'                                                # List only directories

#pacman
alias pacsyu='sudo pacman -Syu'                  # update only standard pkgs
alias pacsyyu='sudo pacman -Syyu'                # Refresh pkglist & update
alias pacss='sudo pacman -Ss'                    # Search only standard pkgs
alias pacs='sudo pacman -S'                      # synchronize and install packages 
alias pacr='sudo pacman -R'                      # remove packages 
alias pacrs='sudo pacman -Rs'                    # remove packages with their dependencies that are not required by any other installed package 
alias pacdd='sudo pacman -Rdd'                   # remove packages without checking for dependencies or prompting for confirmation
alias pacqo='sudo pacman -Qo'                    # query the package database to determine which package owns a specific file
alias pacsii='sudo pacman -Sii'                  # detailed information about all installed packages 
alias clearCache="sudo pacman -Sc"               # clean the package cache
alias search="sudo pacman -Ss"                   # search packages 
alias listorphans='sudo pacman -Qdt'             # lists orhpaned packages
#alias unlock='sudo rm /var/lib/pacman/db.lck'   # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

####AUR yay####
alias yaysua='yay -Sua --noconfirm'            # update only AUR pkgs (yay or paru)
alias yaysyu='yay -Syu --noconfirm'            # update standard pkgs and AUR
alias yaysyyu='yay -Syyu --noconfirm'          # update & sync standard pkgs and AUR
alias yayss='yay -Ss'                         # Search for AUR packages
alias yays='yay -S'                           # install form AUR 
alias yayr='yay -R'                           # remove packages

####AUR Paru####
alias parsua='paru -Sua --noconfirm'            # update only AUR pkgs (yay or paru)
alias parsyu='paru -Syu --noconfirm'            # update standard pkgs and AUR
alias parsyyu='paru -Syyu --noconfirm'          # update & sync standard pkgs and AUR
alias parss='paru -Ss'                         # Search for AUR packages
alias pars='paru -S'                           # install form AUR 
alias parr='paru -R'                           # remove packages

###get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# paru and yay as aur helper - updates everything
alias pursyu="paru -Syu --noconfirm"
alias yaysyu='yay -Syu --noconfirm'

# This will generate a list of explicitly installed packages
alias list="sudo pacman -Qqe"

#This will generate a list of explicitly installed packages without dependencies
alias listt="sudo pacman -Qqet"

# list of AUR packages
alias listaur="sudo pacman -Qqem"

# adding flags
alias df='df -h'                      # human-readable sizes
alias free='free -m'                  # show sizes in MB

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

#add new fonts
alias update-fc='sudo fc-cache -fv'

#see all running services
alias running_services='systemctl --type=service --state=active'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
 
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Play audio files in current dir by type
alias playwav='vlc *.wav'
alias playogg='vlc *.ogg'
alias playmp3='vlc *.mp3'

# Play video files in current dir by type
alias playavi='vlc *.avi'
alias playmov='vlc *.mov'
alias playmp4='vlc *.mp4'

# switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

#Quick edit
alias .brc="$EDITOR ~/.bashrc"
alias cfc="$EDITOR ~/.config/fish/config.fish"
alias nneofetch="$EDITOR ~/.config/neofetch/config.conf"

#alias clr='clear'                            #clear terminal 
#alias neo="neofetch | lolcat
alias cat='bat'
alias neo="neofetch | lolcat -a -s 1150.0 -F 1.0"
#Use man in fish shell
alias man= '/usr/bin/man'

#hardware info --short
alias hw="hwinfo --short"

#audio check pulseaudio or pipewire
alias audio="pactl info | grep 'Server Name'"

#check cpu
alias cpu="cpuid -i | grep uarch | head -n 1"

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#shutdown or reboot
alias sdn="sudo shutdown now"
alias rs="reboot"

# Ranger
alias r="ranger"

##kitty terminal kitten icat alias
alias icat="kitten icat"

#clear
alias cl="clear; seq 1 (tput cols) | sort -R | sparklines | lolcat"        #clear terminal with sparklines | lolcat

# yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

# yt-dlp more aliases #
alias ydl='yt-dlp'
alias ydlmp4='yt-dlp -f "bestvideo&#91;ext=mp4]+bestaudio&#91;ext=m4a]/best&#91;ext=mp4]/best"'
alias ydlmkv='yt-dlp -f "bestvideo&#91;ext=mkv]+bestaudio&#91;ext=mka]/best&#91;ext=mkv]/best"'

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#grub issue 08/2022
#alias install-grub-efi="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi"

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# termbin
alias tb="nc termbin.com 9999"

# the terminal rickroll 
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Mocp must be launched with bash instead of Fish!
alias mocp="bash -c mocp"

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
alias ssh='kitten ssh'

#  ┌─┐┬ ┬┌┬┐┌─┐  ┌─┐┌┬┐┌─┐┬─┐┌┬┐
#  ├─┤│ │ │ │ │  └─┐ │ ├─┤├┬┘ │ 
#  ┴ ┴└─┘ ┴ └─┘  └─┘ ┴ ┴ ┴┴└─ ┴ 

### RANDOM COLOR SCRIPT ###
# Get this script from my GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
colorscript random

#Display Pokemon
#pokemon-colorscripts --no-title -r 1,3,6

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
