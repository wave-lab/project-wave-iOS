//
//  BaseCollectionCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 09/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    self.backgroundColor = .black
  }
}

class TableViewCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    
  }
}
