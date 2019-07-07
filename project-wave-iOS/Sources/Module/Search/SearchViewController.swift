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
    return dataArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell") as! SearchTableViewCell
    let count = dataArray.count
    let data = dataArray[count - indexPath.row - 1]
    cell.historyLabel.text = data
    
    return cell
  }
  
  
}


