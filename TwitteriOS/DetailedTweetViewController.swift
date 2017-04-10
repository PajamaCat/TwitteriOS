//
//  DetailedTweetViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/10/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class DetailedTweetViewController: UIViewController {
  
  var tweet: Tweet!

  @IBOutlet weak var content: UILabel!
  @IBOutlet weak var timestamp: UILabel!
  @IBOutlet weak var screenName: UILabel!
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    content.text = tweet.text
    timestamp.text = tweet.timestamp
    screenName.text = tweet.user?.screenName
    username.text = tweet.user?.name
    profileImage.setImageWith((tweet.user?.profileUrl)!)
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

}
