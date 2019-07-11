//
//  SeekBar.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit


public protocol SeekbarDelegate: NSObjectProtocol {
  func beginTracking(value: Float)
  func continueTracking(value: Float)
  func endTracking(value: Float)
}

class SeekBar: UISlider {
  fileprivate let sideMargin: CGFloat = 0
  fileprivate let thumbHalfWidth: CGFloat = 0
  fileprivate var usableTrackWidth: CGFloat = 0.0
  
  weak open var delegate: SeekbarDelegate?
  
  func setSeekbarDelegate(_ delegate: SeekbarDelegate) {
    self.delegate = delegate
  }
  
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    delegate?.beginTracking(value: value)
    return super.beginTracking(touch, with: event)
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    delegate?.continueTracking(value: value)
    return super.continueTracking(touch, with: event)
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    delegate?.endTracking(value: value)
  }
  
  override func trackRect(forBounds bounds: CGRect) -> CGRect {
    var newBounds = super.trackRect(forBounds: bounds)
    newBounds.origin.x = newBounds.origin.x + sideMargin
    newBounds.size.width = newBounds.size.width - 2 * sideMargin
    newBounds.size.height = 2
    
    return newBounds
  }
  
  override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
    guard let image = self.currentThumbImage else {
      return CGRect()
    }
    
    let insets = image.alignmentRectInsets
    let fullWidth = image.size.width
    let fullHeight = image.size.height
    let coreWidth = fullWidth - insets.left - insets.right
    let coreHeight = fullHeight - insets.top - insets.bottom
    
    usableTrackWidth = rect.size.width - coreWidth + (2 * thumbHalfWidth)
    let offset = getOffsetX(value)
    
    let x = (rect.origin.x + offset) - (insets.left + thumbHalfWidth)
    let y = rect.origin.y + 0.5 * rect.size.height - 0.5 * coreHeight - insets.top
    
    return CGRect(x: x,
                  y: y,
                  width: fullWidth,
                  height: fullHeight)
  }
  
  fileprivate func getOffsetX(_ value: Float) -> CGFloat {
    return usableTrackWidth * CGFloat(value)
  }
}
