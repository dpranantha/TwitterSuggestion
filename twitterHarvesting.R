# Author: dpranantha
###############################################################################

library(ROAuth)
library(streamR)
library(rjson)

#related files and words
keyFile <- "keys.csv"
jsonFile <- "firehose.json"
trackingwords <- "jokowi"

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumer <- lapply(read.csv(keyFile),as.character)

#get authentication using OAuth of Twitter API
my_oauth <- OAuthFactory$new(consumerKey=consumer$consumerKey,
		consumerSecret=consumer$consumerSecret, requestURL=requestURL,
		accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))

#filter out the data stream and put them in a JSON file
filterStream( file=jsonFile,track=trackingwords, oauth=my_oauth , tweets = 10)

#process the JSON file
data <- fromJSON(file=jsonFile)

