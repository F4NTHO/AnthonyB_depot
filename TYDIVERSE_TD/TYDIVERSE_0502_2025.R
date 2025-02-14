install.packages("tidyr")

############################################################################
############################################################################
###################  ANALYSES - INDICATEURS  ###############################
############################################################################
############################################################################

## Date : 15/11/2024 
## Auteur : ANTHONY BARRET

##########################################################################
########################### Fonction utiles ##############################
##########################################################################


library(tidyverse)
library(dplyr)
library(readxl)


#%>% ça c'est un pipe
#|> #ça c'est un pipe classique
#read_excel() ça permet de lire un excel 
#select() avec start_with() par exemple
#filter()
#mutate()
#fct_recode()
#group_by_()
#summarise()
#left_join() right_join() inner_join() full_join()
#pivot_longer() pivot_wider()
# ...


##########################################################################
########################### Import #######################################
##########################################################################

Sites <- read_excel("C:/Users/Fanto/OneDrive/Bureau/OPEN/EXERCICES_TD/TD_GIT/AnthonyB_depot/TYDIVERSE_TD/Sites.xlsx")
Microorga <- read_excel("C:/Users/Fanto/OneDrive/Bureau/OPEN/EXERCICES_TD/TD_GIT/AnthonyB_depot/TYDIVERSE_TD/Microorganismes.xlsx")
Nematodes <- read_excel("C:/Users/Fanto/OneDrive/Bureau/OPEN/EXERCICES_TD/TD_GIT/AnthonyB_depot/TYDIVERSE_TD/Nematodes.xlsx")
Vers <- read_excel("C:/Users/Fanto/OneDrive/Bureau/OPEN/EXERCICES_TD/TD_GIT/AnthonyB_depot/TYDIVERSE_TD/Lombrics.xlsx")

##########################################################################
######################### Jointure de tables #############################
##########################################################################
########### CONSIGNE : Choisir deux communauté biologique ###########
Sites %>%
  inner_join(.,Microorga,join_by(ID)) %>%
  inner_join(.,Nematodes,join_by(ID)) -> SiteMN



#####Nematodes##########################################################################
################## Sélection de lignes et colonnes ##################
##########################################################################
########### CONSIGNE : Choisir un site ###########

SiteMN %>%
  filter(SITE =="Feucherolles") %>%
  select(SITE:REPET_BLOC,ARGILE,contains("SABLE"),ends_with("MIN")) -> feMN


SiteMN %>%
  filter("Gotheron"==SITE) -> siteMN_Goth


#On va faire du select. On va conserver en Nem_bac que les ID et les bacteries par exemple
Nematodes %>%
  select(ID,BACT) -> Nem_bac

#On peut même faire un "-c()" pour retirer ce qu'on souhaite
Nematodes %>%
  select(-c(PHYTO,FONG,OMNI,CARNI)) -> Nem_bac2

##########################################################################
####################### Créer des variables ##################
##########################################################################
#
siteMN_Goth %>%
  mutate(
    Region = "AURA",
    JSP = 8
  ) -> siteMN_Goth_Var

##########################################################################
############################## Calculs par groupe ########################
##########################################################################
########### CONSIGNE : calculs sur plusieurs variables en même temps######

#Calculer sur plusieurs variables en même temps avec un C/N

siteMN_Goth_Var %>%
  mutate(rappportCN = C_MIN/N_MIN) -> siteMN_Goth_var_resul




##########################################################################
######################## Pivots ##########################################
##########################################################################

#Exemple de pivot_longer
siteMN_Goth_var_resul_pvl <- pivot_longer(siteMN_Goth_var_resul, cols= starts_with("LIMON_"), values_to = "amount" , names_to = "LIMON")
#Là il y avait plusieurs fois LIMON_QQCH alors là on rassemble tout dans une colonne LIMON et on met tous les types de LIMON qui étaient des colonnes dans la colonne LIMON

siteMN_Goth_var_resul_nem <- pivot_longer(siteMN_Goth_var_resul, cols= PHYTO:CARNI, values_to = "biomass" , names_to = "type")

#Exemple de pivot_wider
#Bon là y a beaucoup de données donc on va d'abord faire un raccourcissement de données
siteMN_Goth_var_resul %>%
  filter(VARIETE =="Ariane") -> siteMN_Goth_var_resul_AR

siteMN_Goth_var_resul_pvw <- siteMN_Goth_var_resul_AR %>% pivot_wider(names_from = Modalite, values_from = ID )
#A l'origine la colonne "Modalite" contenait "GORA", "GOBA", "GOEA" et là ça va devenir 3 colonnes et les ID vont devenir les individus correspondants. 

siteMN_Goth_var_resul_pvwnem <- siteMN_Goth_var_resul_nem %>% pivot_wider(names_from = type, values_from = biomass )

##########################################################################
####################### Graphique ########################
##########################################################################
########### CONSIGNE : un graphique en modifiant l'ordre et en recodant des modalités

ggplot(siteMN_Goth_var_resul_nem, aes(x = fct_reorder(type, biomass, .fun = median), y = biomass, fill = type)) +
  geom_boxplot() +
  labs(title = "Distribution de la biomasse par type de Nématodes",
       x = "Type de Nématodes",
       y = "Biomasse") +
  theme_minimal() +
  scale_fill_brewer(palette = "Pastel1")



##########################################################################
####################### Enchaîner tous les traitements ###################
##########################################################################




