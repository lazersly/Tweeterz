//
//  HomeTimelineViewController.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 3/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource {
  //MARK: Storyboard outlets
  @IBOutlet var tableView: UITableView!
  
  //MARK: Instance variables
  let twitterService = TwitterService()
  var tweets : [Tweet]?

  //MARK: UIViewController methods
  override func viewDidLoad() {
      super.viewDidLoad()
    
    self.tableView.dataSource = self
    
    LoginService.requestTwitterAccount { (receivedAccount, errorDescription) -> Void in
      self.twitterService.twitterAccount = receivedAccount
      self.twitterService.fetchTwitterHomeTimeline { (returnedTweets, errorDescription) -> Void in
        if (errorDescription != nil) {
          // handle the error
        }
        
        self.tweets = returnedTweets
        self.tableView.reloadData()
      }
    }
    
    
//      if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
//        if let data = NSData(contentsOfFile: filePath) {
//          self.tweets = TweetJSONParser.tweetsFromJSONData(data)
//          println(tweets)
//        }
//      }
  }
  
  //MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (self.tweets != nil) {
      return self.tweets!.count
    } else {
      return 0;
    }
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as UITableViewCell
    
    // set the label to nil so we don't see the reused label if it's not overwritten
    cell.textLabel?.text = nil
    cell.detailTextLabel?.text = nil
    
    if let tweet = self.tweets?[indexPath.row] {
      cell.textLabel?.text = tweet.text
      cell.detailTextLabel?.text = tweet.userName
    }

    return cell;
  }
  

}
