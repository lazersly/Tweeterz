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
  @IBOutlet var profileImageButton: UIButton!
  
  let twitterService = TwitterService()
  var selectedTweet : Tweet!

  override func viewDidLoad() {
      super.viewDidLoad()
    // Set up network call using the tweed ID sent to this viewcontroller
    
    // Clear the default storyboard label text
    self.userLabel.text = self.selectedTweet.userName
    self.textLabel.text = self.selectedTweet.text
    self.createdOnLabel.text = nil
    self.retweetsLabel.text = nil
    self.favoritesLabel.text = nil
    self.profileImageButton.setBackgroundImage(self.selectedTweet.profileImage, forState: UIControlState.Normal)
    
    LoginService.requestTwitterAccount { (receivedAccount, errorDescription) -> Void in
      self.twitterService.twitterAccount = receivedAccount
      
      self.twitterService.fetchTweetInfoForTweet(self.selectedTweet) { [weak self] (returnedTweet, errorDescription) -> Void in
        if self != nil {
          
          if let createdOn = returnedTweet?.createdAt {
            self!.createdOnLabel.text = createdOn
          }
          
          if let retweetCount = returnedTweet?.retweetCount {
            self!.retweetsLabel.text = retweetCount
          }
          
          if let favoritesCount = returnedTweet?.favoritesCount {
            self!.favoritesLabel.text = favoritesCount
          }
        }
      }
    }
  }

  @IBAction func clickedProfileImageButton(sender: AnyObject) {
    
  }

}
