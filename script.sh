az k8s-configuration flux create -g AKS -c vwsaks -n gitops-demo --namespace vws-app -t managedClusters --scope cluster -u https://github.com/Welasco/testflux2.git --branch main  --kustomization name=vws-app path=./vws-app prune=true

k get extensionconfigs -A
k get fluxconfigs -A
k get helmreleases -A
k get -A kustomizations.kustomize.toolkit.fluxcd.io
k get -A gitrepositories.source.toolkit.fluxcd.io

az k8s-configuration flux update -g AKS -c vwsaks -n gitops-demo -t managedClusters --sync-interval 2m

az k8s-configuration flux create -g flux-demo-rg -c flux-demo-arc -n gitops-demo --namespace gitops-demo -t connectedClusters --scope cluster -u https://github.com/fluxcd/flux2-kustomize-helm-example --branch main  --kustomization name=infra path=./infrastructure prune=true --kustomization name=apps path=./apps/staging prune=true dependsOn=["infra"]

az k8s-configuration flux update -g AKS -c vwsaks -n gitops-demo -t managedClusters -u https://github.com/Welasco/testflux2.git --sync-interval 2m --branch main  --kustomization name=vws-app path=./vws-app prune=true --kustomization name=vws-backend path=./vws-backend prune=true dependsOn=["vws-app"]

# az k8s-configuration flux update -g AKS -c vwsaks -n gitops-demo -t managedClusters -u https://github.com/Welasco/testflux2.git --sync-interval 2m --branch main  --kustomization name=vws-app path=./vws-app prune=true syncIntervalInSeconds=120 --kustomization name=vws-backend path=./vws-backend prune=true dependsOn=["vws-app"]
# Look for a flux reconcile for AKS
# flux reconcile source git -n vws-app vws-app

az k8s-configuration flux kustomization update -g AKS -c vwsaks -n gitops-demo -t managedClusters -k vws-app --interval 2m
az k8s-configuration flux kustomization update -g AKS -c vwsaks -n gitops-demo -t managedClusters -k vws-backend --interval 2m