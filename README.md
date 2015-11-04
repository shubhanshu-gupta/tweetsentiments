tweetsentiments
===============

Analyse the sentiments of the tweets fetched of a particular topic. 

The new sentiment analysis on tweets has been done using R. It solves the following problems:
1. Collect tweets using the twitter api
2. Collect about 10,000 tweets
3. For each tweet, assign it a sentiment score. The sentiment score can be defined as the number of happy words - the number of negative words. You should be able to find a dictionary of positive and negative words online (search for AFINN-111.txt)
4. Find the top 10 happy topics, and top 10 sad topics. A topic would be a hashtag.

Hence, the code helps in understanding how to assign a sentiment score to a tweet and how to fetch a corpus of 10,000 tweets.

Solution theory:
1. I have fetched tweets of maggi outrage in the country (I mean, maggi was the topic that I chose for the sentiment analysis).

2. Though, it's fairly easy to fetch 10,000 tweets but in computation terms (and time) it becomes a disaster. I analysed sentiments on a corpus of 1000 tweets, which took about 1.15 hours by my watch.

3. So, after fetching in about 1000 tweets and subsequently cleaning it off with retweets, people tags, punctuations, numbers, html links, and other spaces, I looped in the AFINN file that you suggested. Actually, in the whole corpus of tweets, each individual tweet was broken or separated into individual word wherein each word was looked for its score from the AFINN file. Thereby, building an aggregate sentiment score of the whole (individual) tweet. Then, (though the point number 3 from the problem statement has been accomplished), it's possible in R to even categorize every word, using classify_emotion function, within a possible set of 7 emotions (anger, disgust, fear, joy, sadness, surprise, and best_fit wherein best_fit gives the most likely emotion from an amalgam of all the rest 6 for a given word). So, the each individual word of every tweet was assigned a "best_fit" emotion and for the words which do not match with any of the best_fit emotional categories - unknown was assigned to such words. 

Hence, in order to visualize the relationship between the AFINN sentiment score derived and the emotions (and how close they are w.r.t our maggi outrage), a bar chart was plotted. Anger, fear, sadness emotions in the tweets are pretty profound whereas the number of tweets depicting disgust against the whole maggi issue is a very significant number.  

Sentiment package allows you to set how you want the classifier to calculate. If you set algorithm option to bayes it will use a Multinomial Naive Bayes Classifier trained using the lexicon in the package. The other option (default option) is a simple voter algorithm (count negative, positive etc. words and majority wins). If the text is incorrectly classified either the words in your text are not in the lexicon or there is negation that is being not properly acknowledged by the classifier.


