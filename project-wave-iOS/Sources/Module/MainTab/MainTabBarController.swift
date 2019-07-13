//
//  MainTabBarController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  @IBOutlet var playerContainerView: PlayerContainerView!
  
  var state: Player.ViewState = .maximum {
    didSet {
      let _ = state == .maximum ? minimizePlayer() : maximizePlayer()
    }
  }
  
  
  private let maximumSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  private let maximumOrigin: CGPoint = .init(x: 0, y: 0)
  private let minimumSize = CGSize(width: UIScreen.main.bounds.width, height: 64)
  private var minimumOrigin: CGPoint!
  private let tabBarHeight: CGFloat = 49
  private let homeIndicatorHeight: CGFloat = {
    let device = Wave.device.get()
    switch device {
    case .notXSeries:
      return 0
    default:
      return 34
    }
  }()
  
  private var playerItemContext = 0
  
  
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNeedsStatusBarAppearanceUpdate()
    setupView()
    setupTabBar()
    setupPlayerContainerView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let window = UIApplication.shared.keyWindow {
      window.addSubview(self.playerContainerView)
    }
  }
}

extension MainTabBarController {
  func setupView() {
    playerContainerView.delegate = self
    self.hero.isEnabled = true
    self.hero.tabBarAnimationType = .fade
  }
  
  func setupTabBar() {
    self.tabBar.barStyle = .black
    self.tabBar.layer.borderWidth = 0.0
    self.tabBar.clipsToBounds = true
    self.tabBar.tintColor = Wave.color.pointBlue
    self.tabBar.unselectedItemTintColor = Wave.color.brownishGray
    let image = UIImage()
    self.tabBar.backgroundImage = image
    self.tabBar.backgroundColor = .black
    guard let font = UIFont.init(name: "NotoSansKR-Regular", size: 9) else { return }
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)
    
  }
  
  func setupPlayerContainerView() {
    var minimumOriginY = UIScreen.main.bounds.height
    let model = Wave.device.get()
    switch model {
    case .iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR:
      minimumOriginY -= tabBarHeight + homeIndicatorHeight + 64
    default:
      minimumOriginY -= tabBarHeight + 64
    }
    self.minimumOrigin = CGPoint(x: 0, y: minimumOriginY)
    self.playerContainerView.frame = CGRect(origin: minimumOrigin, size: minimumSize)
    self.playerContainerView.layer.masksToBounds = true
  }
  
}

extension MainTabBarController: PlayerViewDelegate {
  
  // 플레이어 뷰의 오리진을 변경
  func animatePlayerView(state: Player.ViewState) {
    switch state {
    case .maximum:
      UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.beginFromCurrentState], animations: {
        let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.playerContainerView.frame = CGRect(origin: self.maximumOrigin, size: size)
        self.view.layoutIfNeeded()
      })
    case .minimum:
      UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.beginFromCurrentState], animations: {
        let size = CGSize(width: UIScreen.main.bounds.width, height: 64)
        self.playerContainerView.frame = CGRect(origin: self.minimumOrigin, size: size)
        self.view.layoutIfNeeded()
      })
    }
  }
  
  func didMinimize() {
    print("minimize")
    animatePlayerView(state: .minimum)
  }
  
  func didmaximize() {
    print("maximize")
    animatePlayerView(state: .maximum)
  }
  
  func swipeToMinimize(translation: CGFloat, toState: Player.ViewState) {
    
  }
  
  func didEndedSwipe(toState: Player.ViewState) {
    
  }
  
  func minimizePlayer() {
    
  }
  
  func maximizePlayer() {
    
  }
}

extension PlayerView {
  
}
