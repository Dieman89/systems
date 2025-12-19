{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Kubernetes
    kubectl
    kubernetes-helm

    # AWS
    awscli2
    granted
  ];
}
