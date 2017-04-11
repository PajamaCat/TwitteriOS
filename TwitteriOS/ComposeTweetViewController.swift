//
//  ComposeTweetViewController.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/10/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

@objc protocol ComposeTweetViewControllerDelegate {
  @objc optional func composeTweetViewControllerOnTweetComposed(_ composeTweetViewController: ComposeTweetViewController)
}

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var thumbnailImage: UIImageView!
  @IBOutlet weak var remainingChars: UILabel!
  @IBOutlet weak var tweetBtn: UIButton!
  @IBOutlet weak var textView: UITextView!
  
  weak var delegate: ComposeTweetViewControllerDelegate?
  
  let maxCharCount = 140
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.delegate = self
    
    tweetBtn.layer.cornerRadius = 5
    tweetBtn.clipsToBounds = true
    thumbnailImage.setImageWith((User.currentUser?.profileUrl)!)
    thumbnailImage.layer.cornerRadius = 5
    thumbnailImage.clipsToBounds = true
      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onExitButtonClicked(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */
  
  @IBAction func onComposeTweetClicked(_ sender: UIButton) {
    TwitterClient.sharedInstance?.postTweet(tweetContent: textView.text)
    delegate?.composeTweetViewControllerOnTweetComposed!(self)
    dismiss(animated: true, completion: nil)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    return textView.text.characters.count + (text.characters.count - range.length) <= maxCharCount
  }
  
  func textViewDidChange(_ textView: UITextView) {
    remainingChars.text = String(maxCharCount - textView.text.characters.count)
  }

}
