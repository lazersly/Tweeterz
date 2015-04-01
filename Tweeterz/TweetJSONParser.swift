//
//  TweetJSONParser.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 3/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  // Class method to return an array of tweets parsed from given JSON or nil if there is no data
  class func tweetsFromJSONData(data : NSData) -> [Tweet]? {
    
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [[String : AnyObject]] {
      return self.parseJSON(jsonObject)
    } else {return nil}
  }
  
  // Helper parser method builds an array of tweets or returns nil if there are no tweets
  private class func parseJSON(json : [[String : AnyObject]]) -> [Tweet]? {
    
    // Array to build
    var tweets = [Tweet]()
    
    for object in json {
      let tweet = self.createTweetFromJSONObjectInfo(object)
      tweets.append(tweet)
    }
    
    if tweets.count == 0 {return nil}
    else {return tweets}
  }
  
  // Helper tweet creator method.  Creates a tweet from a JSON representation of a tweet.
  private class func createTweetFromJSONObjectInfo(jsonObject : [String : AnyObject]) -> Tweet {
    
    // JSON key names
    let textKey = "text"
    let userContainerKey = "user"
    let userNameKey = "name"
    
    var tweet = Tweet()
    
    if let text = jsonObject[textKey] as? NSString {
      println(text)
      tweet.text = text;
    }
    
    if let userInfo = jsonObject[userContainerKey] as? [String : AnyObject] {
      if let userName = userInfo[userNameKey] as? NSString {
        tweet.userName = userName
      }
    }
    
    return tweet

  }
  
}
