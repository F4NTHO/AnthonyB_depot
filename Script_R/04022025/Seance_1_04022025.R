# des graphiques

iris


#Graphics de Rbase
hist(iris$Sepal.Length)

plot(iris$Petal.Length, iris$Petal.Width)
#C est une fonction generique car on peut fournir d'autres entrées
boxplot(iris$Petal.Length~ iris$Species)
plot(iris$Petal.Length~ iris$Species) #refait un boxplot car c est logique pour lui

points(iris$Petal.Length[iris$Species=="setosa"],
      iris$Petal.Width[iris$Species=="setosa"],
      col="red", pch=16)

#stripchart(iris$Petal.Length~ iris$Species)

par(mfrow=c(1,2))
boxplot(iris$Petal.Length~ iris$Species)
stripchart(iris$Petal.Length~ iris$Species)

## ggplot2
#install.packages("ggplot2")

library(ggplot2)


#premier section donnée donc data= facul
#mapping : lien entre x et y

ggplot(data=iris, mapping= aes(x=Species, y=Sepal.Length))+
  geom_boxplot()


ggplot(data=iris, mapping= aes(x=Species, y=Sepal.Length,
                               fill=Species))+
  geom_boxplot()

ggplot(data=iris, mapping= aes(x=Species, y=Sepal.Length,
                               fill=Species))+
  geom_boxplot()+
  theme_minimal()


ggplot(data=iris, mapping= aes(x=Sepal.Length, fill=Species))+
  geom_histogram(bins=10)+
  theme_minimal()+
  facet_grid(rows=vars(Species))
#bins permet de définir le nombre de bar 



ggplot(data=iris, mapping= aes(x=Petal.Length, y=Petal.Width))+
  geom_point()+
  theme_light()+
  facet_grid(rows=vars(Species))

ggplot(data=iris, mapping= aes(x=Petal.Length, y=Petal.Width))+
  geom_point()+
  geom_smooth()+
  theme_light()


ggplot(data=iris, mapping= aes(x=Petal.Length, y=Petal.Width))+
  geom_point()+
  geom_smooth(method="lm")+
  theme_light()


ggplot(data=iris, mapping= aes(x=Petal.Length, y=Petal.Width, group=Species))+
  geom_point()+
  geom_smooth(method="lm")+
  theme_light()



ggplot(data=iris, mapping= aes(x=Petal.Length, y=Petal.Width, group=Species))+
  geom_point()+
  geom_smooth(method="lm", aes(colour=Species))+
  theme_light()


########################################################
########################################################
######### EXERCICE TD 
#install.packages("dplyr")
library(dplyr)
data("starwars")
head(starwars)

#Là on dit abscisse espèces et ordonné les masses)
ggplot(starwars, aes(x = species, y = mass, fill = species)) +
  geom_jitter(aes(color= species), width = 0.2, size = 3, alpha=0.7)+
  #là on mets un titre au graphique)
  ggtitle("Analyse de la masse des personnages de Star Wars")+
  #un sous titre
  labs(subtitle= "Comparaison par espèce",
  #On créer des espaces 
  x = "Espèce", y = "Masse (kg)")+
  theme_minimal(base_size = 14)+
  theme(axis.text.x = element_text(angle=45, hjust =1, face="bold",color="white"),
  axis.text.y = element_text(face="bold", color= "white"),
  plot.background = element_rect(fill = "black"),
  panel.background = element_rect(fill="black"),
  legend.background = element_rect(fill="gray20"),
  legend.text = element_text(color = "white"),
  legend.title = element_text(face = "bold", color= "white"),
  plot.title = element_text(face = "bold", size = 20, color = "gold"),
  plot.subtitle = element_text(face = "italic", size = 14, color = "gold"))
  

