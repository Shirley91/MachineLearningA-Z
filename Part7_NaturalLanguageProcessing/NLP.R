# NLP

# Importing the dataset
dataset_original = read.delim('Restaurant_Reviews.tsv', quote = '', stringsAsFactors = F)

# cleaning the texts
#install.packages('tm')
#install.packages('SnowballC')
library(tm)
library(SnowballC)
corpus = VCorpus(VectorSource(dataset_original $Review))
corpus = tm_map(corpus, content_transformer(tolower)) # lowercase
# to check using: as.character(corpus[[1]])
corpus = tm_map(corpus, removeNumbers) 
corpus = tm_map(corpus, removePunctuation) 
corpus = tm_map(corpus, removeWords, stopwords()) 
corpus = tm_map(corpus, stemDocument) # root of the words
corpus = tm_map(corpus, stripWhitespace) 

# creating the bag of words model
dtm = DocumentTermMatrix(corpus)
dtm = removeSparseTerms(dtm, 0.999) # keep 99% of frequence of words
dataset = as.data.frame(as.matrix(dtm))
dataset$Liked = dataset_original$Liked

# random forest classification
# Encoding the target feature as factor
dataset$Liked = factor(dataset$Liked, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting Random Forest to the Training set
library(randomForest)
classifier = randomForest(x = training_set[-692],
                          y = training_set$Liked,
                          ntree = 10)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)
# accuracy = (82+77)/200
# precision = 77/ (77+18)
# recall = 77 / (82+77)
# F1 score = 2 * precision * recall / (precision + recall)


# Decision tree classifier
# Fitting Decision Tree to the Training set
library(rpart)
classifier = rpart(formula = Liked ~ .,
                   data = training_set)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692], type = 'class')

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)
# accuracy = (85+57)/200
# precision = 57/ (57+15)
# recall = 57 / (85+57)

# Naive Bayes classifier
# Fitting Naive Bayes to the Training set
library(e1071)
classifier = naiveBayes(x = training_set[-692],
                        y = training_set$Liked)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)
# accuracy = (96+5)/200
# precision = 96/ (96+95)
# recall = 96 / (96+5)
