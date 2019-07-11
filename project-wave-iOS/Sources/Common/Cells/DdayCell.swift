//
//  DdayCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import SnapKit

class DdayCell: CollectionViewCell {
  
  var song: Song? {
    didSet {
      setupItem()
    }
  }
  
  lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = .darkGray
    return iv
  }()
  
  lazy var title: UILabel = {
    let label = UILabel()
    label.text = "Title"
    label.textColor = .white
    label.font = UIFont(name: "NotoSansKR-Bold", size: 30)
    label.textAlignment = .center
    return label
  }()
  
  lazy var subTitle: UILabel = {
    let label = UILabel()
    label.text = "Sub Title"
    label.textColor = .white
    label.font = UIFont(name: "NotoSansKR-Regular", size: 14)
    label.textAlignment = .center
    return label
  }()
  
  lazy var stackView: UIStackView = {
    let stv = UIStackView()
    stv.axis = .vertical
    stv.distribution = .fill
    stv.alignment = .fill
    stv.spacing = 0
    return stv
  }()
  
  override func setupView() {
    super.setupView()
    self.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.width.height.equalTo(self.snp.width)
    }
    stackView.addArrangedSubview(title)
    stackView.addArrangedSubview(subTitle)
    self.addSubview(stackView)
    
    title.snp.makeConstraints { (make) in
      make.height.equalTo(40)
    }
    subTitle.snp.makeConstraints { (make) in
      make.height.equalTo(26)
    }
    stackView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.centerX.centerY.equalToSuperview()
    }
  }
}

extension DdayCell {
  func setupItem() {
    
    self.title.text = song?.title
    self.subTitle.text = song?.subTitle
    self.title.sizeToFit()
    self.subTitle.sizeToFit()
  }
}
