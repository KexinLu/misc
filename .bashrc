[ -f "$HOME/.beanrc" ] && . "$HOME/.beanrc"

export EDITOR=vim

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




##################SCREEN###################
function ks {
    echo "killing all detached screens"
    screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
    echo "done"
}
##################DOCKER###################
function kad {
    echo "getting ids of all containers"
    ALL_CONTAINERS="$(docker ps -a -q)"
    echo $ALL_CONTAINER
    echo "killing these containers"
    docker stop $ALL_CONTAINERS
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
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 'starting'

        #if1 start

        read -p "Please enter parent branch"
















       #if1 end
    fi
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
clear
}
