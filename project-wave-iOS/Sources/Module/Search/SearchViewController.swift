//
//  SearchViewController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class SearchViewController: ViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  @IBOutlet weak var searchImage: UIImageView!
  
  @IBAction func deleteButton(_ sender: Any) {
    dataArray.removeAll()
    checkData()
  }
  
  var dataArray : [String] = []
  
  var searchState: Bool = false
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setDummyData()
    setNeedsStatusBarAppearanceUpdate()
    checkData()
  }
  
  func setup(){
    searchBar.delegate = self
    searchTableView.delegate = self
    searchTableView.dataSource = self
    searchTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    searchTableView.tableFooterView = UIView()
    searchTableView.register(Wave.nib.headerCell, forCellReuseIdentifier: Wave.reuseIdentifier.headerCell)
    searchTableView.register(Wave.nib.horizontalSongCell, forCellReuseIdentifier: Wave.reuseIdentifier.horizontalSongCell)
  }

  
  func checkData(){
    print(dataArray.count)
    if dataArray.count == 0 {
      searchTableView.isHidden = true
    }
    else{
      searchTableView.isHidden = false
    }
  }
  
  func request(keyword: String?) {
    dataArray.append(keyword ?? "")
    checkData()
    searchState = true
    searchTableView.separatorStyle = .none
    searchTableView.reloadData()
  }
  
  // 나중에 지울 예정
  func setDummyData() {
    //dataArray.append("아이유")
    dataArray.append("김예진")
  }
  
}

extension SearchViewController: UISearchBarDelegate{
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
    
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
    searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    request(keyword: searchBar.text)
  }
  

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    if section == 0 {
//
//    } else if section == 1 {
//
//    }
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    if indexPath.section == 0 {
//
//    } else if indexPath.section == 1 {
//
//    }
//    
//
    if indexPath.row == 0 {
      let cell = searchTableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.headerCell) as! HeaderCell
      cell.item = "원곡 아티스트"
      return cell
    } else {
      let cell = searchTableView.dequeueReusableCell(withIdentifier:
        Wave.reuseIdentifier.horizontalSongCell) as! HorizontalSongCell
      return cell
    }
    
    
//    let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell") as! SearchTableViewCell
//    let count = dataArray.count
//    let data = dataArray[count - indexPath.row - 1]
//    cell.historyLabel.text = data
//
//    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 41
    } else {
      return 94
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}


