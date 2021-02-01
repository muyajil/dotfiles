alias jn="jupyter notebook"
alias vs="code ."
alias jl="jupyter-lab"
alias dps="docker ps --format \"table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}\""
alias dc="docker-compose"
alias mount-dev08-muy="sudo sshfs -o allow_other,default_permissions,IdentityFile=/home/muy/.ssh/id_rsa muy@dev08.ascarix.local:/home/muy/ /home/muy/dev08_home_muy/"
alias mount-srv-srv-user="sudo sshfs -o allow_other,default_permissions,IdentityFile=/home/muy/.ssh/id_rsa srv-user@srv.ajil.ch:/home/srv-user/ /home/muy/srv_home_srv-user/"
alias mount-srv-muy="sudo sshfs -o allow_other,default_permissions,IdentityFile=/home/muy/.ssh/id_rsa muy@srv.ajil.ch:/home/muy/ /home/muy/srv_home_muy/"
alias connect-vpn="sudo openvpn --config /home/muy/immosparrow.ovpn"
