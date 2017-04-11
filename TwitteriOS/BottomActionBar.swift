//
//  BottomActionBar.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/10/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

@objc protocol BottomActionBarDelegate {
  @objc func bottomActionBar(onCommentTapped: BottomActionBar)
  @objc func bottomActionBar(bottomActionBar: BottomActionBar, onRetweetTapped value: Bool)
  @objc func bottomActionBar(bottomActionBar: BottomActionBar, onFavoriteTapped value: Bool)
}

class BottomActionBar: UIView {

  @IBOutlet weak var commentIcon: UIButton!
  @IBOutlet weak var retweetIcon: UIButton!
  @IBOutlet weak var loveIcon: UIButton!
  
  var favorited: Bool = false
  var retweeted: Bool = false
  
  weak var delegate: BottomActionBarDelegate?
  
  override func awakeFromNib() {
    let commentImg = #imageLiteral(resourceName: "reply").withRenderingMode(.alwaysTemplate)
    commentIcon.setImage(commentImg, for: .normal)
    commentIcon.tintColor = UIColor.lightGray
    
    let retweetImg = #imageLiteral(resourceName: "retweet").withRenderingMode(.alwaysTemplate)
    retweetIcon.setImage(retweetImg, for: .normal)
    setRetweeted(value: retweeted)

    let favoriteImg = #imageLiteral(resourceName: "love").withRenderingMode(.alwaysTemplate)
    loveIcon.setImage(favoriteImg, for: .normal)
    setFavorited(value: favorited)
  }
  
  @IBAction func onCommentTapped(_ sender: UIButton) {
    delegate?.bottomActionBar(onCommentTapped: self)
  }
  
  @IBAction func onRetweetTapped(_ sender: UIButton) {
    retweeted = !retweeted
    if retweeted {
      retweetIcon.tintColor = UIColor.green
    } else {
      retweetIcon.tintColor = UIColor.gray
    }
    delegate?.bottomActionBar(bottomActionBar: self, onRetweetTapped: retweeted)
  }
  
  @IBAction func onFavoriteTapped(_ sender: UIButton) {
    favorited = !favorited
    if favorited {
      loveIcon.tintColor = UIColor.red
    } else {
      loveIcon.tintColor = UIColor.lightGray
    }
    delegate?.bottomActionBar(bottomActionBar: self, onFavoriteTapped: favorited)
  }
  
  func setRetweeted(value: Bool) {
    retweeted = value
    if retweeted {
      retweetIcon.tintColor = UIColor.green
    } else {
      retweetIcon.tintColor = UIColor.lightGray
    }
  }
  
  func setFavorited(value: Bool) {
    favorited = value
    if favorited {
      loveIcon.tintColor = UIColor.red
    } else {
      loveIcon.tintColor = UIColor.lightGray
    }
  }
  
}
