//
//  HomeTimelineViewController.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 3/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  //MARK: Storyboard outlets
  @IBOutlet var tableView: UITableView!
  
  //MARK: Instance variables
  let twitterService = TwitterService()
  let imageService = ImageService()
  var tweets : [Tweet]?

  //MARK: UIViewController methods
  override func viewDidLoad() {
      super.viewDidLoad()
    
    let nib = UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle())
    self.tableView.registerNib(nib, forCellReuseIdentifier: "TweetCell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.estimatedRowHeight = 70.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
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
    
    
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetTableViewCell
    
    cell.tag = indexPath.row
    let tag = cell.tag
    
    // set the label to nil so we don't see the reused label if it's not overwritten
    cell.userLabel.text = nil
    cell.tweetLabel.text = nil
    cell.profileImageView = nil
    
    if let tweet = self.tweets?[indexPath.row] {
      cell.userLabel.text = tweet.userName
      cell.tweetLabel.text = tweet.text
      
      if let profileImage = tweet.profileImage {
        cell.profileImageView.image = profileImage
      } else {
        self.imageService.fetchImageAtURL(tweet.profileImageURL!, completionHandler: { [weak self] (fetchedImage) -> Void in
          tweet.profileImage = fetchedImage
          if tag == cell.tag {
            cell.profileImageView.image = tweet.profileImage
          }
        })
      }
    }
    
    cell.layoutIfNeeded()

    return cell;
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let newVC = self.storyboard?.instantiateViewControllerWithIdentifier("TweetDetailView") as? TweetDetailViewController {
      newVC.selectedTweet = self.tweets?[indexPath.row]
      self.navigationController?.pushViewController(newVC, animated: true)
    }
  }
  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.destinationViewController.isKindOfClass(TweetDetailViewController) {
//      let vc = segue.destinationViewController as TweetDetailViewController
//      let indexRow = self.tableView.indexPathForSelectedRow()?.row
//      vc.selectedTweet = self.tweets?[indexRow!]
//    }
//  }
  

}
