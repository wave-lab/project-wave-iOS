//
//  MenuBar.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 07/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import SnapKit

class MenuBar: UIView {
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .black
    return cv
  }()
  
  lazy var indicatorBar: UIView = {
    let frame = CGRect(x: 0, y: 0, width: 50, height: 4)
    let view = UIView(frame: frame)
    view.backgroundColor = Wave.color.pointBlue
    return view
  }()
  
  var selectedIndex = IndexPath(item: 0, section: 0) {
    didSet {
      updateIndicatorBar()
    }
  }
  
  var delegate: MenuBarDelegate?
  
  var items: [String] = [] {
    didSet {
      let _ = items.map {
        widths.append($0.width(withConstrainedHeight: 33, font: Wave.font.menu))
      }
      setupIndicatorBar()
      collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
    }
  }
  var widths: [CGFloat] = []
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollectionView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MenuBar {
  func setupCollectionView() {
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: Wave.reuseIdentifier.menuCell)
    collectionView.delegate = self
    collectionView.dataSource = self
    addSubview(collectionView)
    collectionView.snp.makeConstraints { (make) in
      make.leading.top.trailing.equalToSuperview()
      make.height.equalTo(43)
    }
    collectionView.clipsToBounds = false
    collectionView.showsHorizontalScrollIndicator = false
  }
  
  func setupIndicatorBar() {
    collectionView.addSubview(indicatorBar)
    indicatorBar.snp.makeConstraints { (make) in
      make.height.equalTo(4)
      make.width.equalTo(self.widths[selectedIndex.item] + 12)
      make.top.equalToSuperview().offset(43)
      var fullWidth: CGFloat = 0
      for i in 0..<selectedIndex.item + 1 {
        if i == 0 {
          fullWidth += 16
        } else {
          fullWidth += widths[i - 1] + 16
        }
      }
      make.leading.equalToSuperview().offset(fullWidth - 6)
    }
  }
  
  func updateIndicatorBar() {
    UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseInOut, animations: {
      self.indicatorBar.snp.updateConstraints { (make) in
        var fullWidth: CGFloat = 0
        for i in 0..<self.selectedIndex.item + 1 {
          if i == 0 {
            fullWidth += 16
          } else {
            fullWidth += self.widths[i - 1] + 16
          }
        }
        make.width.equalTo(self.widths[self.selectedIndex.item] + 12)
        make.leading.equalToSuperview().offset(fullWidth - 6)
      }
      self.layoutIfNeeded()
    })
  }
  
  func selectItem(_ indexPath: IndexPath) {
    self.delegate?.scrollToMenu(indexPath: indexPath)
    selectedIndex = indexPath
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

extension MenuBar: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Wave.reuseIdentifier.menuCell, for: indexPath) as! MenuCell
    let item = items[indexPath.item]
    cell.menuLabel.text = item
    cell.tintColor = .white
    return cell
  }
  
}

extension MenuBar: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = widths[indexPath.item]
    return CGSize(width: width, height: 33)
  }
}

extension MenuBar: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.selectItem(indexPath)
  }
}
