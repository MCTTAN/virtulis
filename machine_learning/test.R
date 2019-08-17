install.packages("keras")
library(keras)
install_keras()
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("EBImage", version = "3.8")
library(EBImage)


#READ IMAGES
pics<-c('c1.jpg','c2.jpg','c3.jpg','c4.jpg','c5.jpg','c6.jpg',
        'p1.jpg','p2.jpg','p3.jpg','p4.jpg','p5.jpg','p6.jpg')
mypic<-list()
for (i in 1:12) {mypic[[i]]<-readImage(pics[i])}
print(mypic) # for all the pictures
print(mypic[[1]])
display(mypic[[1]])
summary(mypic[[1]]) # by this command we can see that the pictures has been converted into number to use them for making classifications or predictions
hist(mypic[[12]]) # compared to the car's pictures, there is more colors in plane's pictures whose explain the difference in the colors lignes
str(mypic)

#RESIZE IMAGES to have the same dimensions
for (i in 1:12) {mypic[[i]]<-resize(mypic[[i]],28,28)}
str(mypic) # now we can notice that all the pictures have the same dimensions

#THE RESHAPE
# 28*28*3 we will have a single vector by dimension 2352
for (i in 1:10) {mypic[[i]]<-array_reshape(mypic[[i]],c(28,28,3))}#Number of layers for each picture, with 28*28*3 (total is the pixels)
str(mypic)

#ROW BIND
trainx<-NULL
for(i in 1:5){trainx<-cbind(trainx,mypic[[i]])} # Here we train the 5 first pictures and we use the 6th for test. The trainx is empty so with cbind we can insert the 5 first pictures in it.
str(trainx)
for(i in 7:11){trainx<-cbind(trainx,mypic[[i]])} # we combine the 5 others pictures for training
str(trainx) #we can se 1:10, we have 10 pictures in trainx
testx<-rbind(mypic[[6]],mypic[[12]]) # test
#0 is for cars and 1 is for planes.
trainy<-c(0,0,0,0,0,1,1,1,1,1)
testy<-c(0,1)# This means the 0 in test should be the same as 0 in train

#ONE HOT ENCODING
trainLabels<-to_categorical(trainy) #Convert a class vector to binary class matrix. The goal of this fonction is to tell us if , when we test it with the 'test',  0 = a car or 1 = a plan
testLabels<-to_categorical(testy)
trainLabels

#CREATION OF THE MODEL
model<-keras_model_sequential()#Keras model composed of a linear stack of layers.The first layer should have a defined "input" shape, next fonction:
model %>%
  layer_dense(units=256, activation = 'relu',input_shape = c(2352)) %>%
  layer_dense(units=128, activation = 'relu') %>%
  layer_dense(units = 2, activation = 'softmax')#units=256 are the number of neurons in the "hidelayer1" (then half in hiden layer 2 and just 2 in the last layer because we have cars and planes) notice that we can change the layers depending on our model, the input_shape is the number of neurons in the first layer and it depend on the total of the pixels of the pictures
summary(model)
# the number of parametrs here 256*2352+256=602368

#COMPILE THE MODEL
model %>% 
  compile(loss = 'binary_crossentropy',
          optimizer = optimizer_rmsprop(),
          metrics = c('accuracy'))#We put binary because we should have only two responses. But when we have more, we put "categorical_crossentropy"

#TRAINING AND EVALUATION
history<-model%>%
  fit(trainx,
      trainLabels,
      epochs=30,
      batch_size=32,
      validation_split=0.2)
