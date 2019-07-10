//
//  UIImageView+extension.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  public func download(_ imageUrl: String?, defaultImage: String) {
    let image = UIImage(named: defaultImage)
    if let url = imageUrl{
      if url.isEmpty {
        self.image = image
      } else {
        self.kf.setImage(with: URL(string: url), placeholder: image, options: [.transition(ImageTransition.fade(0.5))])
      }
    } else {
      self.image = image
    }
  }
}
