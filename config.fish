# config.fish
# Fish equivalent of .bashrc — adapted from zachbrowne.me base config

if status is-interactive
    # Starship prompt — install from https://starship.rs
    if type -q starship
        starship init fish | source
    end
end

#######################################################
# PATH & ENVIRONMENT
#######################################################

fish_add_path $HOME/.dotnet/tools
fish_add_path /opt/mssql-tools/bin

set -gx REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt
set -gx DOTNET_ROOT /usr/share/dotnet
set -gx EDITOR nvim
set -gx VISUAL nvim

# Colored man pages via less
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;31m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;44;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[01;32m'

#######################################################
# GENERAL ALIASES
#######################################################

# Safer / friendlier defaults
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'
alias grep='grep --color=auto'

# Edit this config
alias efrc='edit ~/.config/fish/config.fish'

# Date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Directory navigation
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd -'
alias rmd='/bin/rm --recursive --force --verbose'

# ls variants
alias la='ls -Alh'
alias ls='ls -aFh --color=always'
alias lx='ls -lXBh'
alias lk='ls -lSrh'
alias lc='ls -lcrh'
alias lu='ls -lurh'
alias lr='ls -lRh'
alias lt='ls -ltrh'
alias lm='ls -alh | more'
alias lw='ls -xAh'
alias ll='ls -Fls'
alias labc='ls -lap'
alias lf="ls -l | grep -v '^d'"
alias ldir="ls -l | grep '^d'"

# chmod shortcuts
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search
alias h='history | grep'
alias p='ps aux | grep'
alias f='find . | grep'
alias topcpu='/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias checkcommand='type -t'

# Archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Disk / filesystem
alias diskspace='du -S | sort -n -r | more'
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Network
alias openports='netstat -nape --inet'
alias ipview="netstat -anpl | grep :80 | awk '{print \$5}' | cut -d: -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Misc
alias sha1='openssl sha1'
alias sha256='openssl sha256'
alias logs='sudo find /var/log -type f -exec file {} \; | grep text | cut -d: -f1 | grep -v [0-9]$ | xargs tail -f'
alias alert='notify-send --urgency=low -i (test $status -eq 0 && echo terminal || echo error) (history | tail -n1 | sed -e "s/^\s*[0-9]\+\s*//" -e "s/[;&|]\s*alert\$//")'
alias web='cd /var/www/html'

#######################################################
# GIT ALIASES
#######################################################

alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git pull'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gm='git merge'
alias grb='git rebase'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias glog='git log --oneline --graph --decorate'
alias gloga='git log --oneline --graph --decorate --all'
alias grs='git reset'
alias grsh='git reset --hard'
alias gclean='git clean -fd'

#######################################################
# FUNCTIONS
#######################################################

# Use best available editor
function edit
    if type -q nvim
        nvim $argv
    else if type -q jpico
        jpico -nonotice -linums -nobackups $argv
    else if type -q nano
        nano -c $argv
    else if type -q pico
        pico $argv
    else
        vim $argv
    end
end

function sedit
    if type -q nvim
        sudo nvim $argv
    else if type -q jpico
        sudo jpico -nonotice -linums -nobackups $argv
    else if type -q nano
        sudo nano -c $argv
    else if type -q pico
        sudo pico $argv
    else
        sudo vim $argv
    end
end

# Create directory and cd into it
function mkdirg
    mkdir -p $argv[1]
    cd $argv[1]
end

# Copy and cd to destination
function cpg
    if test -d $argv[2]
        cp $argv[1] $argv[2] && cd $argv[2]
    else
        cp $argv[1] $argv[2]
    end
end

# Move and cd to destination
function mvg
    if test -d $argv[2]
        mv $argv[1] $argv[2] && cd $argv[2]
    else
        mv $argv[1] $argv[2]
    end
end

# Go up N directories
function up
    set -l d ""
    for i in (seq 1 $argv[1])
        set d "$d/.."
    end
    cd $d
end

# Search text in all files under current dir
function ftext
    grep -iIHrn --color=always $argv[1] . | less -r
end

# Extract any archive
function extract
    for archive in $argv
        if test -f $archive
            switch $archive
                case '*.tar.bz2'
                    tar xvjf $archive
                case '*.tar.gz'
                    tar xvzf $archive
                case '*.bz2'
                    bunzip2 $archive
                case '*.rar'
                    rar x $archive
                case '*.gz'
                    gunzip $archive
                case '*.tar'
                    tar xvf $archive
                case '*.tbz2'
                    tar xvjf $archive
                case '*.tgz'
                    tar xvzf $archive
                case '*.zip'
                    unzip $archive
                case '*.Z'
                    uncompress $archive
                case '*.7z'
                    7z x $archive
                case '*'
                    echo "Don't know how to extract '$archive'"
            end
        else
            echo "'$archive' is not a valid file"
        end
    end
end

# Returns last 2 path components of cwd
function pwdtail
    pwd | awk -F/ '{nlast = NF -1; print $nlast"/"$NF}'
end

# Show current distribution
function distribution
    if test -r /etc/rc.d/init.d/functions
        echo redhat
    else if test -r /etc/rc.status
        echo suse
    else if test -r /lib/lsb/init-functions
        echo debian
    else if test -r /etc/init.d/functions.sh
        echo gentoo
    else if test -s /etc/mandriva-release
        echo mandriva
    else if test -s /etc/slackware-version
        echo slackware
    else
        echo unknown
    end
end

# Show OS version info
function ver
    set -l dtype (distribution)
    switch $dtype
        case redhat
            test -s /etc/redhat-release && cat /etc/redhat-release && uname -a || cat /etc/issue && uname -a
        case suse
            cat /etc/SuSE-release
        case debian
            lsb_release -a
        case gentoo
            cat /etc/gentoo-release
        case mandriva
            cat /etc/mandriva-release
        case slackware
            cat /etc/slackware-version
        case '*'
            test -s /etc/issue && cat /etc/issue || echo "Error: Unknown distribution"
    end
end

# Install support tools for this config
function install_config_support
    set -l dtype (distribution)
    switch $dtype
        case redhat
            sudo yum install multitail tree joe
        case suse
            sudo zypper install multitail tree joe
        case debian
            sudo apt-get install multitail tree joe
        case gentoo
            sudo emerge multitail tree joe
        case mandriva
            sudo urpmi multitail tree joe
        case '*'
            echo "Unknown distribution — install multitail, tree, joe manually"
    end
end

# IP lookup
function whatsmyip
    echo -n "Internal IP: "
    /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'
    echo -n "External IP: "
    curl -s http://smart-ip.net/myip
    echo
end
alias whatismyip='whatsmyip'

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    fish_add_path $PNPM_HOME
end

# rot13
function rot13
    if test (count $argv) -eq 0
        tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    else
        echo $argv | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    end
end

# Trim leading/trailing whitespace
function trim
    string trim $argv
end
