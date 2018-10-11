
# Find an R package that performs truncate SVD
install.packages("prcomp")
install.packages("svd")
install.packages("irlba")   # the one we are going to use now.

# Standard PCA
musk1<-read.table(".../musk.txt", header = TRUE, sep = "" )
musk<-musk1[1:166] # to eliminate last column

pc<-prcomp(musk,center=TRUE)
summary(pc)         

# Three different ways to visualize Principal Components
plot(pc)            
plot(pc, type="l")  
biplot(pc)

# Truncated PCA using truncated SVD
pc2<- prcomp_irlba(musk)
summary(pc2)

par(mfrow=c(1,1))
plot(pc2)
plot(pc2, type="l")
biplot(pc2)

# Comparision
par(mfrow=c(1,2))
biplot(pc, main="SVD")
biplot(pc2, main="Truncated SVD")

install.packages("ggfortify")
install.packages("ggplot2")
library(ggfortify)
library(ggplot2)

df <- musk[c(1:166)]
autoplot(prcomp(df))

# Plot with ggplot
df2 <- musk1[c(1:167)]
autoplot(prcomp(df2), data = musk1, colour = 'musk')

# Execution time comparision
system.time(pc2<- prcomp_irlba(musk)) # time consumption using Truncated SVD
system.time(pc<-prcomp(musk,center=TRUE))   # time consumption using basic SVD

sessionInfo()
