//
//  PopAnimator.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 05/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

open class PopAnimator: CustomAnimator {
  
  let interactionController: UIPercentDrivenInteractiveTransition?
  
  public init(type: TransitionType,
              duration: TimeInterval = 0.25,
              interactionController: UIPercentDrivenInteractiveTransition? = nil) {
    self.interactionController = interactionController
    
    super.init(type: type, duration: duration)
  }
  
  open override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to)
      else {
        return
    }
    
    let containerView = transitionContext.containerView
    toViewController.view.frame = containerView.bounds.offsetBy(dx: -containerView.frame.size.width / 3, dy: 0)
    
    
    if self.type == .navigation {
      containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
    }
    
    let animations = {
      let bounds =
        self.type == .navigation ?
          containerView.bounds.offsetBy(dx: containerView.frame.size.width, dy: 0) :
          containerView.bounds.offsetBy(dx: 0, dy: containerView.frame.size.height)
      fromViewController.view.frame = bounds
      toViewController.view.frame = containerView.bounds
    }
    
    UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                   delay: 0,
                   options: [.curveEaseOut],
                   animations: animations) { _ in
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
}
