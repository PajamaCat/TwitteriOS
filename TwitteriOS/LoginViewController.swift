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
    TwitterClient.sharedInstance?.login(success: { () -> () in
      self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }) { (error) -> () in
      print("error:\(error?.localizedDescription)")
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    let hamburgerViewController = segue.destination as! HamburgerViewController
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
//
//    menuViewController.hamburgerViewController = hamburgerViewController
//    hamburgerViewController.menuViewController = menuViewController
//  }

}
