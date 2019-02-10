
## set project id
export PROJECT_ID="$(gcloud config get-value project -q)"

## build
docker build -t gcr.io/${PROJECT_ID}/plumber-app:v1 .

docker images

### run locally
docker run --rm -p 8000:8000 gcr.io/${PROJECT_ID}/plumber-app:v1

### now we can call
curl -X GET "http://localhost:8000/huisprijs?Inhoud=111&PC2=10" -H  "accept: application/json"

## push image
docker push gcr.io/${PROJECT_ID}/plumber-app:v1

## deploy image
kubectl run plumber-web --image=gcr.io/${PROJECT_ID}/plumber-app:v1 --port 8000

#To see the Pod created by the Deployment, run the following command:

kubectl get pods
# expose them now to the internet
kubectl expose deployment plumber-web --type=LoadBalancer --port 80 --target-port 8000

kubectl get service

### now you can go to the external ip address

curl -X GET \
"http://35.204.152.51/huisprijs\
?Inhoud=111&PC2=16?woningtype=EengezinswoningTussenwoning\
&Perceel=120&aantalkamers=5" -H  "accept: application/json"

http://35.204.152.51/huisprijs?Inhoud=111&PC2=16?woningtype=EengezinswoningTussenwoning&Perceel=120&aantalkamers=5

#woningType
 [1] "Benedenwoning"                                   "Bovenwoning"                                    
 [3] "BungalowGeschakeldeWoning"                       "BungalowVrijstaandeWoning"                      
 [5] "DubbelBenedenhuis"                               "EengezinswoningEindwoning"                      
 [7] "EengezinswoningGeschakeldeTweeOnderEenKapWoning" "EengezinswoningGeschakeldeWoning"               
 [9] "EengezinswoningHalfvrijstaandeWoning"            "EengezinswoningHoekwoning"                      
[11] "EengezinswoningTussenwoning"                     "EengezinswoningTweeOnderEenKapWoning"           
[13] "EengezinswoningVrijstaandeWoning"                "Galerijflat"                                    
[15] "HerenhuisHoekwoning"                             "HerenhuisTussenwoning"                          
[17] "HerenhuisTweeOnderEenKapWoning"                  "HerenhuisVrijstaandeWoning"                     
[19] "Maisonnette"                                     "Penthouse"                                      
[21] "Portiekflat"                                     "Portiekwoning"                                  
[23] "Tussenverdieping"                                "VillaTweeOnderEenKapWoning"                     
[25] "VillaVrijstaandeWoning"                          "Other"      
#KoopConditie
[1] "kosten koper" "vrij op naam"


## removing docker images
docker rmi -f ff9539dec777



