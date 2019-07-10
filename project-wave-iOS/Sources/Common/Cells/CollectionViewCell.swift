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
    
  }
}
