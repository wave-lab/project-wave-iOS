//
//  SplashViewController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import Hero

class SplashViewController: UIViewController {
  
  @IBOutlet weak var logo: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    logo.hero.id = "logo"
    setupSplash()
  }
  
  
  func setupSplash() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      let vc = UIStoryboard(name: "Sign", bundle: .main).instantiateViewController(withIdentifier: "SignViewController") as! SignViewController
      vc.hero.modalAnimationType = .zoom
      self.present(vc, animated: true)
    }
  }
}
