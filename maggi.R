library("twitteR")
library("tm")
library("httr")
library("sentiment")
library("lattice")

oauth_endpoints("twitter")
api_key       <- "PeZxMy29huUCiE8YgpZvLxoTY"
api_secret   		<- "dcCGH8d6IsqRSp0cKuizalueL2NGZNR6PpcFd4SPr99JNgI16D"
access_token 		<- "69014652-6s5GODIgmQLeWMaLudMpT21cYN1CogSjq4Fmoim0U"
access_token_secret <- "vSY2kcMaeh9ApNkp4TPcm8dorymhxNRg9l2NDQ1oImsnI"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

twitter_search = searchTwitter("Maggi", n=1000, lang="en", resultType="recent")

# Get text data from the result of Twitter search
maggi <- sapply(twitter_search, function(x) x$getText())
# Remove retweets
maggi = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", maggi)
# Remove  @people
maggi = gsub("@\\w+", "", maggi)
# Remove punctuation
maggi = gsub("[[:punct:]]", "", maggi)
# Remove numbers
maggi = gsub("[[:digit:]]", "", maggi)
# Remove html links
maggi = gsub("http\\w+", "", maggi)
# remove unnecessary spaces
maggi = gsub("[ \t]{2,}", "", maggi)
maggi = gsub("^\\s+|\\s+$", "", maggi)

# define "tolower error handling" function 
tryTolower = function(x)
{
  # create missing value
  y = NA
  # tryCatch error
  try_error = tryCatch(tolower(x), error=function(e) e)
  # if not an error
  if (!inherits(try_error, "error"))
    y = tolower(x)
  # result
  return(y)
}
#
# lower case using tryTolower with sapply 
maggi = sapply(maggi, tryTolower)
#

maggi = maggi[!is.na(maggi)]

names(maggi) = NULL

write.table(maggi, "D:/R/maggi.txt", sep="\t")

afinn <- read.delim("D:/R/AFINN-111.txt", sep="\t", header=FALSE)
# character separation
#
  first <- character()
  sent <- numeric()
  sentiment <- numeric()
  for (k in 1:length(maggi))
    {
    first <- unlist(strsplit(as.character(maggi[k]), " "))
      sentiment <- 0
          for (i in 1:length(first)){
                for (j in 1:dim(afinn)[1]) {
                   if (first[i] == afinn$V1[j]){ 
                     sentiment <- afinn$V2[j]+sentiment
                                               }
                                           }
                                   }
                    sent[k] <- sentiment
                    }

maggi_class_emo = classify_emotion(maggi, algorithm="bayes", prior=1.0)
emotion = maggi_class_emo[,7]
emotion[is.na(emotion)]="unknown"

data <- as.character(maggi)
maggiSentiment <- data.frame(text= data, afinnscore = sent, emotion = emotion)

histogram(~ afinnscore | factor(emotion), data=maggiSentiment,
          xlab="Sentiment scores derived from AFINN-111",
          main="Sentiment scores of tweets for maggi being removed from market in each emotion category "
)