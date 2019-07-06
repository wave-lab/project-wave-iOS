//
//  PushAnimator.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 05/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

open class PushAnimator: CustomAnimator {
  
  open override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to)
      else {
        return
    }
    let containerView = transitionContext.containerView
    let bounds =
      type == .navigation ?
        containerView.bounds.offsetBy(dx: containerView.frame.size.width, dy: 0.0) :
        containerView.bounds.offsetBy(dx: 0.0, dy: containerView.frame.size.height)
    toViewController.view.frame = bounds
    containerView.addSubview(toViewController.view)
    
    let animations = {
      let bounds =
        self.type == .navigation ?
          containerView.bounds.offsetBy(dx: -containerView.frame.size.width / 3, dy: 0) :
          containerView.bounds.offsetBy(dx: 0, dy: 0)
      toViewController.view.frame = containerView.bounds
      fromViewController.view.frame = bounds
    }
    
    UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                   delay: 0,
                   options: [.curveEaseOut],
                   animations: animations) { _ in
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
}
