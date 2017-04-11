//
//  DetailedTweetViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/10/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

@objc protocol DetailedTweetViewControllerDelegate {
  @objc optional func detailedTweetViewControllerShouldRefreshTweets(detailedTweetViewController: DetailedTweetViewController)
}

class DetailedTweetViewController: UIViewController, BottomActionBarDelegate {
  
  var tweet: Tweet!

  @IBOutlet weak var content: UILabel!
  @IBOutlet weak var timestamp: UILabel!
  @IBOutlet weak var screenName: UILabel!
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var numRetweets: UILabel!
  @IBOutlet weak var numFavorites: UILabel!
  @IBOutlet weak var bottomActionBar: BottomActionBar!
  weak var delegate: DetailedTweetViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    content.text = tweet.text
    timestamp.text = tweet.fullTimestamp()
    screenName.text = tweet.user?.screenName
    username.text = tweet.user?.name
    numRetweets.text = String(tweet.retweetCount)
    numFavorites.text = String(tweet.favoritesCount)
    profileImage.setImageWith((tweet.user?.profileUrl)!)
    profileImage.layer.cornerRadius = 5
    profileImage.clipsToBounds = true
    
    bottomActionBar.delegate = self
    bottomActionBar.setFavorited(value: tweet.favorited)
    bottomActionBar.setRetweeted(value: tweet.retweeted)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */
  
  func bottomActionBar(bottomActionBar: BottomActionBar, onFavoriteTapped value: Bool) {
    TwitterClient.sharedInstance?.favorites(id: tweet.id, value: value)
    if value {
      numFavorites.text = String(Int(numFavorites.text!)! + 1)
    } else {
      numFavorites.text = String(Int(numFavorites.text!)! - 1)
    }
    
    delegate?.detailedTweetViewControllerShouldRefreshTweets!(detailedTweetViewController: self)
  }
  
  func bottomActionBar(onCommentTapped: BottomActionBar) {
    //
  }
  
  func bottomActionBar(bottomActionBar: BottomActionBar, onRetweetTapped value: Bool) {
    TwitterClient.sharedInstance?.retweet(id: tweet.id, value: value)
    if value {
      numRetweets.text = String(Int(numRetweets.text!)! + 1)
    } else {
      numRetweets.text = String(Int(numRetweets.text!)! - 1)
    }
    delegate?.detailedTweetViewControllerShouldRefreshTweets!(detailedTweetViewController: self)
  }

}
