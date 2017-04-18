//
//  MenuCell.swift
//  TwitteriOS
//
//  Created by jiafang_jiang on 4/17/17.
//  Copyright © 2017 jiafang_jiang. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

  @IBOutlet weak var menuItem: UILabel!
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
