    #!/bin/bash
    #Update the system
    sudo apt update

    #Add the Ansible repository
    sudo apt-add-repository ppa:ansible/ansible

    #Install Ansible
    sudo apt install ansible

    #Install python-pip and libssl-dev
    sudo apt-get install -y python3-pip libssl-dev
