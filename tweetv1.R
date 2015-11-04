library("twitteR")
library("tm")
library("httr")
api_key   		<- "mOIranaaDHm05Ap9K05Gemz8o"
api_secret 			<- "kcESnYx4VTl5dG1WRsQruyGp3FtsO1avSH7gagffSWQGF3amAG"
access_token 		<- "69014652-6s5GODIgmQLeWMaLudMpT21cYN1CogSjq4Fmoim0U"
access_token_secret <- "vSY2kcMaeh9ApNkp4TPcm8dorymhxNRg9l2NDQ1oImsnI"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

twitter_search = searchTwitter("India", n=400, lang="en", resultType="recent")

# Get text data from the result of Twitter search
text1 <- sapply(twitter_search, function(x) x$getText())
# Remove retweets
text1 = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", text1)
# Remove at people
text1 = gsub("@\\w+", "", text1)
# Remove punctuation
text1 = gsub("[[:punct:]]", "", text1)
# Remove numbers
text1 = gsub("[[:digit:]]", "", text1)
# Remove html links
text1 = gsub("http\\w+", "", text1)
# remove unnecessary spaces
text1 = gsub("[ \t]{2,}", "", text1)
text1 = gsub("^\\s+|\\s+$", "", text1)

write.table(text1, "D:/R/text2.txt", sep="\t")
