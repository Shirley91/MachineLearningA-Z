# Hierarchical Clustering

# Importing the dataset
dataset = read.csv('Mall_Customers.csv')
X = dataset[4:5]

# using dendrograms to find optimal number of clusters
dendrogram = hclust(dist(X, method='euclidean'),
                    method = 'ward.D')
plot(dendrogram,
     main = paste('Dendrogram'),
     xlab = 'Customers',
     ylab = 'Euclidean Distance')

# fitting Hierarchical Clustering to the mall dataset
hc = hclust(dist(X, method='euclidean'), method='ward.D')
y_hc = cutree(hc, 5) # 5 clusters

# visualising the clusters
library(cluster)
clusplot(X,
         y_hc,
         lines=0,
         shade=T,
         color=T,
         labels=2,
         plotchar=F,
         span=T,
         main=paste('Clusters of clients'),
         xlab='Annual Income',
         ylab='Spending Score')