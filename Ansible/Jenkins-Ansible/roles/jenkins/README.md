Jenkins
=========
The jenkins role is a pre-defined role in Ansible that can be used to install and configure Jenkins on local or remote hosts. It includes tasks for installing dependencies, downloading and installing the Jenkins package, configuring the firewall, and setting up the Jenkins service. Using this role makes it easy to set up Jenkins on multiple hosts in a consistent and repeatable manner.

**NOTE**: Actually code in place of """/roles/jenkins/task/main.yaml"""

Example Playbook
----------------
 an example of how you can use the jenkins role in a playbook without specifying any variables or dependencies:
 
 Method1:
        
        - name: Deploy Jenkins using role on localhost
          hosts: localhost
          become: true
          roles:                 
            - jenkins                

 Method2: Using ""include_role" as we see in our playbook ""mainplaybook.yml"




