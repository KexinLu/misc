[ -f "$HOME/.beanrc" ] && . "$HOME/.beanrc"
#
export EDITOR=vim
export MYHOMEADD=192.168.1.23
export WorkRoot="$HOME/Workspace/api"
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
 }

 if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
     start_agent;
     }
 else
    start_agent;
fi


###############Aliases and Key##############
alias rc='. ~/.bashrc'
alias api='cd /home/beanuser/Workspace/api'
alias misc='cd /home/beanuser/Workspace/misc'
alias ui='cd /home/beanuser/Workspace/ui'
alias pg='cd /home/beanuser/Workspace/pg'
alias rmg='/home/beanuser/Workspace/mongo/run'
alias rpg='/home/beanuser/Workspace/pg/run'
alias rrd='/home/beanuser/Workspace/redis/run'
alias rapi='/home/beanuser/Workspace/api/docker/run && api && /home/beanuser/Workspace/api/docker/init'

function grepex () {
    grep "$*" ./ -in -R --exclude '*.min.js*'
}

function s () {
    firefox -search "$*"
}

function ff () {
    firefox -private-window $1
}

function gc () {
    google-chrome -incognito $1
}

################SCREEN###################
function ks {
    echo "killing all detached screens"
    screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
    echo "done"
}
##################DOCKER###################
function kad {
    echo "getting ids of all containers"
    ALL_CONTAINERS="$(docker ps -a | grep dev | awk '{print $1}')"
    echo $ALL_CONTAINER
    echo "killing these containers"
    docker kill $ALL_CONTAINERS
    echo "removing all the containers"
    docker rm -v $ALL_CONTAINERS
    echo "done"
}

rd () {
    if [ -z "$1" ]
    then
        echo "No argument supplied"
    fi
}

rebase () {

    echo
    echo
    echo
    echo
    echo '██████╗ ███████╗██████╗  █████╗ ███████╗███████╗'
    echo '██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝'
    echo '██████╔╝█████╗  ██████╔╝███████║███████╗█████╗  '
    echo '██╔══██╗██╔══╝  ██╔══██╗██╔══██║╚════██║██╔══╝  '
    echo '██║  ██║███████╗██████╔╝██║  ██║███████║███████╗'
    echo '╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝'
    echo
    echo
    echo
    echo
    read -p "Sure you want to rebase? (y/n) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]];
    then
        echo 'starting'

        #if1 start

        read -p "Please enter parent branch"

        if ${REPLY+x};
        then
            echo '$REPLY'
        fi
       #if1 end
    fi
    echo 'something'
}

function sdkr {

./pg/run
./mongo/run
./redis/run
cd api
rm -rf ./docker
cp -rf ../docker .
./docker/run && ./docker/init
cd ..
cd ui
./docker/run
../nginx/run
docker ps
}

function ds {
./shell
./docker/shell
}

function json {
xargs python -m json.tool
}
#############
#python -m json.tool
#setxkbmap -option caps:escape
#select table_name from information_schema.columns where column_name = 'last_modified';
