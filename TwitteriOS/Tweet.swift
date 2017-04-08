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
  var timestamp: NSDate?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  
  init(dictionary: NSDictionary) {
    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
    
    let timestampString = dictionary["created_at"] as? String
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    timestamp = formatter.date(from: timestampString!) as NSDate?
    
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
