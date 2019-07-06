//
//  ViewController.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 05/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var _presentType: TransitionType = .navigation
  
  var presentType: TransitionType {
    get { return _presentType }
    set { _presentType = newValue }
  }
  
  var interactionController: LeftEdgeInteractionController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupNavigationBar()
  }
  
  func setupView() {
    self.interactionController = LeftEdgeInteractionController(viewController: self)
    self.navigationController?.delegate = self
  }
  
  func setupNavigationBar(){
    guard let bar =  self.navigationController?.navigationBar else { return }
    bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    bar.shadowImage = UIImage()
    bar.backgroundColor = UIColor.clear
    let yourBackImage = UIImage(named: "btnBack")
    bar.backIndicatorImage = yourBackImage
    bar.backIndicatorTransitionMaskImage = yourBackImage
    let backItem = UIBarButtonItem()
    backItem.title = ""
    navigationItem.backBarButtonItem = backItem
  }
  
}

extension ViewController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationController.Operation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    switch operation {
    case .push:
      return PushAnimator(type: .navigation)
    case .pop:
      return PopAnimator(type: .navigation,
                         interactionController: self.interactionController)
    default:
      return nil
    }
  }
  
  func navigationController(_ navigationController: UINavigationController,
                            interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      
      guard
        let animator = animationController as? PopAnimator,
        let interactionController = animator.interactionController as? LeftEdgeInteractionController,
        interactionController.inProgress
        else {
          return nil
      }
      return interactionController
  }
}

