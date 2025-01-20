# Hello👋, this repository contains all the boilerplate code that one needs to get started with provisioning

### Goal:
To automate the redundant task of creating virtual machines and then manually sshing into each to install all the necessary dependencies on cloud-providers/hypervisors. In my case, I am using **Proxmox** as my hypervisor.

### Pre - requisits:
- You will need Proxmox up and running on your machine (for obvious reasons 🙂).
- You will also need a well set VM template available on proxmox with all the dependencies you need pre-installed (or you can also use the [install-dependencies.yml](https://github.com/hardiklokwani/provisioning/blob/master/boilerplates/ansible/playbooks/install-dependencies.yml) playbook and configure it according to your needs).
- 
###Creating the Infrastructure with Terraform

#### Step 1: Installing Terraform on the host and create a directory with the main.tf file, consisting all the configurations we need:
Update the [main.tf](https://github.com/hardiklokwani/provisioning/blob/master/boilerplates/terraform/main.tf) file according to your needs and make some changes by adding your token id and secret ! (you can create your own token on the proxmox ui)
```shell
mkdir terraform

cd terraform/

touch main.tf
```
#### Step 2: Once you have configured the file it's time to run the following commands: 
```shell
terraform init     # this will initialize the current directory and let terraform install the plugin you have mentioned in the main.tf file for proxmox

terraform plan     # this command will list out the whole plan and will inform you what it will be doing after we execute our final command

terraform apply    # this command will ask you for a prompt and if you are satisfied with the plan you can type "yes"
```
### And congratulations, you did it !
That's how easy it is, you can change the name of the node in the main.tf file and deploy multiple machines with this single file. Once after making all the changes for a new vm, you can use the :
```shell
terraform init --upgrade
```
command for letting terraform know that you have upgraded the main.tf file.

### Installing dependencies on the Infrastructure with Ansible

#### Step 1: Installing Ansible on the host and create a directory (if not already exists) with the ansible.cfg & inventory files:
```
mkdir /etc/ansible/

cd /etc/ansible/

touch ansible.cfg && touch inventory

mkdir playbooks

cd playbooks/

touch install-dependencies.yml
````

### Step 2: Edit the [ansible.cfg](https://github.com/hardiklokwani/provisioning/blob/master/boilerplates/ansible/ansible.cfg) as per your needs and add all the hosts you want to conrol in the [inventory file](https://github.com/hardiklokwani/provisioning/blob/master/boilerplates/ansible/inventory)

Disclaimer: I am using the key pass method to authenticate my credentials but it is a best practice to do so. The preffered way is to use the ssh key authentication.

### Step 3: Use playbooks to install or uninstall different dependencies:
````
ansible-playbook <file-name> -K          # -K parameter asks you for the internal sudo password to become root for performing certain tasks that require sudo permissions.
````
## and finally we installed all the dependencies needed to keep our machines ready to use out of the box !! 😎




