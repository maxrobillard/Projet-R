# Visualisation de la corrélation entre le nombre d'accidents de la route et de la consommation d'alcool

## Table des matières

 - [Introduction](#Introduction)
 - [User's Guide](#users-Guide)
 - [Developer's Guide](#developers-Guide)
 - [Rapport d'analyse](#rapport-danalyse)
 - [Lien vers les datasets](#lien-vers-les-datasets)
 - [Instructions d'execution](#instructions-dexecution)





# Introduction
Tous les ans, de jeunes conducteurs sont victimes d'accidents de la route, ce dashboard cherchera à savoir si la consommation d'alcool des jeunes influe sur ce nombre d'accidents.



# User's Guide
Tout d'abord, installer le logiciel RStudio,
Afin d'exécuter sans erreur ce code, il faudra installer tous les packages suivants dans la console de Rstudio à l'aide de la commande install.packages('nom_package') :
Liste des librairies/packages utilisés :
- shiny,
- tidyverse,
- ggplot2,
- gapminder,
- ggmap,
- dplyr,
- rworldmap,
- viridis,
- shinydashboard,
- riskyr,
- leaflet

Une fois les packages installés vous devez lancer l'application en cliquant sur 'Run App'dans RStudio.




# Developer's Guide
Ce guide mentionnera l'architecture et les fonctions utiles du projet ainsi que de potentielles pistes de développement.

### L'architecture du projet :
Le projet se décompose en 3 sous-dossiers qui sont server, ui, global.
- **server.R** (gère les outputs et les intéractions avec les différents menus)
- **ui.R** (gère l'organisation de l'application)
- **global.R** (gère l'appel des bases de données et leur manipulation, ainsi que la déclaration de fonctions)

### Les différentes fonctions présentes dans le projet :
DataYear : permet de sélectionner une partie du dataset en fonction de l'année sélectionnée. Prend en paramètre le dataset voulu et l'année selectionnée.
ContinentFrancais : permet de retourner le nom et les coordonnées du continent sélectionné. Prend en paramètre une string.



### Pistes de développement :

Il serait intéressant de trouver et d'afficher les différentes données dans les mêmes périodes de temps (entre 2000 et 2016), afin de mieux remarquer une possible corrélation.<br>
Une autre disposition des pages pourraient amener un éclaircissement de la pensée, cependant celui que nous avons choisi nous semblait le plus pertinent pour avoir l'ensemble des données par catégorie sur la même page.

# Rapport d'analyse
En réalisant ce dashboard nous avons cherché à mettre en valeur une potentielle corrélation entre la consommation d'alcool et le nombre d'accident de la route chez les jeunes.
Pour ce faire, nous avons regroupé 3 datasets différents, un sur le nombre d'accidents de la route, un autre sur la tolérance d'alcoolémie au volant pour les jeunes conducteurs et un dernier sur le taux de jeunes consommant de l'alcool dans les différents pays.

Les résultats obtenus montrent une nette diminution du nombre d'accidents de la route chez les jeunes.
C'est en Europe et en Amérique du Sud que les jeunes consomment le plus d'alcool (**53%** des jeunes en consomment en Europe, et **36%** en Amérique du Sud).
Nous pouvons voir ces tendances sur le diagramme bar suivant :


Pour avoir un aperçu plus précis de la consommation d'alcool dans les différents pays nous avons choisi d'afficher les cartes en fonction d'un continent choisi dans un menu déroulant.


Nous avons décidé d'afficher l'évolution du nombre de mort par pays et par année entre 2000 et 2016, cependant par manque de données sur la cosommation d'alcool nous ne pourrons pas conclure sur une corrélation dans le temps. Néanmoins, le nombre maximal d'accidents par pays passe de plus de 8000 à moins de 3500 entre ces années, ce qui montre une baisse significative.

Cette tendance peut se constater en Europe, mais aussi dans la quasi-totalité des pays du monde que nous avons pu étudier.
Aux Etats-Unis cependant, nous observons que le nombre d'accidents reste stable chez les jeunes. En effet, les jeunes américains peuvent conduire en moyenne dès l'âge de 16 ans. Ne pouvant consommer légalement de l'alcool avant l'age de 21 ans, ce n'est pas un facteur qui impacte significativement le nombre d'accidents de la route.

Ainsi nous remarquons, d'après les différentes lois sur le taux d'alcoolémie autorisé au volant et le nombre de morts par pays, que le durcissement de la législation n'influe pas grandement sur le nombre total d'accidents de la route. Par exemple, le nombre de morts en France et en Allemagne est semblable alors que le taux d'alcoolémie autorisé dans le sang est différent.
Nous pouvons aussi constater que le taux de personnes consommant de l'alcool n'influe pas sur le nombre de morts par accident de la route, en effet si nous prenons le cas de la France et de la Suède, qui ont tous deux des taux semblable de consommateurs d'alcool, nous voyons clairement que le nombre de morts est différents.

Nous pouvons donc nous avancer à dire qu'il n'existe pas de corrélation factuelle entre le nombre de consommateurs d'alcool et le nombre de morts par accidents de la route dans un pays.





# Lien vers les datasets
Base de données "youth" : https://apps.who.int/gho/data/node.main.A1206?lang=en <br>
Base de données "tolerance" : https://apps.who.int/gho/data/node.main.A1209?lang=en <br>
Base de données "jeune_morts_cont" : https://stats.oecd.org/Index.aspx?DataSetCode=IRTAD_CASUAL_BY_AGE# <br>
Le préprocessing des bases de données est dans le dossier nettoyage_bdd.




# Instructions d'execution

- Télécharger le dossier "Projet-R-master"
- Le dézipper
- Ouvrir RStudio
- Installer les librairies requises (mentionnées dans le User's Guide)
- Cliquer sur le bouton 'Run App' de l'application
- Visualiser l'application soit dans un navigateur web avec l'adresse mentionnée dans la console RStudio soit dans le panel view de RStudio
