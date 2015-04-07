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
  var selectedTweet : Tweet!
  var tweets : [Tweet]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Access twitter account and download the information for the selectedUserID
      
      self.nameLabel.text = self.selectedTweet.userName
      self.locationLabel.text = self.selectedTweet.location
      self.userProfileImageButton.setBackgroundImage(self.selectedTweet.profileImage, forState: UIControlState.Normal)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }



}
