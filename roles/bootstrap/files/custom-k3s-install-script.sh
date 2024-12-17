#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
INSTALL_K3S_VERSION=${INSTALL_K3S_VERSION:-"v1.31.3+k3s1"} # Default K3s version if not provided
K3S_ROLE=${K3S_ROLE:-"server"} # Default role (server/agent)
K3S_CLUSTER_INIT=${K3S_CLUSTER_INIT:-"false"} # Cluster init for first master
K3S_NODE_NAME=${K3S_NODE_NAME:-$(hostname)} # Default node name is the hostname
K3S_TOKEN=${K3S_TOKEN:-""} # Token for joining the cluster
K3S_URL=${K3S_URL:-""} # URL of the API server for agents or additional servers
K3S_KUBECONFIG_MODE=${K3S_KUBECONFIG_MODE:-"644"} # Kubeconfig permissions
K3S_EXTRA_ARGS=${K3S_EXTRA_ARGS:-""} # Extra arguments for K3s
K3S_INSTALL_SCRIPT_URL="https://get.k3s.io"

# Functions
print_usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  --role server|agent              Node role (default: server)"
  echo "  --version <version>              K3s version to install (default: v1.31.3+k3s1)"
  echo "  --init                           Initialize the cluster (only for first server)"
  echo "  --token <token>                  Token for joining the cluster"
  echo "  --url <url>                      API server URL for joining a cluster (required for agents)"
  echo "  --name <node_name>               Node name (default: hostname)"
  echo "  --kubeconfig-mode <mode>         Kubeconfig file mode (default: 644)"
  echo "  --extra-args <args>              Additional arguments for K3s"
  echo "  -h, --help                       Show this help message"
}

# Parse Arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --role)
      K3S_ROLE="$2"
      shift 2
      ;;
    --version)
      INSTALL_K3S_VERSION="$2"
      shift 2
      ;;
    --init)
      K3S_CLUSTER_INIT="true"
      shift 1
      ;;
    --token)
      K3S_TOKEN="$2"
      shift 2
      ;;
    --url)
      K3S_URL="$2"
      shift 2
      ;;
    --name)
      K3S_NODE_NAME="$2"
      shift 2
      ;;
    --kubeconfig-mode)
      K3S_KUBECONFIG_MODE="$2"
      shift 2
      ;;
    --extra-args)
      K3S_EXTRA_ARGS="$2"
      shift 2
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      print_usage
      exit 1
      ;;
  esac
done

# Install K3s
if [[ "$K3S_ROLE" == "server" ]]; then
  echo "Installing K3s as a server node..."
  curl -sfL "$K3S_INSTALL_SCRIPT_URL" | INSTALL_K3S_VERSION="$INSTALL_K3S_VERSION" sh -s - server \
    --cluster-init="$K3S_CLUSTER_INIT" \
    --node-name="$K3S_NODE_NAME" \
    --token="$K3S_TOKEN" \
    --kubeconfig-mode="$K3S_KUBECONFIG_MODE" \
    "$K3S_EXTRA_ARGS"
elif [[ "$K3S_ROLE" == "agent" ]]; then
  if [[ -z "$K3S_URL" ]]; then
    echo "Error: --url is required for agent nodes"
    exit 1
  fi
  echo "Installing K3s as an agent node..."
  curl -sfL "$K3S_INSTALL_SCRIPT_URL" | INSTALL_K3S_VERSION="$INSTALL_K3S_VERSION" sh -s - agent \
    --server="$K3S_URL" \
    --node-name="$K3S_NODE_NAME" \
    --token="$K3S_TOKEN" \
    "$K3S_EXTRA_ARGS"
else
  echo "Error: Invalid role specified. Use --role server|agent."
  print_usage
  exit 1
fi

echo "K3s installation complete!"
