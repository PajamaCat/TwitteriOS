//
//  TweetsViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/8/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
  
  var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
        self.tweets = tweets
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

}
