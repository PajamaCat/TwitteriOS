//
//  TweetCell.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/9/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
  @objc optional func tweetCellOnThumbnailTapped(_ tweetCell: TweetCell)
  @objc func tweetCellShouldRefreshTweets(_ tweetCell: TweetCell)
}

class TweetCell: UITableViewCell, BottomActionBarDelegate {

  @IBOutlet weak var thumbnailImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var tagline: UILabel!
  @IBOutlet weak var timestamp: UILabel!
  @IBOutlet weak var content: UILabel!
  @IBOutlet weak var bottomActionBar: BottomActionBar!
  
  weak var delegate: TweetCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    thumbnailImage.layer.cornerRadius = 5
    thumbnailImage.clipsToBounds = true
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageTapped(gesture:)))
    
    // add it to the image view;
    thumbnailImage.addGestureRecognizer(tapGesture)
    // make sure imageView can be interacted with by user
    thumbnailImage.isUserInteractionEnabled = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
  
  func onImageTapped(gesture: UIGestureRecognizer) {
    delegate?.tweetCellOnThumbnailTapped!(self)
  }
  
  func bottomActionBar(onCommentTapped: BottomActionBar) {
    //
  }
  
  func bottomActionBar(bottomActionBar: BottomActionBar, onFavoriteTapped value: Bool) {
    delegate?.tweetCellShouldRefreshTweets(self)
  }
  
  func bottomActionBar(bottomActionBar: BottomActionBar, onRetweetTapped value: Bool) {
    delegate?.tweetCellShouldRefreshTweets(self)
  }
  
}
