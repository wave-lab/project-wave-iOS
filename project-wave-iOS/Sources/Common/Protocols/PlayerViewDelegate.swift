//
//  PlayerViewDelegate.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import UIKit

public enum Player {
  enum ViewState {
    case maximum
    case minimum
  }
  
  enum State {
    case play
    case pause
  }
}

protocol PlayerViewDelegate {
  func didMinimize()
  func didmaximize()
  func swipeToMinimize(translation: CGFloat, toState: Player.ViewState)
  func didEndedSwipe(toState: Player.ViewState)
}
