//
//  BigSongCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class BigSongCell: CollectionViewCell {
  
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
    label.font = UIFont(name: "NotoSansKR-Bold", size: 13)
    label.textAlignment = .center
    return label
  }()
  
  lazy var subTitle: UILabel = {
    let label = UILabel()
    label.text = "Sub Title"
    label.textColor = .white
    label.font = UIFont(name: "NotoSansKR-Regular", size: 10)
    label.textAlignment = .center
    return label
  }()
  
  lazy var stackView: UIStackView = {
    let stv = UIStackView()
    stv.axis = .vertical
    stv.distribution = .fill
    stv.alignment = .fill
    stv.spacing = 2
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
      make.height.equalTo(27)
    }
    subTitle.snp.makeConstraints { (make) in
      make.height.equalTo(20)
    }
    stackView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension BigSongCell {
  func setupItem() {
    
    self.title.text = song?.title
    self.subTitle.text = song?.subTitle
    self.title.sizeToFit()
    self.subTitle.sizeToFit()
  }
}
