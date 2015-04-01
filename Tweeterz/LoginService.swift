//
//  LoginService.swift
//  Tweeterz
//
//  Created by Brandon Roberts on 4/1/15.
//  Copyright (c) 2015 BR World. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
  class func requestTwitterAccount(completionHandler : (ACAccount?, String?) -> Void) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if granted && error == nil {
        // We have access, go ahead and retrieve the account
        if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
          if !accounts.isEmpty {
            let twitterAccount = accounts.first
            completionHandler(twitterAccount, nil)
          }
          
        }
      } else {
        completionHandler(nil, "Please sign in with your Twitter account")
      }
    }
  }
}
