//
//  TweetsViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/8/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate, ComposeTweetViewControllerDelegate, DetailedTweetViewControllerDelegate {
  
  var tweets: [Tweet]!
  var shouldRefreshTweets: Bool = false
  var refreshControl: UIRefreshControl!
  var isFetchingMentions: Bool = false

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    titleImageView.contentMode = .scaleAspectFit
    titleImageView.image = #imageLiteral(resourceName: "twitter")
    self.navigationItem.titleView = titleImageView
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 125
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TweetsViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
    tableView.insertSubview(refreshControl, at: 0)
    
    fetchTweets()
      // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if shouldRefreshTweets {
      fetchTweets()
      shouldRefreshTweets = false
    }
  }
  
  func fetchTweets() {
    if isFetchingMentions {
      TwitterClient.sharedInstance?.mentions(success: { (tweets) in
        self.onTweetsFetchedSuccess(tweets: tweets)
      }, failure: { (error) in
        self.onTweetsFetchedFailure(error: error)
      })
    } else {
      TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
        self.onTweetsFetchedSuccess(tweets: tweets)
      }, failure: { (error) in
        self.onTweetsFetchedFailure(error: error)
      })
    }
  }
  
  func onTweetsFetchedSuccess(tweets: [Tweet]) {
    self.tweets = tweets
    self.tableView.reloadData()
    self.refreshControl.endRefreshing()
  }
  
  func onTweetsFetchedFailure(error: Error) {
    print("error: \(error.localizedDescription)")
    self.refreshControl.endRefreshing()
  }
  
  func refreshControlAction(_ refreshControl: UIRefreshControl) {
    fetchTweets()
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets == nil ? 0 : tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet Cell") as! TweetCell
    let tweet = tweets[indexPath.row]
    
    cell.userName.text = tweet.user?.name
    cell.tagline.text = tweet.user?.screenName
    cell.thumbnailImage.setImageWith((tweet.user?.profileUrl)!)
    cell.timestamp.text = tweet.abbreviatedTimestamp()
    cell.content.text = tweet.text
    cell.bottomActionBar.setFavorited(value: tweet.favorited)
    cell.bottomActionBar.setRetweeted(value: tweet.retweeted)
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tweetCellOnThumbnailTapped(_ tweetCell: TweetCell) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
    
    profileViewController.user = tweets[(tableView.indexPath(for: tweetCell)?.row)!].user
    self.navigationController?.pushViewController(profileViewController, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? TweetCell {
      let indexPath = tableView.indexPath(for: cell)
      let tweet = tweets[indexPath!.row]
      
      let detailViewController = segue.destination as! DetailedTweetViewController
      detailViewController.tweet = tweet
    } else if (sender as? UIBarButtonItem != nil) {
      let composeTweetViewController = segue.destination as! ComposeTweetViewController
      composeTweetViewController.delegate = self
    }
  }
  
  func composeTweetViewControllerOnTweetComposed(_ composeTweetViewController: ComposeTweetViewController) {
    shouldRefreshTweets = true
  }
  
  func detailedTweetViewControllerShouldRefreshTweets(detailedTweetViewController: DetailedTweetViewController) {
    shouldRefreshTweets = true
  }
  
  func tweetCellShouldRefreshTweets(_ tweetCell: TweetCell) {
    shouldRefreshTweets = true
  }

}
