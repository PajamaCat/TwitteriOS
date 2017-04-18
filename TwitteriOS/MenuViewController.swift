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
  
  var viewControllers: [UIViewController] = []
  var hamburgerViewController: HamburgerViewController!
  
  private var userProfileViewController: UIViewController!
  private var homeTimelineViewController: UIViewController!
  private var mentionsViewController: UIViewController!
  
  let titles = ["View Profile", "Home Timeline", "Mentions"]
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self

    // Do any additional setup after loading the view.
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    userProfileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewNavigationController")
    homeTimelineViewController = storyboard.instantiateViewController(withIdentifier: "TweetsViewNavigationController")
    mentionsViewController = storyboard.instantiateViewController(withIdentifier: "TweetsViewNavigationController")
    
    viewControllers.append(userProfileViewController)
    viewControllers.append(homeTimelineViewController)
    viewControllers.append(mentionsViewController)

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
