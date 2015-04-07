//
//  TwitterService.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 4/1/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  // Instance variables
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  var twitterAccount : ACAccount?
  
  // Generic init
  init () {}
  
  func fetchTwitterHomeTimeline(completionHandler : ([Tweet]?, String?) -> Void) {
    
    // Create the NSURL to which to send the request
    let requestURL = NSURL(string: homeTimelineURL)
    
    // Create an SLRequest with the service type, HTTP method type, and URL
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    
    // Assign the account we want to fetch in the request
    twitterRequest.account = twitterAccount
    
    // Execute the request
    twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil {
        // There was an error with the connection, handle it
      } else {
        var errorDescription : String?
        var tweets = [Tweet]()
        
        // There was not an error with the connection, check the status of the response and handle accordingly
        switch response.statusCode {
        case 200...299:
          tweets = TweetJSONParser.tweetsFromJSONData(data)!
        case 300...399:
          errorDescription = "No new data was returned"
        case 400...499:
          errorDescription = "Bad request or incorrect credentials"
        case 500...599:
          errorDescription = "An error occurred, please try again later"
        default:
          errorDescription = "An unknown error occurred"
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(tweets, errorDescription)
        })
      }
    }
  }
  
  let detailURL = "https://api.twitter.com/1.1/statuses/show.json?id=" // must appeand ID
  
  func fetchTweetInfoForTweet(tweet : Tweet, completionHandler : (Tweet?, String?) -> Void) {
    if let tweetID = tweet.id? {
      let fullURL = NSURL(string: detailURL + tweetID)
      let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: fullURL, parameters: nil)
      request.account = self.twitterAccount
      
      request.performRequestWithHandler { (data, response, error) -> Void in
        
        println("data: \(data)")
        println("response: \(response)")
        println("error: \(error)")
        
        if error != nil {
          // There was an error.  Handle it.
        } else {
          var errorDescription : String?
          var tweet : Tweet?
          
          switch response.statusCode {
            case 200...299:
              tweet = TweetJSONParser.tweetInfoFromJSONData(data)!
            case 300...399:
              errorDescription = "No new data was returned"
            case 400...499:
              errorDescription = "Bad request or incorrect credentials"
            case 500...599:
              errorDescription = "An error occurred, please try again later"
            default:
              errorDescription = "An unknown error occurred"
          }
          println(tweet)
          NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completionHandler(tweet, errorDescription)
          }
        }
      }
    }
  }
  
  let userTimelineURLRequestURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
  
  func fetchUserTimeline(screenName: String, completionHandler : ([Tweet]?, String?) -> Void) {
    let fullURL = NSURL(string: userTimelineURLRequestURL + screenName)
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: fullURL, parameters: nil)
    
    request.account = self.twitterAccount
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      if error != nil {
        //There was an error, handle it
      } else {
        // No error
        var errorDescription : String?
        var tweets = [Tweet]()
        
        // There was not an error with the connection, check the status of the response and handle accordingly
        switch response.statusCode {
        case 200...299:
          tweets = TweetJSONParser.tweetsFromJSONData(data)!
        case 300...399:
          errorDescription = "No new data was returned"
        case 400...499:
          errorDescription = "Bad request or incorrect credentials"
        case 500...599:
          errorDescription = "An error occurred, please try again later"
        default:
          errorDescription = "An unknown error occurred"
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(tweets, errorDescription)
        })

        
      }
    }
    
  }
}
