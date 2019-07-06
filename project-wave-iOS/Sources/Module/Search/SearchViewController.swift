//
//  SearchViewController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  @IBOutlet weak var searchImage: UIImageView!
  
  @IBOutlet weak var searchResultCollectionView: UICollectionView!
  
  var dataArray : [String] = []
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setNeedsStatusBarAppearanceUpdate()
    checkData()
  }
  
  func setup(){
    searchBar.delegate = self
    searchTableView.delegate = self as? UITableViewDelegate
    searchTableView.dataSource = self as? UITableViewDataSource
  }
  
  func checkData(){
    if dataArray.count == 0{
      searchTableView.isHidden = true
    }
    else{
      searchTableView.isHidden = false
    }
  }
  
  func request(keyword: String?) {
    
    print(keyword ?? "")
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


