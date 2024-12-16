# Usage
You can use --check for a dry run
ie: ansible-playbook playbooks/install_k3s.yaml --check
Run the playbooks as needed:
Ininstall: ansible-playbook playbooks/install_k3s.yaml
Uninstall: ansible-playbook playbooks/uninstall_k3s.yaml
Fetch Kubeconfig: ansible-playbook playbooks/fetch_kubeconfig.yaml
Validate Cluster: ansible-playbook playbooks/validate_cluster.yaml

# File structure
k3s-tower-ansible/
├── ansible.cfg
├── inventory/
│   ├── hosts.yaml
│   ├── group_vars/
│   │   ├── all.yaml
│   │   ├── pies.yaml
│   │   ├── masters.yaml
│   │   └── workers.yaml
│   └── host_vars/
│       ├── bootstrapMaster.yaml
│       ├── master1.yaml
│       └── worker1.yaml
├── roles/
│   ├── bootstrap/
│   │   ├── tasks/
│   │   │   ├── main.yaml
│   │   │   └── install.yaml
│   │   └── files/
│   │       └── custom-k3s-install-script.sh
│   ├── masters/
│   │   ├── tasks/
│   │   │   ├── main.yaml
│   │   │   └── install.yaml
│   │   └── templates/
│   │       └── kubeconfig.j2
│   ├── workers/
│   │   ├── tasks/
│   │   │   ├── main.yaml
│   │   │   └── install.yaml
│   └── uninstall/
│       ├── tasks/
│       │   ├── main.yaml
│       │   ├── uninstall_servers.yaml
│       │   ├── uninstall_workers.yaml
│       └── handlers/
│           └── main.yaml
├── playbooks/
│   ├── install_k3s.yaml
│   ├── uninstall_k3s.yaml
│   ├── fetch_kubeconfig.yaml
│   └── validate_cluster.yaml
├── vars/
│   ├── common.yaml
│   └── k3s.yaml
├── files/
│   └── custom-cmdline.txt
└── README.md
