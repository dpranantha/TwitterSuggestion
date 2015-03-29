# Author: dpranantha
###############################################################################

library(ROAuth)
library(streamR)

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumer <- lapply(read.csv('keys.csv'),as.character)

my_oauth <- OAuthFactory$new(consumerKey=consumer$consumerKey,
		consumerSecret=consumer$consumerSecret, requestURL=requestURL,
		accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
#my_oauth$handshake()
filterStream( file="firehose.json",track="louis vuitton", oauth=my_oauth , tweets = 10)
