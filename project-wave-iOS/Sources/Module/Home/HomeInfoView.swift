//
//  HomeInfoView.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

protocol HomeInfoDelegate {
  func scrollToFeed()
}

class HomeInfoView: UIView {

  @IBOutlet weak var firstGradientLayer: UIView!
  @IBOutlet weak var secondGradientLayer: UIView!
  @IBOutlet weak var topContentView: UIView!
  
  @IBOutlet weak var scrollDownButton: UIButton!
  
  @IBOutlet weak var memberView: UIView!
  @IBOutlet weak var noMemberView: UIView!
  
  var delegate: HomeInfoDelegate?
  
  var heightOfHomeInfo: CGFloat = 595
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupDevice()
    setupView()
  }

}

extension HomeInfoView {
  func setupView() {
    self.layoutIfNeeded()
    self.layer.masksToBounds = true
    let scale: CGFloat = 432 / 595
    let firstFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightOfHomeInfo)
    let secondFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightOfHomeInfo * scale)
    noMemberView.isHidden = true
    scrollDownButton.addTarget(self, action: #selector(scrollToFeed), for: .touchUpInside)
    firstGradientLayer.setupGradient(
      frame: firstFrame,
      colors: [
        UIColor.rgb(red: 0, green: 182, blue: 222).cgColor,
        UIColor.rgb(red: 240, green: 0, blue: 81).cgColor,
        UIColor.rgb(red: 0, green: 0, blue: 0).cgColor],
      locations: [0, 0.67, 1.0])
    
    secondGradientLayer.setupGradient(
      frame: secondFrame,
      colors: [
        UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
        UIColor.rgba(red: 27, green: 27, blue: 27, alpha: 0.6).cgColor,
        UIColor.rgb(red: 0, green: 0, blue: 0).cgColor],
      locations: [0, 0.33, 1.0])
  }
  
  func setupDevice() {
    let model = Wave.device.get()
    let scale: CGFloat = 595 / 812
    switch model {
    case .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
      heightOfHomeInfo = 667 * scale
    case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
      heightOfHomeInfo = 736 * scale
    case .iPhoneX, .iPhoneXS:
      heightOfHomeInfo = 812 * scale
    case .iPhoneXSMax, .iPhoneXR:
      heightOfHomeInfo = 896 * scale
    default:
      heightOfHomeInfo = 568 * scale
    }
  }
  
  @objc func scrollToFeed() {
    self.delegate?.scrollToFeed()
  }
}



