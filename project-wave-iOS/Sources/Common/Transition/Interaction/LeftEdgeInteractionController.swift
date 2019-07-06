//
//  LeftEdgeInteractionController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 05/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

open class LeftEdgeInteractionController: UIPercentDrivenInteractiveTransition {
  
  open var inProgress = false
  
  private var shouldCompleteTransition = false
  private weak var viewController: UIViewController!
  
  public init(viewController: UIViewController) {
    super.init()
    self.viewController = viewController
    self.setupGestureRecognizer(in: viewController.view)
  }
  
  private func setupGestureRecognizer(in view: UIView) {
    let edge = UIScreenEdgePanGestureRecognizer(target: self,
                                                action: #selector(self.handleEdgePan(_:)))
    edge.edges = .left
    view.addGestureRecognizer(edge)
  }
  
  @objc func handleEdgePan(_ gesture: UIScreenEdgePanGestureRecognizer) {
    let translate = gesture.translation(in: gesture.view)
    let percent = translate.x / gesture.view!.bounds.size.width
    
    switch gesture.state {
    case .began:
      self.inProgress = true
      if let navigationController = viewController.navigationController {
        navigationController.popViewController(animated: true)
        return
      }
      viewController.dismiss(animated: true, completion: nil)
    case .changed:
      self.update(percent)
    case .cancelled:
      self.inProgress = false
      self.cancel()
    case .ended:
      self.inProgress = false
      let velocity = gesture.velocity(in: gesture.view)
      if percent > 0.5 || velocity.x > 0 {
        self.finish()
      } else {
        self.cancel()
      }
    default:
      break
    }
  }
}
