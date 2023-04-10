# Deploy Extension
az k8s-extension create -g ESLZ-SPOKE -n vws-app-config -c eslzakscluster --cluster-type managedClusters --extension-type=microsoft.flux

# Deploy Flux configuration
# Front-End
az k8s-configuration flux create -g ESLZ-SPOKE -c eslzakscluster -n vws-app-config --namespace vws-app -t managedClusters --scope cluster -u https://github.com/Welasco/testflux2.git --interval 2m --branch main --kustomization name=vws-app path=./vws-app prune=true sync_interval=2m

# Back-End
az k8s-configuration flux update -g ESLZ-SPOKE -c eslzakscluster -n vws-app-config -t managedClusters -u https://github.com/Welasco/testflux2.git --interval 2m --branch main  --kustomization name=vws-app path=./vws-app prune=true sync_interval=2m --kustomization name=vws-backend path=./vws-backend prune=true sync_interval=2m dependsOn=["vws-app"]



# View cluster settings
k get extensionconfigs -A
k get fluxconfigs -A
k get helmreleases -A
k get -A kustomizations.kustomize.toolkit.fluxcd.io
k get -A gitrepositories.source.toolkit.fluxcd.io

# Delete flux configuration
az k8s-configuration flux delete -g AKS -c vwsaks -n gitops-demo -t managedClusters

#################################################################################################################################################