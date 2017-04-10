//
//  User.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/7/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class User: NSObject {
  
  var name: String?
  var screenName: String?
  var profileUrl: URL?
  var tagline: String?
  var location: String?
  var numFollowers: Int = 0
  var numFollowing: Int = 0
  
  var dictionary: NSDictionary
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    
    name = dictionary["name"] as? String
    screenName = "@\((dictionary["screen_name"] as? String)!)"
    if let profileUrlString = dictionary["profile_image_url_https"] as? String {
      profileUrl = URL(string: profileUrlString)
    }
    
    tagline = dictionary["description"] as? String
    location = dictionary["location"] as? String
    numFollowers = dictionary["followers_count"] as? Int ?? 0
    numFollowing = dictionary["friends_count"] as? Int ?? 0
    
  }
  
  static var _currentUser: User?
  
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        let defaults = UserDefaults.standard
        
        let userData = defaults.object(forKey: "currentUserData") as? NSData
        if let userData = userData {
          let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
          _currentUser = User(dictionary: dictionary)
        }
      }
      return _currentUser
    }
    
    set(user) {
      _currentUser = user
      
      let defaults = UserDefaults.standard
      
      if let user = user {
        let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
        defaults.set(data, forKey: "currentUserData")
      } else {
        defaults.set(nil, forKey: "currentUserData")
      }
      defaults.synchronize()
    }
  }
}
