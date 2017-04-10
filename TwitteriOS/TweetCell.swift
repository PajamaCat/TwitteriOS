//
//  TweetCell.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/9/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
  @objc optional func onThumbnailTapped(tweetCell: TweetCell)
}

class TweetCell: UITableViewCell {

  @IBOutlet weak var thumbnailImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var tagline: UILabel!
  @IBOutlet weak var timestamp: UILabel!
  @IBOutlet weak var content: UILabel!
  @IBOutlet weak var replyBtn: UIButton!
  @IBOutlet weak var retweetBtn: UIButton!
  @IBOutlet weak var loveBtn: UIButton!
  
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
    print("tapped")
    delegate?.onThumbnailTapped!(tweetCell: self)

  }

}
