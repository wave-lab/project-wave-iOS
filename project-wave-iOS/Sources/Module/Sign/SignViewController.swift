//
//  SignViewController.swift
//  project-wave-iOS
//
//  Created by yejin on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import Hero

class SignViewController: ViewController {
  
  @IBOutlet weak var logo: UIImageView!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var mainButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    logo.hero.id = "logo"
  }
  
  override func setupView(){
    super.setupView()
    loginButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
    mainButton.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
  }
  
  override func setupNavigationBar() {
    super.setupNavigationBar()
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
    button.setTitle("로그인", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 14)!
    button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
    let item = UIBarButtonItem(customView: button)
    self.navigationItem.setRightBarButton(item, animated: true)
  }
  
  
}

extension SignViewController {
  @objc func goToLogin() {
    let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    vc.hero.modalAnimationType = .fade
    self.present(vc, animated: true)
  }
  
  @objc func goToMain() {
    let vc = UIStoryboard(name: Wave.storyboard.mainTab, bundle: .main).instantiateViewController(withIdentifier: Wave.viewController.mainTab) as! MainTabBarController
    vc.hero.modalAnimationType = .fade
    self.present(vc, animated: true)
  }
}

