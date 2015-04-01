//
//  Tweet.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 3/30/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation

class Tweet {
  
  var text : String?
  var userName: String?
  
  // Generic initializer
  init() {
  
  }
  
  // Constructor
  init(text : String, userName : String) {
    self.text = text
    self.userName = userName;
  }
  
}
