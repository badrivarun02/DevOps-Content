# 📝 **Prerequisites for Installing Ansible**

 - 💻 To install Ansible, you need a UNIX-like machine with **Python 3.9** or **newer**.
 - 🖥️ This includes systems like **Red Hat**, **Debian**, **Ubuntu**, **macOS**, **BSDs**, and **Windows with WSL.**
 - 🐍 The machine you want to manage with Ansible doesn't need Ansible installed, but it needs **Python 2.7** or **Python 3.5 - 3.11**.
 - 🔑 The machine you want to manage also needs a user account that can SSH to it.


## 📝 **Install Ansible on WSL Ubuntu using a Bash Script**

🔧 You can install Ansible on WSL Ubuntu using a bash script. Here is an example script that you can use:
    
    #!/bin/bash
    #Update the system
    sudo apt update
    
    #Add the Ansible repository
    sudo apt-add-repository ppa:ansible/ansible
    
    #Install Ansible
    sudo apt install ansible
    
    #Install python-pip and libssl-dev
    sudo apt-get install -y python3-pip libssl-dev

💾 Save the script in a file with the extension .sh, such as filename.sh. This script will update the system, add the Ansible repository, and install Ansible along with the required dependencies.
🏃‍♂️ You can make the script executable by running the command **chmod +x filename.sh**, and then run it using **./filename.sh**.


### **Referrence links:**
      1. https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu
