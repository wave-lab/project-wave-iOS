//
//  SmallSongCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import SnapKit

class SmallSongCell: CollectionViewCell {
  
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
    label.layer.masksToBounds = true
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
    stv.alignment = .center
    stv.spacing = 5
    return stv
  }()
  
  override func setupView() {
    super.setupView()
    self.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.leading.top.bottom.trailing.equalToSuperview()
    }
    stackView.addArrangedSubview(title)
    stackView.addArrangedSubview(subTitle)
    self.addSubview(stackView)
    
    title.snp.makeConstraints { (make) in
      make.width.equalTo(self.imageView).multipliedBy(0.8)
    }
    subTitle.snp.makeConstraints { (make) in
      make.width.lessThanOrEqualTo(self.imageView)
    }
    stackView.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
  }
}

extension SmallSongCell {
  
  func setupItem() {
    self.imageView.download(song?.artwork, defaultImage: "")
    self.title.text = "\(song?.originTitle ?? "")-\(song?.originArtistName ?? "")"
    self.subTitle.text = song?.coverArtistName
    self.subTitle.sizeToFit()
  } 
}
