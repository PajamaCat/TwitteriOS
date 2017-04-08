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
  
  init(dictionary: NSDictionary) {
    name = dictionary["name"] as? String
    screenName = dictionary["screen_name"] as? String
    if let profileUrlString = dictionary["profile_image_url_https"] as? String {
      profileUrl = URL(string: profileUrlString)
    }
    
    tagline = dictionary["description"] as? String
  }
}
