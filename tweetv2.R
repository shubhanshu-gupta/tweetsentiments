library("twitteR")
library("tm")
library("httr")

oauth_endpoints("twitter")
api_key     	<- "mOIranaaDHm05Ap9K05Gemz8o"
api_secret 			<- "kcESnYx4VTl5dG1WRsQruyGp3FtsO1avSH7gagffSWQGF3amAG"
access_token 		<- "69014652-6s5GODIgmQLeWMaLudMpT21cYN1CogSjq4Fmoim0U"
access_token_secret <- "vSY2kcMaeh9ApNkp4TPcm8dorymhxNRg9l2NDQ1oImsnI"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

twitter_search = searchTwitter("Maggi", n=500, lang="en", resultType="recent")

# Get text data from the result of Twitter search
text2 <- sapply(twitter_search, function(x) x$getText())
# Remove retweets
text2 = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", text2)
# Remove at people
text2 = gsub("@\\w+", "", text2)
# Remove punctuation
text2 = gsub("[[:punct:]]", "", text2)
# Remove numbers
text2 = gsub("[[:digit:]]", "", text2)
# Remove html links
text2 = gsub("http\\w+", "", text2)
# remove unnecessary spaces
text2 = gsub("[ \t]{2,}", "", text2)
text2 = gsub("^\\s+|\\s+$", "", text2)

write.table(text2, "D:/R/text2.txt", sep="\t")
