//
//  Tweet.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/7/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var text: String?
  var timestamp: String?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var user: User?
  
  init(dictionary: NSDictionary) {
    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
    
    let timestampString = dictionary["created_at"] as? String
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    
    let dateComponentFormatter = DateComponentsFormatter()
    dateComponentFormatter.maximumUnitCount = 1
    dateComponentFormatter.unitsStyle = .abbreviated
    timestamp = dateComponentFormatter.string(from: abs((formatter.date(from: timestampString!)?.timeIntervalSinceNow)!))
    
    user = User(dictionary: dictionary["user"] as! NSDictionary)
  }
  
  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
    var tweets = [Tweet]()
    for dictionary in dictionaries {
      let tweet = Tweet(dictionary: dictionary)
      tweets.append(tweet)
    }
    return tweets
  }
}
