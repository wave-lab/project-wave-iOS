//
//  LibraryViewController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import SnapKit

class LibraryViewController: ViewController {
  
  @IBOutlet weak var titleView: UIView!
  @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var menuContainer: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  lazy var menuBar: MenuBar = {
    let mb = MenuBar()
    mb.items = Wave.string.library
    return mb
  }()
  
  var lastContentOffset: CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupMenuBar()
    setupCollectionView()
  }
}

extension LibraryViewController {
  func setup() {
    view.backgroundColor = .black
    titleView.clipsToBounds = false
    
  }
  
  func setupMenuBar() {
    menuContainer.addSubview(menuBar)
    menuBar.snp.makeConstraints { (make) in
      make.leading.trailing.top.bottom.equalToSuperview()
    }
    menuBar.delegate = self
  }
  
  func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(TableContainerCell.self, forCellWithReuseIdentifier: Wave.reuseIdentifier.tableContainer)
  }
}

extension LibraryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? TableContainerCell else { return }
    let delegate = self as UITableViewDelegate
    cell.setTableViewDelegate(delegate, for: indexPath.item)
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? TableContainerCell else { return }
    cell.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Wave.string.library.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Wave.reuseIdentifier.tableContainer, for: indexPath) as! TableContainerCell
    if indexPath.item == 0 {
      cell.items = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
    } else {
      cell.items = ["", "", "", "", "", "", "", "", "", "", "", ""]
    }
    return cell
  }
  
  
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 52, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height - 52)
  }
  
  
}

extension LibraryViewController: UICollectionViewDelegate, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 94
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard scrollView is UITableView else { return }
    
    let absoluteTop: CGFloat = 0
    let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
    
    let scrollDiff = scrollView.contentOffset.y - lastContentOffset
    let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
    let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

    if isScrollingDown {
      animateTitleView(isHidden: true)
    } else if isScrollingUp {
      animateTitleView(isHidden: false)
    }
    lastContentOffset = scrollView.contentOffset.y
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    guard scrollView == collectionView else { return }
    let cellWidth = UIScreen.main.bounds.width
    var offset = targetContentOffset.pointee
    let index = offset.x / cellWidth
    var roundedIndex = round(index)
    if (index - floor(index)) < 0.5 {
      roundedIndex = floor(index)
    } else {
      roundedIndex = ceil(index)
    }
    offset = CGPoint(x: roundedIndex * cellWidth, y: 0)
    targetContentOffset.pointee = offset
    let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
    menuBar.selectItem(indexPath)
    menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
  
  func animateTitleView(isHidden: Bool) {
    UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
      self.titleViewHeight.constant = isHidden ? 0 : 52
      self.titleLabel.alpha = isHidden ? 0 : 1
      self.view.layoutIfNeeded()
    })
  }
  
  
}

extension LibraryViewController: MenuBarDelegate {
  func scrollToMenu(indexPath: IndexPath) {
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    animateTitleView(isHidden: false)

  }
}
