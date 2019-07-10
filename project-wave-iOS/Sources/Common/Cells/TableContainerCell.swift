//
//  TableContainerCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 09/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import SnapKit

class TableContainerCell: CollectionViewCell {
  
  public enum TableType {
    case song
    case playlist
    case assess
  }
  
  var items: [String]?
  
  lazy var tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.backgroundColor = .black
    tv.separatorStyle = .none
    tv.dataSource = self
    tv.contentInset = UIEdgeInsets(top: 52, left: 0, bottom: 0, right: 0)
    tv.scrollIndicatorInsets = UIEdgeInsets(top: 52, left: 0, bottom: 0, right: 0)
    return tv
  }()
  
  override func setupView() {
    super.setupView()
    addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.leading.top.trailing.bottom.equalToSuperview()
    }
    tableView.register(Wave.nib.horizontalSongCell, forCellReuseIdentifier: Wave.reuseIdentifier.horizontalSongCell)
  }
}

extension TableContainerCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.horizontalSongCell) as! HorizontalSongCell
    let item = items?[indexPath.row]
    cell.item = item
    return cell
  }
}

extension TableContainerCell {
  func setTableViewDelegate<D: UITableViewDelegate>(_ delegate: D, for row: Int) {
    tableView.delegate = delegate
    tableView.reloadData()
    tableView.scrollsToTop = true
  }
}
