//
//  UIView+extension.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func setupGradient(frame: CGRect, colors: [CGColor], locations: [NSNumber]) {
    let gradient = CAGradientLayer()
    gradient.frame = frame
    gradient.locations = locations
    gradient.colors = colors
    self.layer.addSublayer(gradient)
  }
}
