
#############################################################################
# A simple R program to create a work cloud of MLB All-Stars in history
# Dino Fire
# June 10, 2014
# http://dinofireblog.wordpress.com
#############################################################################

# Load up some libraries

library(wordcloud)
library(rColorBrewer)
library(tm)
library(RXKCD)

# Import the data file...

allstar_lastnames <- read.csv('https://github.com/dino-fire/allstar-analysis/tree/master/data/allstar_names.csv', sep = ',', header = T)

# ... and store it to a local directory.  Make sure nothing else is in that
# directory, or you will be sad.

# replace 'myDirectory' with yours.  The full path name seems to work best.

a <- Corpus(DirSource('../myDirectory'))
summary(a)

# create the document matrix for the tm package to use

tdm <- TermDocumentMatrix(a)
m <- as.matrix(tdm)
v <- (sort(rowSums(m), decreasing = T))
d <- data.frame(word = names(v), freq = v)

# set up your cloud format parmeters

pal <- brewer.pal(7, 'Dark2')
pal <- pal[-(1:2)]
png('allstarnames3.png', width = 1280, height = 800)

# set your word cloud parameters

wordcloud(d$word, d$freq, scale = c(8, 0.3), min.freq = 5, max.words = 250, 
          random.order = T, rot.per = 0.05, colors = pal)

dev.off()

# done!
