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
  
  // Generic init
  init () {}
  
  // Instance variables
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  var twitterAccount : ACAccount?
  
  func fetchTwitterHomeTimeline(completionHandler : ([Tweet]?, String?) -> Void) {
    
    // Create the NSURL to which to send the request
    let requestURL = NSURL(string: homeTimelineURL)
    
    // Create an SLRequest with the service type, HTTP method type, and URL
    let twitterRequest = SLRequest(forServiceType: ACAccountTypeIdentifierTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    
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
}
