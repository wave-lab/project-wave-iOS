//
//  HeaderCell.swift
//  project-wave-iOS
//
//  Created by yejin on 07/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

import UIKit
import SnapKit

class HeaderCell: TableViewCell {
  
  public enum HeaderType {
    case home
    case feed
  }
  
  var type: HeaderType = .home {
    didSet {
      setupHeaderType()
    }
  }
  
  var title: String? {
    didSet {
      setTitle()
    }
  }
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Title"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    return label
  }()
  
  lazy var arrowImage: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(imageLiteralResourceName: "btnMore")
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  override func setupView() {
    super.setupView()
    self.backgroundColor = .black
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      let width = title?.width(withConstrainedHeight: 29, font: UIFont.boldSystemFont(ofSize: 20))
      make.width.equalTo(width ?? 50)
      make.height.equalTo(29)
      make.centerX.centerY.equalToSuperview()
    }
    addSubview(arrowImage)
    arrowImage.snp.makeConstraints { (make) in
      make.width.height.equalTo(24)
      make.leading.equalTo(titleLabel.snp.trailing).offset(8)
      make.centerY.equalTo(titleLabel.snp.centerY)
    }
  }
}

extension HeaderCell {
  func setupHeaderType() {
    switch self.type {
    case .home:
      self.titleLabel.snp.removeConstraints()
      titleLabel.snp.makeConstraints { (make) in
        let width = title?.width(withConstrainedHeight: 29, font: UIFont.boldSystemFont(ofSize: 20))
        make.width.equalTo(width ?? 50)
        make.height.equalTo(29)
        make.centerX.centerY.equalToSuperview()
      }
    case .feed:
      self.titleLabel.snp.removeConstraints()
      titleLabel.snp.makeConstraints { (make) in
        let width = title?.width(withConstrainedHeight: 29, font: UIFont.boldSystemFont(ofSize: 20))
        make.width.equalTo(width ?? 50)
        make.height.equalTo(29)
        make.centerY.equalToSuperview()
        make.leading.equalToSuperview().offset(16)
      }
    }
  }
  
  func setTitle() {
    self.titleLabel.text = title
    self.titleLabel.snp.updateConstraints { (make) in
      let width = title?.width(withConstrainedHeight: 29, font: UIFont.boldSystemFont(ofSize: 20))
      make.width.equalTo(width ?? 50)
    }
    setNeedsLayout()
  }
}
