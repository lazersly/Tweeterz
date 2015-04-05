//
//  ImageService.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 4/2/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import UIKit

class ImageService {
  let imageQueue = NSOperationQueue()
  
  func fetchImageAtURL(url : String, completionHandler : (UIImage?)->Void) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      if let url = NSURL(string: url) {
        if let imageData = NSData(contentsOfURL: url) {
          if let image = UIImage(data: imageData) {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(image)
            })
          }
        }
      }
    }
  }
}
