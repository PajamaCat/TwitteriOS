//
//  ProfileViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/10/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var user: User!
  var tweets: [Tweet]!

  @IBOutlet weak var viewHolder: UIView!
  @IBOutlet weak var numFollower: UILabel!
  @IBOutlet weak var numFollowing: UILabel!
  @IBOutlet weak var location: UILabel!
  @IBOutlet weak var screenName: UILabel!
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    numFollower.text = String(user.numFollowers)
    numFollowing.text = String(user.numFollowing)
    screenName.text = user.screenName
    username.text = user.name
    location.text = user.location
    userProfileImageView.setImageWith(user.profileUrl!)
    userProfileImageView.layer.cornerRadius = 10
    userProfileImageView.clipsToBounds = true
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 125
    
    let parameters: [String : String] = ["screen_name": user.screenName!]
    
    TwitterClient.sharedInstance?.userTimeline(parameters: parameters, success: { (tweets) in
      self.tweets = tweets
      self.tableView.reloadData()
    }, failure: { (error) in
      print("error: \(error.localizedDescription)")
    })
    // Do any additional setup after loading the view.
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
    cell.timestamp.text = tweet.timestamp
    cell.content.text = tweet.text
    return cell
  }

}
