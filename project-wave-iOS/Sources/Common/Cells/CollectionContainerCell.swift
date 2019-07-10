//
//  CollectionContainerCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import UIKit

class CollectionContainerCell: TableViewCell {
  
  public enum CollectionType {
    case big
    case dday
    case small
    case genre
    case artist
  }
  
  var type: CollectionType = .small
  
  var items: [String]?
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .black
    cv.delegate = self
    cv.dataSource = self
    return cv
  }()
  
  override func setupView() {
    super.setupView()
    addSubview(collectionView)
    collectionView.snp.makeConstraints { (make) in
      make.leading.top.trailing.bottom.equalToSuperview()
    }
    collectionView.register(SmallSongCell.self, forCellWithReuseIdentifier: "SmallSongCell")
    collectionView.register(BigSongCell.self, forCellWithReuseIdentifier: "BigSongCell")
  }
}

extension CollectionContainerCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch self.type {
    case .big:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BigSongCell", for: indexPath) as! BigSongCell
      return cell
    case .small:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallSongCell", for: indexPath) as! SmallSongCell
      return cell
    case .artist:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallSongCell", for: indexPath) as! SmallSongCell
      return cell
    case .dday:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallSongCell", for: indexPath) as! SmallSongCell
      return cell
    case .genre:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallSongCell", for: indexPath) as! SmallSongCell
      return cell
    }
  }
  
}

extension CollectionContainerCell: UICollectionViewDelegate {
  
}

extension CollectionContainerCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    switch self.type {
    case .big, .dday, .artist:
      return 16
    case .small, .genre:
      return 12
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch self.type {
    case .big:
      let height = self.frame.height - 10 - 10
      let width = height - 57
      return CGSize(width: width, height: height)
    case .small:
      let size = self.frame.height - 10 - 10
      return CGSize(width: size, height: size)
    default:
      return CGSize(width: 10, height: 10)
    }
  }
}
