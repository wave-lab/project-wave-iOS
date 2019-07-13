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
  
  
  @IBOutlet weak var blackTableView: UITableView!
  
  var dataArray : [String] = []
  
  var searchState: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupSearchBar()
    setDummyData()
    checkData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  func setup(){
    searchBar.delegate = self
    searchTableView.delegate = self
    searchTableView.dataSource = self
    blackTableView.delegate = self
    blackTableView.dataSource = self
    searchTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    searchTableView.tableFooterView = UIView()
    blackTableView.register(HeaderCell.self, forCellReuseIdentifier: Wave.reuseIdentifier.headerCell)
    blackTableView.register(Wave.nib.horizontalSongCell, forCellReuseIdentifier: Wave.reuseIdentifier.horizontalSongCell)
    
    blackTableView.isHidden = true
    
    
  }
  
  func setupSearchBar() {
    searchBar.keyboardAppearance = .dark
    let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
    
    textFieldInsideSearchBar?.textColor = .white
    textFieldInsideSearchBar?.backgroundColor = .rgb(red: 36, green: 36, blue: 36)
  }
  
  
  func checkData(){
    print(dataArray.count)
    if dataArray.count == 0 {
      searchTableView.isHidden = true
      blackTableView.isHidden = true
      
    }
    else{
      searchTableView.isHidden = false
    }
  }
  
  func request(keyword: String?) {
    blackTableView.isHidden = keyword == "" ? true : false
    guard keyword != "" else { return }
    dataArray.append(keyword ?? "")
    checkData()
    searchState = true
    searchTableView.reloadData()
  }
  
  // 나중에 지울 예정
  func setDummyData() {
    dataArray.append("아이유")
  }
  
}

extension SearchViewController: UISearchBarDelegate{
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
    
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
    searchBar.resignFirstResponder()
    blackTableView.isHidden = true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    request(keyword: searchBar.text)
  }
  

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == blackTableView {
        return 5
    } else {
      return dataArray.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == blackTableView {
      tableView.separatorStyle = .none
      if indexPath.row == 0 {
        let cell = blackTableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.headerCell) as! HeaderCell
        cell.type = .feed
        return cell
      } else {
        let cell = blackTableView.dequeueReusableCell(withIdentifier:
          Wave.reuseIdentifier.horizontalSongCell) as! HorizontalSongCell
        return cell
      }
    } else {
      tableView.separatorStyle = .singleLine
      let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell") as! SearchTableViewCell
      let count = dataArray.count
      let data = dataArray[count - indexPath.row - 1]
      cell.historyLabel.text = data
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if tableView == blackTableView {
      if indexPath.row == 0 {
        return 41
      } else {
        return 94
      }
    } else {
      return 44
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}


