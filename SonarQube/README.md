# SonarQube Automation Scripts

This repository contains automation scripts for the installation and uninstallation of SonarQube and its dependencies, including Java, unzip, acl, and PostgreSQL. The scripts are written as Ansible playbooks, providing a simple and efficient way to manage your SonarQube setup.
## Prerequisites

1. **Operating System**: Ubuntu installed on either a local system or a Virtual Machine (VM). The VM can be hosted on any cloud platform such as AWS, Azure, or GCP. The instance should have at least 2 GB of RAM and 1 CPU.

2. **Software Requirements**: Java-17, Unzip, and acl must be installed on the system.

3. **Database**: Postgres Version 9.3 or higher is required. Alternatively, other open-source databases can also be used.

4. **User and Port Configuration**: All SonarQube processes should run as a non-root user (preferably 'sonar') with sudo/administrator privileges. Ensure that port 9000 is open in the firewall settings.

## Features

- **Secure Credential Management**: The scripts use Ansible Vault to securely manage the credentials for the PostgreSQL user. This ensures that sensitive information is kept secure while still being easily accessible for the playbook.

- **Modular Design**: Each dependency has its own dedicated role within the playbook. For example, there are separate roles for installing and uninstalling Java (`java_install` and `java_uninstall`), managing simple packages like unzip and acl (`simplepkg`), and managing PostgreSQL (`postgres_install`). This modular design makes the scripts easy to understand and maintain.

- **Complete Uninstallation**: In addition to installing SonarQube and its dependencies, the scripts also provide a complete uninstallation process through the `sonarqube_uninstall` role. This allows you to easily clean up your system if needed.

## Usage

1. Clone this repository using the following command:

    ```
    git clone https://github.com/badrivarun02/DevOps-Content.git
    ```

2. Navigate to the directory containing the playbook:

    ```
    cd /DevOps-Content/SonarQube
    ```

3. Run the `maininstall.yml` playbook to install SonarQube and its dependencies:

    ```
    ansible-playbook --vault-password-file pss.txt maininstall.yml  -i inventory.yml
    ```

4. Run the `mainuninstall.yml` playbook to uninstall SonarQube and its dependencies:

    ```
    ansible-playbook mainuninstall.yml -i inventory.yml
    ```

5. You can check the status of SonarQube and PostgreSQL at any time using the following commands:

      
        sudo systemctl status sonar #one more service file - sonarext instead of sonar
      
        sudo systemctl status postgresql
      
     
  

 ## Reference links:
      
      1. https://linux.how2shout.com/how-to-install-sonarqube-on-ubuntu-22-04-lts-server/#5_Create_a_database_for_Sonar
      2. https://www.coachdevops.com/2020/04/install-sonarqube-on-ubuntu-how-to.html
      3. https://www.postgresql.org/download/linux/ubuntu/
      4. https://devopscube.com/setup-and-configure-sonarqube-on-linux/
      5. https://www.howtoforge.com/how-to-install-sonarqube-on-ubuntu-22-04/
      6. https://www.fosstechnix.com/how-to-install-sonarqube-on-ubuntu-22-04-lts/
      7. https://dev.to/oayanda/bash-script-sonarqube-and-postgres-database-setup-for-code-analysis-43i0
      8. Bing_AI 
