# Roles
## 1. Altiris Deployment Agent

Run the command 

  `ansible-playbook -i hosts deploy.yml --extra-vars "installerdir=<dir_path>,agent_download_url=<url>,notification_server=<ns_ip>,notification_web=<ns_web>"`

## 2. VNC Setup

Run the command 

  `ansible-playbook -i hosts deploy.yml --extra-vars "installerdir=<dir_path>,agent_download_url=<url>,vnc_pkgname=<pkg_name>"`

## 3. UDC Setup on SUSE

Run the command

  `ansible-playbook -i hosts suse_deploy_udc.yml --extra-vars "installerdir=<dir_path>,agent_download_url=<url>,java_download_url=<pkg_name>"`


Note- `roles/suse_setup_ucd/tasks/main.yml` file contains the tasks to clone the git repo

```
- name: "clone Git repo"
  git:
     repo: "{{ repo_url }}"
     dest: "{{ repo_dest_path }}"
     key_file: "{{ git_ssh_key }}"

```
Includes varibles - `repo_url, repo_dest_path, git_ssh_key` Can be passed from above `--extra-vars` option

## 3. UDC Setup on windows

Run the command

  `ansible-playbook -i hosts win_deploy_udc.yml --extra-vars "installerdir=<dir_path>,agent_download_url=<url>,java_download_url=<pkg_name>"`

Note- `roles/win_setup_ucd/tasks/main.yml` file contains the tasks to clone the git repo

```
- name: "clone Git repo"
  git:
     repo: "{{ repo_url }}"
     dest: "{{ repo_dest_path }}"
     key_file: "{{ git_ssh_key }}"

```
Includes varibles - `repo_url, repo_dest_path, git_ssh_key`. Can be passed from above `--extra-vars` option

