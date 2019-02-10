#
# This is a Plumber API. In RStudio 1.2 or newer you can run the API by
# clicking the 'Run API' button above.
#
# In RStudio 1.1 or older, see the Plumber documentation for details
# on running the API.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
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

