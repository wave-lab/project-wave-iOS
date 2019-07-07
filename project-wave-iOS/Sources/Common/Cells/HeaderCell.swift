//
//  HeaderCell.swift
//  project-wave-iOS
//
//  Created by yejin on 07/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
  
  @IBOutlet weak var headerLabel: UILabel!
  
  var item: String? {
    didSet {
      setItem()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func setItem() {
    headerLabel.text = item
    headerLabel.sizeToFit()
  }
  
  
}
