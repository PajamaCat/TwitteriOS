//
//  TwitterClient.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/8/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  
  static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey:"c8UpZxaUQJzx4NmPyDzyheIN2", consumerSecret: "SJTW1AaOPlbKpjreev92epFgL0fjDUN5bWsVCnhbgREl7yKNZ0")
  var loginSuccess: (() -> ())?
  var loginFailure: ((Error?) -> ())?
  
  func login(success: @escaping () -> (), failure: @escaping (Error?) -> ()) {
    loginSuccess = success
    loginFailure = failure
    
    TwitterClient.sharedInstance?.deauthorize()
    TwitterClient.sharedInstance?.fetchRequestToken(
      withPath: "oauth/request_token",
      method: "GET",
      callbackURL: URL(string: "twitterios://oauth"),
      scope: nil,
      success: { (requestToken) in
        if let urlString = requestToken?.token {
          let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(urlString)")!
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }, failure: { (error) in
      self.loginFailure?(error)
    })
  }
  
  func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
    get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task, response) in
      let dictionaries = response as! [NSDictionary]
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      success(tweets)
    }) { (task, error) in
      print("\(error.localizedDescription)")
      failure(error)
    }
  }
  
  func mentions(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
    get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task, response) in
      let dictionaries = response as! [NSDictionary]
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      success(tweets)
    }) { (task, error) in
      print("\(error.localizedDescription)")
      failure(error)
    }
  }
  func userTimeline(parameters: Any?, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
    get("1.1/statuses/user_timeline.json", parameters: parameters, progress: nil, success: { (task, response) in
      let dictionaries = response as! [NSDictionary]
      print(dictionaries)
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      success(tweets)
    }) { (task, error) in
      print("\(error.localizedDescription)")
      failure(error)
    }
  }
  
  func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
    get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
      let userDictionary = response as! NSDictionary
      let user = User(dictionary: userDictionary)
      success(user)
    }) { (task, error) in
      print("\(error.localizedDescription)")
      failure(error)
    }
  }
  
  func postTweet(tweetContent: String) {
    let parameters: [String: String] = ["status": tweetContent]
    post("1.1/statuses/update.json", parameters: parameters, progress: nil, success: nil) { (task, error) in
      print("\(error.localizedDescription)")
    }
  }
  
  func favorites(id: Int, value: Bool) {
    let parameters: [String: Int] = ["id": id]

    if value {
      post("1.1/favorites/create.json", parameters: parameters, progress: nil, success: nil) { (task, error) in
        print("\(error.localizedDescription)")
      }
    } else {
      post("1.1/favorites/destroy.json", parameters: parameters, progress: nil, success: nil) { (task, error) in
        print("\(error.localizedDescription)")
      }
    }
  }
  
  func retweet(id: Int, value: Bool) {
    let parameters: [String: Int] = ["id": id]
    
    if value {
      post("1.1/statuses/retweet.json", parameters: parameters, progress: nil, success: nil) { (task, error) in
        print("\(error.localizedDescription)")
      }
    } else {
      post("1.1/statuses/unretweet.json", parameters: parameters, progress: nil, success: nil) { (task, error) in
        print("\(error.localizedDescription)")
      }
    }
  }
  
  func handleOpenUrl(url: URL) {
    let requestToken = BDBOAuth1Credential(queryString: url.query)

    fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
      self.currentAccount(success: { (user) in
        User.currentUser = user
        self.loginSuccess?()

      }, failure: { (error) in
        self.loginFailure?(error)
      })
    }) { (error) in
      print("\(error?.localizedDescription)")
      self.loginFailure?(error)
    }
  }
}
