//
//  Tweet.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 3/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class Tweet {
  
  var id : String?
  var text : String?
  var userName: String?
  var profileImage : UIImage?
  var profileImageURL : String?
  var retweetCount: String?
  var favoritesCount: String?
  var createdAt: String?
  
  // Generic initializer
  init() {
  }
  
  // Constructor
  init(id: String, text : String, userName : String) {
    self.id = id
    self.text = text
    self.userName = userName;
  }
  
}
