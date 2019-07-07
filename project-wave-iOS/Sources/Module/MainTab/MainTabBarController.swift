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
    setupTabBar()
  }
  

}

extension MainTabBarController {
  func setupTabBar() {
    self.tabBar.layer.borderWidth = 0.0
    self.tabBar.clipsToBounds = true
    self.tabBar.tintColor = Wave.color.pointBlue
    self.tabBar.unselectedItemTintColor = Wave.color.brownishGray
    let image = UIImage()
    self.tabBar.backgroundImage = image
    self.tabBar.backgroundColor = .black
    guard let font = UIFont.init(name: "NotoSansKR-Regular", size: 9) else { return }
    print("hear")
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
    
  }
}
