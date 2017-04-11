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
  var timestamp: Date?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var id: Int = 0
  var favorited: Bool = false
  var retweeted: Bool = false
  var user: User?
  
  init(dictionary: NSDictionary) {
    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
    
    let timestampString = dictionary["created_at"] as? String
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    timestamp = formatter.date(from: timestampString!)
    
    user = User(dictionary: dictionary["user"] as! NSDictionary)
    id = dictionary["id"] as! Int
    favorited = dictionary["favorited"] as! Bool
    retweeted = dictionary["retweeted"] as! Bool
  }
  
  func abbreviatedTimestamp() -> String {
    let dateComponentFormatter = DateComponentsFormatter()
    dateComponentFormatter.maximumUnitCount = 1
    dateComponentFormatter.unitsStyle = .abbreviated
    return dateComponentFormatter.string(from: abs((timestamp?.timeIntervalSinceNow)!))!
  }
  
  func fullTimestamp() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, h:mm a"
    return formatter.string(from: timestamp!)

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
