library("twitteR")
library("tm")
library("httr")

oauth_endpoints("twitter")
api_key       <- "eDeyQOqRXrMXPZphWtc8YCOwG"
api_secret 			<- "fEnutJ54r9fIpxcSJZpQfEEQeOsJDPfUKqdine4q7nTNmyfh6r"
access_token 		<- "69014652-6s5GODIgmQLeWMaLudMpT21cYN1CogSjq4Fmoim0U"
access_token_secret <- "vSY2kcMaeh9ApNkp4TPcm8dorymhxNRg9l2NDQ1oImsnI"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

twitter_search = searchTwitter("Maggi", n=5000, lang="en", resultType="recent")

# Get text data from the result of Twitter search
text3 <- sapply(twitter_search, function(x) x$getText())
# Remove retweets
text3 = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", text3)
# Remove at people
text3 = gsub("@\\w+", "", text3)
# Remove punctuation
text3 = gsub("[[:punct:]]", "", text3)
# Remove numbers
text3 = gsub("[[:digit:]]", "", text3)
# Remove html links
text3 = gsub("http\\w+", "", text3)
# remove unnecessary spaces
text3 = gsub("[ \t]{2,}", "", text3)
text3 = gsub("^\\s+|\\s+$", "", text3)

write.table(text3, "D:/R/text3.txt", sep="\t", append=TRUE)
