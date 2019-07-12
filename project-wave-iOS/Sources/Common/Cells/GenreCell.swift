//
//  GenreCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import SnapKit

class GenreCell: CollectionViewCell {
  
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
    label.font = UIFont(name: "NotoSansKR-Bold", size: 14)
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
      make.width.height.equalTo(self.snp.width)
      make.leading.top.trailing.equalToSuperview()
    }
    
    stackView.addArrangedSubview(title)
    self.addSubview(stackView)
    title.snp.makeConstraints { (make) in
      make.height.equalTo(20)
    }
    stackView.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview()
    }
  }
}

extension GenreCell {
  
  func setupItem() {
    
    self.title.text = song?.coverArtistName
    self.title.sizeToFit()
  }
}
