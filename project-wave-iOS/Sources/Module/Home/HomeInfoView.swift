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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }

}

extension HomeInfoView {
  func setupView() {
    noMemberView.isHidden = true
    scrollDownButton.addTarget(self, action: #selector(scrollToFeed), for: .touchUpInside)
    firstGradientLayer.setupGradient(
      colors: [
        UIColor.rgb(red: 0, green: 182, blue: 222).cgColor,
        UIColor.rgb(red: 240, green: 0, blue: 81).cgColor,
        UIColor.rgb(red: 0, green: 0, blue: 0).cgColor],
      locations: [0, 0.67, 1.0])
    secondGradientLayer.setupGradient(
      colors: [
        UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
        UIColor.rgba(red: 27, green: 27, blue: 27, alpha: 0.6).cgColor,
        UIColor.rgb(red: 0, green: 0, blue: 0).cgColor],
      locations: [0, 0.33, 1.0])
  }
  
  @objc func scrollToFeed() {
    self.delegate?.scrollToFeed()
  }
}



