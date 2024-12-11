# Usage
You can use --check for a dry run
ie: ansible-playbook playbooks/install_k3s.yml --check
Run the playbooks as needed:
Ininstall: ansible-playbook playbooks/install_k3s.yml
Uninstall: ansible-playbook playbooks/uninstall_k3s.yml
Fetch Kubeconfig: ansible-playbook playbooks/fetch_kubeconfig.yml
Validate Cluster: ansible-playbook playbooks/validate_cluster.yml

# File structure
k3s-tower-ansible/
├── ansible.cfg
├── inventory/
│   ├── hosts.yml
│   ├── group_vars/
│   │   ├── all.yml
│   │   ├── pies.yml
│   │   ├── masters.yml
│   │   └── workers.yml
│   └── host_vars/
│       ├── bootstrapMaster.yml
│       ├── master1.yml
│       └── worker1.yml
├── roles/
│   ├── cgroups/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   └── enable.yml
│   │   └── handlers/
│   │       └── main.yml
│   ├── bootstrap/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   └── install.yml
│   │   └── files/
│   │       └── custom-k3s-install-script.sh
│   ├── masters/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   └── install.yml
│   │   └── templates/
│   │       └── kubeconfig.j2
│   ├── workers/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   └── install.yml
│   └── uninstall/
│       ├── tasks/
│       │   ├── main.yml
│       │   ├── uninstall_servers.yml
│       │   ├── uninstall_workers.yml
│       └── handlers/
│           └── main.yml
├── playbooks/
│   ├── install_k3s.yml
│   ├── uninstall_k3s.yml
│   ├── fetch_kubeconfig.yml
│   └── validate_cluster.yml
├── vars/
│   ├── common.yml
│   └── k3s.yml
├── files/
│   └── custom-cmdline.txt
└── README.md
