//
//  HamburgerViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/17/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
  @IBOutlet weak var contentView: UIView!
  
  var originalLeftMargin: CGFloat!
  var menuViewController: MenuViewController! {
    didSet {
      view.layoutIfNeeded()
      menuView.addSubview(menuViewController.view)
    }
  }
  
  var contentViewController: UIViewController! {
    didSet {
      view.layoutIfNeeded()
      contentView.addSubview(contentViewController.view)
      UIView.animate(withDuration: 0.3, animations: { () -> Void in
        self.leftMarginConstraint.constant = 0
        self.view.layoutIfNeeded()
      
      })
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    self.menuViewController = menuViewController
    self.menuViewController.hamburgerViewController = self
    self.contentViewController = menuViewController.viewControllers[1]
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
  @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    let velocity = sender.velocity(in: view)
    
    if sender.state == UIGestureRecognizerState.began {
      originalLeftMargin = leftMarginConstraint.constant
    } else if sender.state == UIGestureRecognizerState.changed {
      leftMarginConstraint.constant = originalLeftMargin + translation.x
    } else if sender.state == UIGestureRecognizerState.ended {
      UIView.animate(withDuration: 0.3, animations: {
        if velocity.x > 0 {
          self.leftMarginConstraint.constant = self.view.frame.size.width - self.view.frame.size.width * 0.25
        } else {
          self.leftMarginConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
      })

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

}
