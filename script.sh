az k8s-configuration flux create -g AKS -c vwsaks -n gitops-demo --namespace vws-app -t managedClusters --scope cluster -u https://github.com/Welasco/testflux2.git --branch main  --kustomization name=vws-app path=./vws-app prune=true

