anatida
======

anatida is a chordata component, it sets up [Ansible](http://www.ansible.com) to run at a specified interval (via ansible-pull) for setup/maintenance tasks

getting started
---------------

### setup

fork this repo and change [this line](https://github.com/chordata-mac/anatida/blob/master/com.chordata.anatida.plist#L12) to a git repo of your choosing that has ansible content (a local.yml file is required)

### installation

if [the luggage](https://github.com/unixorn/luggage) is installed you can simply `make pkg`, then use the resulting package on the target machine(s)

more information
----------------

### objectives

*if it swims like a duck and quacks like a duck, it probably is a duck*

Many configuration management systems for Mac have layers of abstraction that hide the tool below. anatida sets up Ansible, runs Ansible, and doesn't hide Ansible from you.

### components

- */Library/LaunchDaemons/***com.chordata.anatida.plist:** runs `anatidaRun` on reboot, and every 10 hours - or on first wake after this. This is also loaded immediately after install via postinstall.
- */usr/local/chordata/***anatidaRun:** pulls the repo (specified as the first argument) and runs ansible using the local.yml file in the repo, it will test for connectivity repeatedly before timing out
- */usr/local/chordata/***anatidaSetup:**
  - ensures that `git` is available, if it isn't then it automatically installs CommandLineTools
  - installs virtualenv via easy_install
  - creates a virtualenv at `/usr/local/chordata/ansible`
  - installs ansible into that virtualenv, ansible commands are found at `/usr/local/chordata/ansible/bin`
- */etc/ansible/facts.d/***mac.fact:** provides additional Mac-specific facts that Ansible lacks.
  - ansible_local.mac.battery.*: info on battery current capacity, cycle count, etc.
  - ansible_local.mac.password_policies.*: all currently set global password policies
  - ansible_local.mac.system_profile.*: all attributes from SPHardwareDataType and SPSoftwareDataType
  - ansible_local.mac.disk.{free_gb|used_gb}: the Mac's '/' drive - free and used space in GB
  - ansible_local.mac.filevault_encrypted: true if FileVault is enabled
  - ansible_local.mac.has_munki: true if munki is found at /usr/local/munki
  - ansible_local.mac.consoleuser: the user currently logged into the GUI when Ansible is running
