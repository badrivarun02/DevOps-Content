Role Name
=========

**Role Description: argocd_install**
As an Argo CD Installation , I developed an Ansible playbook to automate the installation and configuration of Argo CD. Here are the key tasks I accomplished:

1. **Cloning Official Argo CD Repo**:
   - I cloned the official Argo CD repository with a specific version to ensure consistency and reliability.

2. **Installation and Configuration**:
   - Using Ansible, I installed Argo CD on the target environment.
   - I configured it to use a LoadBalancer service type.
   - The service now listens on port 8063.

3. **Admin Password Retrieval**:
   - To retrieve the admin password securely, I implemented a wait statement.
   - The playbook waited until Argo CD was in a running state before fetching the password.

Overall, my role focused on streamlining Argo CD deployment, enhancing security, and ensuring smooth operations. 😊🚀

Requirements
------------

1. Docker and  kubernetes installation 

Role Variables
--------------
### Argo CD version to install
argocd_version: 3.1.9

### URL for the Argo CD installation manifest
argocd_url: "https://raw.githubusercontent.com/argoproj/argo-cd/v{{ argocd_version }}/manifests/ha/install.yaml"

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      become: yes
      roles:
        - ansible_install


