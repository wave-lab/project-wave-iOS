//
//  MainTabBarController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  

}

extension MainTabBarController {
  func setupTabBar() {
    self.tabBar.layer.borderWidth = 0.0
    self.tabBar.clipsToBounds = true
    
    let image = UIImage()
    self.tabBar.backgroundImage = image
    self.tabBar.backgroundColor = .black
  }
}
