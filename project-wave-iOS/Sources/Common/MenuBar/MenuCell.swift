//
//  MenuCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 07/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
  
  let menuLabel: UILabel = {
    let label = UILabel()
    label.text = "장르"
    label.font = Wave.font.menu
    label.textColor = Wave.color.brownishGray
    label.tintColor = .white
    return label
  }()
  
  override var isHighlighted: Bool {
    didSet {
      menuLabel.textColor = isHighlighted ? .white : Wave.color.brownishGray
    }
  }
  
  override var isSelected: Bool {
    didSet {
      menuLabel.textColor = isSelected ? .white : Wave.color.brownishGray
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MenuCell {
  func setupViews() {
    menuLabel.textAlignment = .center
    addSubview(menuLabel)
    menuLabel.snp.makeConstraints { make in
      make.leading.trailing.top.bottom.equalToSuperview()
    }
  }
}
