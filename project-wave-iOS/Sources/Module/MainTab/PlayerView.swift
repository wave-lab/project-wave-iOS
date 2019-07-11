//
//  PlayerView.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

protocol PlayerViewActionDelegate {
  func playAndPause()
  func playShuffle()
  func scrollDownToTrackList()
  func showlike()
  func showShareView()
  func showMoreView()
  func minimize()
}

class PlayerView: UIView {

  @IBOutlet weak var songTitleLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  
  @IBOutlet weak var bottomSpacingConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var minimizeButton: UIButton!
  @IBOutlet weak var shuffleButton: UIButton!
  @IBOutlet weak var moreButton: UIButton!
  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var trackListButton: UIButton!
  
  @IBOutlet weak var playAndPauseButton: UIButton!
  
  @IBOutlet weak var seekBar: SeekBar!
  
  @IBOutlet weak var currentTimeLabel: UILabel!
  @IBOutlet weak var durationTimeLabel: UILabel!
  
  var delegate: PlayerViewActionDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupTarget()
    seekBar.value = 0.5
  }
}

extension PlayerView {
  func setupTarget() {
    minimizeButton.addTarget(self, action: #selector(minimizePlayer), for: .touchUpInside)
  }
}

extension PlayerView {
  @objc func playAndPause() {
    self.delegate?.playAndPause()
  }
  
  @objc func minimizePlayer() {
    self.delegate?.minimize()
  }
}
