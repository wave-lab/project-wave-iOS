//
//  ArtistViewController.swift
//  project-wave-iOS
//
//  Created by yejin on 07/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
  
  @IBOutlet weak var artistTableVIew: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()

    
  }
  
  func setup(){
    artistTableView.delegate = self
    artistTableView.dataSource = self
  }
  
}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource{
  
  
}

