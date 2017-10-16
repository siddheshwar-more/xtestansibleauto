# Roles
## 1. Altiris Deployment Agent

Run the command 

  `ansible-playbook -i hosts deploy.yml --extra-vars "installerdir=<dir_path>,agent_download_url=<url>,notification_server=<ns_ip>,notification_web=<ns_web>"`

## 2. VNC Setup

Run the command 

  `ansible-playbook -i hosts deploy.yml --extra-vars "installerdir=<dir_path>,agent_download_url=<url>,vnc_pkgname=<pkg_name>"`


