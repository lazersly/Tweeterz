//
//  TweetTableViewCell.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 4/2/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

  @IBOutlet var userLabel: UILabel!
  @IBOutlet var tweetLabel: UILabel!
  @IBOutlet var profileImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
