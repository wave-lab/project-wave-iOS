//
//  SignViewController.swift
//  project-wave-iOS
//
//  Created by yejin on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class SignViewController: ViewController {
  
  @IBAction func loginBtn(_ sender: Any) {
  }
  
  @IBAction func emailLoginBtn(_ sender: Any) {
  }
  
  @IBAction func kakaoLoginBtn(_ sender: Any) {
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func setup(){
    setNeedsStatusBarAppearanceUpdate()
  }
  
  
}

