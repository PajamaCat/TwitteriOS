//
//  menuViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/17/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var tagline: UILabel!
  @IBOutlet weak var username: UILabel!
  
  var viewControllers: [UIViewController] = []
  var hamburgerViewController: HamburgerViewController!
  
  private var profileNavigationController: UINavigationController!
  private var timelineNavigationController: UINavigationController!
  private var mentionsNavigationController: UINavigationController!
  
  let titles = ["View Profile", "Home Timeline", "Mentions"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let user = User.currentUser {
      profileImage.setImageWith(user.profileUrl!)
      profileImage.layer.cornerRadius = 5
      profileImage.clipsToBounds = true
      tagline.text = user.screenName
      username.text = user.name
    }
    
    tableView.delegate = self
    tableView.dataSource = self

    // Do any additional setup after loading the view.
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileViewNavigationController") as! UINavigationController
    timelineNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsViewNavigationController") as! UINavigationController
    mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsViewNavigationController") as! UINavigationController
    
    let userProfileViewController = profileNavigationController.viewControllers[0] as! ProfileViewController
    userProfileViewController.user = User.currentUser
    
    let homeTimelineViewController = timelineNavigationController.viewControllers[0] as! TweetsViewController
    homeTimelineViewController.isFetchingMentions = false
    
    let mentionsViewController = mentionsNavigationController.viewControllers[0] as! TweetsViewController
    mentionsViewController.isFetchingMentions = true
    
    viewControllers.append(profileNavigationController)
    viewControllers.append(timelineNavigationController)
    viewControllers.append(mentionsNavigationController)

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
    cell.menuItem.text = titles[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
