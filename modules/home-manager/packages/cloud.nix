{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Kubernetes
    kubectl
    kubernetes-helm
    k9s
    kubectx
    stern
    kustomize

    # GitOps
    argocd
    fluxcd

    # Infrastructure
    terraform

    # Security
    trivy
    nmap

    # Container tools
    dive

    # Encryption
    age

    # AWS
    awscli2
    granted

    # HTTP client
    httpie
  ];
}
