//
//  CustomAnimator.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 05/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

open class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  let type: TransitionType
  let duration: TimeInterval
  
  public init(type: TransitionType, duration: TimeInterval = 0.25) {
    self.type = type
    self.duration = duration
    
    super.init()
  }
  
  open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return self.duration
  }
  
  open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    fatalError("You have to implement this method for yourself!")
  }
}
