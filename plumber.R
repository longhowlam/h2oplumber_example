#
# This plumber file implements an API for model serving using an already build and
# and saved h2o model. Given some inputs it gives back a model prediction
# 

library(plumber)
library(h2o)

h2o.init()

huismodel = h2o.loadModel("huismodel.h2o/DRF_model_R_1549466039126_1")

#* @apiTitle Longhow's huisprijs engine

#### expose huisprijs model #################################

#* Return the predicted price of a house given its input features
#* @param PC2 eerste twee cijfers postcode, bijv 10 voor Amsterdam
#* @param KoopConditie "kosten koper" of "vrij op naam"
#* @param ouderdom in jaren
#* @param Woonoppervlak in vierkante m
#* @param aantalkamers aantal kamers
#* @param Perceel perceel oppervlakte
#* @param Inhoud inhoud van de woning in m3
#* @param woningtype type woning bv EengezinswoningTussenwoning
#* @get /huisprijs
function(
  PC2 = "11", 
  KoopConditie = "kosten koper", 
  ouderdom = 8,
  Woonoppervlak = 125,
  aantalkamers = 6,
  Perceel = 100,
  Inhoud = 140,
  woningtype = "EengezinswoningTussenwoning" 
){
  t0=proc.time()
  
  mijnhuis = as.h2o(
      data.frame(
        PC2 , 
        KoopConditie , 
        ouderdom = as.numeric(ouderdom),
        Woonoppervlak = as.numeric(Woonoppervlak),
        aantalkamers = as.numeric(aantalkamers),
        Perceel = as.numeric(Perceel),
        Inhoud = as.numeric(Inhoud) ,
        woningBeschrijving  = woningtype
    )
  )
  print(proc.time()-t0)
  
  as.data.frame(predict(huismodel, mijnhuis))
}

