install.packages('readxl')
library('readxl')
# Spécifiez le chemin complet du fichier Excel
chemin_fichier <- "C:/Users/k/Test-2/african_wildlife.xlsx"

# Lire le fichier Excel et le convertir en un dataframe
dataframe <- read_excel(chemin_fichier)
df <- data.frame(dataframe )
head(df)


# Supprimer les colonnes col2 et col3
df_sans_colonnes <- subset(df, select = -c(année.avant.modif, mois, Type_inventaire))
# Affichage du dataframe sans les colonnes spécifiées
print(head(df_sans_colonnes))

df_sans_colonnes <- df_sans_colonnes[complete.cases(df_sans_colonnes$estimation_cor),]
df_sans_colonnes <- df_sans_colonnes[complete.cases(df_sans_colonnes$estimation),]

df_sans_colonnes$estimation <- as.numeric(df_sans_colonnes$estimation)
# Création de l'histogramme pour la colonne "age"
hist(df_sans_colonnes$estimation, 
     main = "Histogramme de l'âge", 
     xlab = "Âge",
     ylab = "Fréquence",
     col = "skyblue",
     border = "black")

df_sans_colonnes$estimation_cor <- as.numeric(df_sans_colonnes$estimation_cor)
# Création de l'histogramme pour la colonne "age"
hist(df_sans_colonnes$estimation_cor, 
     main = "Histogramme de l'âge", 
     xlab = "Âge",
     ylab = "Fréquence",
     col = "skyblue",
     border = "black")




# Labels correspondant à chaque part
labels <- df_sans_colonnes$pays


# Création du diagramme circulaire
pie(df_sans_colonnes$estimation_cor , labels = labels, main = "Diagramme circulaire")



########Diagramme circulaire avec étiquettes répétées des pays
# Exemple de vecteur d'étiquettes
labels <-  df_sans_colonnes$pays

# Compter le nombre d'occurrences de chaque étiquette
label_counts <- table(labels)

# Créer le diagramme circulaire avec les étiquettes répétées
pie(label_counts, labels = names(label_counts), main = "Diagramme circulaire avec étiquettes répétées des pays")



########Diagramme circulaire avec étiquettes répétées des espèces
# Exemple de vecteur d'étiquettes
labels <-  df_sans_colonnes$espèce

# Compter le nombre d'occurrences de chaque étiquette
label_counts <- table(labels)

# Créer le diagramme circulaire avec les étiquettes répétées
pie(label_counts, labels = names(label_counts), main = "Diagramme circulaire avec étiquettes répétées des pays")

########Diagramme circulaire avec étiquettes répétées des aires protegees
# Exemple de vecteur d'étiquettes
labels <-  df_sans_colonnes$aire_protégée

# Compter le nombre d'occurrences de chaque étiquette
label_counts <- table(labels)

# Créer le diagramme circulaire avec les étiquettes répétées
pie(label_counts, labels = names(label_counts), main = "Diagramme circulaire avec étiquettes répétées des pays")



########
# Créer un histogramme avec ggplot2
ggplot(df_sans_colonnes, aes(x = as.factor(df_sans_colonnes$année), y = df_sans_colonnes$estimation)) +
  geom_bar(stat = "identity") +
  labs(x = "Année", y = "Valeur", title = "Histogrmme des valeurs par année")


selected_rows <- subset(df_sans_colonnes, aire_protégée == "Comoe" | aire_protégée == "Zakouma")
head(selected_rows)
selected_rows$espèce

########Diagramme circulaire avec étiquettes répétées des aires protegees
# Exemple de vecteur d'étiquettes
labels <-  selected_rows$espèce

# Compter le nombre d'occurrences de chaque étiquette
label_counts <- table(labels)

# Créer le diagramme circulaire avec les étiquettes répétées
pie(label_counts, labels = names(label_counts), main = "Diagramme circulaire avec étiquettes répétées des pays")

######### Création de la nouvelle colonne en soustrayant esti_sup de esti_inf
selected_rows$esti_sup_esti_inf <- selected_rows$esti_sup - selected_rows$esti_inf
head(selected_rows)
