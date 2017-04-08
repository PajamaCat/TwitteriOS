//
//  LoginViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/5/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onLoginClicked(_ sender: UIButton) {
    let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey:"c8UpZxaUQJzx4NmPyDzyheIN2", consumerSecret: "SJTW1AaOPlbKpjreev92epFgL0fjDUN5bWsVCnhbgREl7yKNZ0")
    twitterClient?.deauthorize()
    twitterClient?.fetchRequestToken(
      withPath: "oauth/request_token",
      method: "GET", callbackURL: URL(string: "twitterios://oauth"), scope: nil,
      success: { (requestToken: BDBOAuth1Credential?) -> Void in
        print("I got a token!")
        if let urlString = requestToken?.token {
          let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(urlString)")!
          print(url)
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    },
      failure:  { (error: Error?) -> Void in print("error: \(error?.localizedDescription)")})
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
