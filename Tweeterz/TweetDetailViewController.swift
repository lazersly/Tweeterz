//
//  TweetDetailViewController.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 4/2/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  @IBOutlet var userLabel: UILabel!
  @IBOutlet var textLabel: UILabel!
  @IBOutlet var createdOnLabel: UILabel!
  @IBOutlet var retweetsLabel: UILabel!
  @IBOutlet var favoritesLabel: UILabel!
  
  let twitterService = TwitterService()
  var selectedTweet : Tweet!

  override func viewDidLoad() {
      super.viewDidLoad()
    // Set up network call using the tweed ID sent to this viewcontroller
    
    // Clear the default storyboard label text
    self.userLabel.text = nil
    self.textLabel.text = nil
    self.createdOnLabel.text = nil
    self.retweetsLabel.text = nil
    self.favoritesLabel.text = nil
    
    LoginService.requestTwitterAccount { (receivedAccount, errorDescription) -> Void in
      self.twitterService.twitterAccount = receivedAccount
      
      self.twitterService.fetchTweetInfoForTweet(self.selectedTweet) { (returnedTweet, errorDescription) -> Void in
        if let userName = returnedTweet?.userName {
          self.userLabel.text = userName
        }
        
        if let text = returnedTweet?.text {
          self.textLabel.text = text
        }
        
        if let createdOn = returnedTweet?.createdAt {
          self.createdOnLabel.text = createdOn
        }
        
        if let retweetCount = returnedTweet?.retweetCount {
          self.retweetsLabel.text = retweetCount
        }
        
        if let favoritesCount = returnedTweet?.favoritesCount {
          self.favoritesLabel.text = favoritesCount
        }
      }
    }
    

  }


}
