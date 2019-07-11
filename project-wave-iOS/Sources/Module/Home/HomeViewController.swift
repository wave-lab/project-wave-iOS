//
//  HomeViewController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {
  @IBOutlet weak var topBackgroundView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  var titles: [String] = ["오늘의 평가 요청곡", "휴지류의 평가를 기다리는 곡", "최근 평가 적중곡", "휴지류님을 위한 추천곡", "TOP10 장르", "TOP10 무드"]
  var items: [[String]] = [["", "", "", ""], ["", "", "", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", "", ""], ["", "", "", "", "", ""], ["", "", "", "", "", ""]]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  override func setupView() {
    super.setupView()
    topBackgroundView.setupGradient(
      colors: [
        UIColor.rgb(red: 0, green: 182, blue: 222).cgColor,
        UIColor.rgb(red: 0, green: 182, blue: 222).cgColor],
      locations: [0, 1.0])
    let layer = CALayer()
    layer.frame = topBackgroundView.bounds
    layer.backgroundColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
    topBackgroundView.layer.addSublayer(layer)
    
    setupTableView()
  }
  
}

extension HomeViewController {
  
  func setupTableView() {
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(HeaderCell.self, forCellReuseIdentifier: Wave.reuseIdentifier.headerCell)
    tableView.register(CollectionContainerCell.self, forCellReuseIdentifier: Wave.reuseIdentifier.collectionContainer)
    
  }
}

extension HomeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return items.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.headerCell) as! HeaderCell
      let title = titles[indexPath.section]
      cell.type = .home
      cell.title = title
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.collectionContainer) as! CollectionContainerCell
      let item = items[indexPath.section]
      if indexPath.section == 0 {
        cell.type = .dday
      } else if indexPath.section == 1 {
        cell.type = .small
      } else if indexPath.section == 2 {
        cell.type = .big
      } else if indexPath.section == 3 {
        cell.type = .big
      } else if indexPath.section == 4 {
        cell.type = .genre
      } else if indexPath.section == 5 {
        cell.type = .genre
      }
      cell.items = item
      
      return cell
    }
    
  }
  
  
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard section == 0 else { return nil }
    let view = Bundle.main.loadNibNamed("HomeInfoView", owner: self, options: nil)?.first as! HomeInfoView
    view.delegate = self
    return view
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let height: CGFloat = section == 0 ? 595 : CGFloat.leastNormalMagnitude
    return height
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 46
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 41
    } else {
      if indexPath.section == 0 {
        return 160
      } else if indexPath.section == 1 {
        return 124
      } else if indexPath.section == 2 {
        return 217
      } else if indexPath.section == 3 {
        return 217
      } else if indexPath.section == 4 {
        return 152
      } else if indexPath.section == 5 {
        return 152
      } else {
        return 0
      }
    }
  }
}

extension HomeViewController: HomeInfoDelegate {
  func scrollToFeed() {
    let indexPath = IndexPath(row: 1, section: 0)
    tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
  }
}
