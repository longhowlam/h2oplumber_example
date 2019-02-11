# h2oplumber_example

Some files needed to deploy an R h2o home value model with R plumber on GCP. The scripts in this repo will do the following:
* create a GKE cluster on GCP (CreateKubernetesCluster.sh)
* Set up the plumber API (plumber.R)
* create docker image (Dockerfile)
* build, push docker image and create services (CreateDocker_plumber_and_Deploy.sh)

We asume the model is already created in R h2o, and saved with h2o.saveModel in R