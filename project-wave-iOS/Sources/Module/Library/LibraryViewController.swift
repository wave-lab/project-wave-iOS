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
  
  
  lazy var menuBar: MenuBar = {
    let mb = MenuBar()
    mb.items = Wave.string.library
    return mb
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupMenuBar()
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
  }
}
