# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi
alias la="ls -lash --color"
alias ll="ls -lsh --color"
alias lssR="ls -lRa | grep ^- | sort -nr -k 5 | more"
alias lss="ls -la | grep ^- | sort -nr -k 5 | more"
alias e="exit"
alias sluta="history >> ~/commands.txt && exit" 
xrdb -merge $HOME/.Xdefaults



if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function ff() { find . -name '*'$1'*' ; }                 # find a file
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }  # find a file and run $2 on it 
function fstr() # find a string in a set of files
{
    if [ "$#" -gt 2 ]; then
        echo "Usage: fstr \"pattern\" [files] "
        return;
    fi
    SMSO=$(tput smso)
    RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print | xargs grep -sin "$1" | \
sed "s/$1/$SMSO$1$RMSO/gI"
}

function ii()   # get current host related info
{
    echo -e "\nYou are logged on ${red}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${red}Users logged on:$NC " ; w -h
    echo -e "\n${red}Current date :$NC " ; date
    echo -e "\n${red}Machine stats :$NC " ; uptime
    echo -e "\n${red}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${red}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${red}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo
}

function dirsize(){
find "$@" -maxdepth 1 -type d -print0 | xargs -0 du -s;}
