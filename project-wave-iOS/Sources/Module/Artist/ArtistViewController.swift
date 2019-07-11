//
//  ArtistViewController.swift
//  project-wave-iOS
//
//  Created by yejin on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class ArtistViewController: ViewController {
  
  @IBOutlet weak var artistTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
  }
  
  func setup(){
    artistTableView.separatorStyle = .none
    artistTableView.delegate = self
    artistTableView.dataSource = self
    artistTableView.register(Wave.nib.headerCell, forCellReuseIdentifier: Wave.reuseIdentifier.headerCell)
    artistTableView.register(Wave.nib.horizontalSongCell, forCellReuseIdentifier: Wave.reuseIdentifier.horizontalSongCell)
    
  }
  
}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = artistTableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.headerCell) as! HeaderCell
      
      return cell
    } else {
      let cell = artistTableView.dequeueReusableCell(withIdentifier:
        Wave.reuseIdentifier.horizontalSongCell) as! HorizontalSongCell
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 41
    } else {
      return 85
    }
  }
  
  
  
}

