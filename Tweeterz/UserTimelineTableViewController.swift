//
//  UserTimelineTableViewController.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 4/5/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class UserTimelineTableViewController: UITableViewController {

  @IBOutlet var userProfileImageButton: UIButton!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var tableHeaderView: UIView!
  var selectedTweet : Tweet! //Should be passed in
  var tweets : [Tweet]?
  let imageService = ImageService()
  let twitterService = TwitterService()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Access twitter account and download the information for the selectedUserID
      
      self.nameLabel.text = self.selectedTweet.userName
      self.locationLabel.text = self.selectedTweet.location
      self.userProfileImageButton.setBackgroundImage(self.selectedTweet.profileImage, forState: UIControlState.Normal)
      
      self.imageService.fetchImageAtURL(self.selectedTweet.backgroundImageURL!, completionHandler: { [weak self] (retrievedImage) -> Void in
        
        let imageView = UIImageView(image: retrievedImage)
        imageView.frame = self!.tableHeaderView.frame
        self?.tableHeaderView.addSubview(imageView)
        self?.tableHeaderView.sendSubviewToBack(imageView)
        
        self?.selectedTweet.backgroundImage = retrievedImage
      })
      
      LoginService.requestTwitterAccount { (account, errorDescription) -> Void in
        self.twitterService.twitterAccount = account
        
        println("Screen name: \(self.selectedTweet.screenName)")
        self.twitterService.fetchUserTimeline(self.selectedTweet.screenName!, completionHandler: { (returnedTweets, errorDescription) -> Void in
          if errorDescription != nil {
            // There was an error to handle
          } else {
            self.tweets = returnedTweets
            self.tableView.reloadData()
          }
        })
      }
      
      self.tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    }

    // MARK: - TableviewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      if (tweets != nil) {
        return self.tweets!.count
      } else {
        return 0
      }
    }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetTableViewCell
    
    cell.tag = indexPath.row
    let tag = cell.tag
    
    // set the label to nil so we don't see the reused label if it's not overwritten
    cell.userLabel.text = nil
    cell.tweetLabel.text = nil
    cell.profileImageView.image = nil
    
    if let tweet = self.tweets?[indexPath.row] {
      cell.userLabel.text = tweet.userName
      cell.tweetLabel.text = tweet.text
      
      if let profileImage = tweet.profileImage {
        cell.profileImageView.image = profileImage
      } else {
        self.imageService.fetchImageAtURL(tweet.profileImageURL!, completionHandler: { [weak self] (fetchedImage) -> Void in
          tweet.profileImage = fetchedImage
          cell.profileImageView.image = fetchedImage
        })
      }
    }
    
    cell.layoutIfNeeded()
    
    return cell;
  }

}
