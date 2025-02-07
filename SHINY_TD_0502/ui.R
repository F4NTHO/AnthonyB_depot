#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(dplyr)

interface2 <- fluidPage(
#Permet de créer un second onglet
  titlePanel("On fait des tests pour comprendre"),
  
  tabsetPanel(
    tabPanel(
      "premier onglet",
      HTML("Première partie de code <strong> En gras car plus méchant </strong>, et hop plus gras.")
    ),
    tabPanel(
      "deuxième onglet",
      HTML("Un autre code qu'on pourrait rajouter. On va tenter de faire un texte assez long pour voir si ça décale le graphique qu'on a généré en dessous. Bon je pense que ça va être long donc je vais faire une successions de A. AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
      h4(span("Là c'est un texte coloré", style = "color: red;"))  
      )
  ),
#DECORTICAGE APPLI  
  titlePanel("Deuxième application : les contrôles"),
  
  sidebarPanel(
    #SliderInput = créer un input sous forme de curseur gradué 
    
    sliderInput("limites_x", "Limites de l'axe des X",min = 0, max = 7, value = c(0, 7)),
    sliderInput("limites_y", "Limites de l'axe des Y",min = 0, max = 25, value = c(0, 25)),
    sliderInput("taille_points", "Taille des points", min=0, max = 10, value = 1),
    
    #Création
    radioButtons(
      "type_lissage",
      "Type de lissage",
      choices = list("Régression" = "lm","Loess" = "loess"),
      selected = "lm"
    ),
    
    textInput("titre", "Titre du graphique", value = "Entrez votre titre ici"),
    checkboxGroupInput(
      "groupes",
      "Quel groupes voulez-vous afficher?",
      choices = list(
        "Herbivores" = "herbi",
        "Carnivores" = "carni",
        "Omnivores" = "omni",
        "Insectivores" = "insecti",
        "Vegan" = "vegan"
      ),
      selected = c("carni","herbi","omni","insecti", "vegan")
    )
  ),
  
  mainPanel(
    plotOutput(outputId = "graphique")
  )
  
)






##### BASE
  #  sidebarLayout(
      #  sidebarPanel(
        #    sliderInput("bins",
                       # "Number of bins:",
          #              min = 1,
           #            max = 50,
            #            value = 30)
    #    ),

        # Show a plot of the generated distribution
     #   mainPanel(
         #   plotOutput("distPlot")
     #   )
#    )
#)
