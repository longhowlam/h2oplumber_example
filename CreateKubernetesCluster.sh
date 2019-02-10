########### install kubernetes cluster ############################

## create
gcloud container clusters create myfirst-cluster --preemptible

## get access 
gcloud container clusters get-credentials myfirst-cluster

## see the cluster
gcloud container clusters list
gcloud compute instances list

## make sure docker can push images
gcloud auth configure-docker

### stop or delete cluster, in order to stop incuring costs
gcloud container clusters delete myfirst-cluster
