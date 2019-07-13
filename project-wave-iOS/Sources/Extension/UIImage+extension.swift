//
//  UIImage+extension.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 13/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  static func gradientImage(with bounds: CGRect,
                            colors: [CGColor],
                            locations: [NSNumber]?) -> UIImage? {
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = colors
    // This makes it horizontal
    gradientLayer.startPoint = CGPoint(x: 0.0,
                                       y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0,
                                     y: 0.5)
    
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    UIGraphicsEndImageContext()
    return image
  }
}
