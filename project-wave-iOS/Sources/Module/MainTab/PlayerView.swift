//
//  PlayerView.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import Lottie

protocol PlayerViewActionDelegate {
  func playAndPause()
  func playShuffle()
  func scrollDownToTrackList()
  func likeEffect()
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
  
  @IBOutlet weak var effectContainer: UIView!
  
  @IBOutlet weak var collecitonView: UICollectionView!
  
  var delegate: PlayerViewActionDelegate?
  
  var animationView: AnimationView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupTarget()
    setupLottie()
    setupSeekBar()
  }
}

extension PlayerView {
  func setupTarget() {
    minimizeButton.addTarget(self, action: #selector(minimizePlayer), for: .touchUpInside)
    likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
  }
  
  func setupLottie() {
    animationView = AnimationView(name: "wave_heart")
    animationView.frame = effectContainer.bounds
    animationView.contentMode = .scaleAspectFill
    animationView.animationSpeed = 2
    self.effectContainer.addSubview(animationView)
  }
  
  func setupSeekBar() {
    seekBar.minimumValue = 0
    seekBar.maximumValue = 1
    seekBar.value = 0
    seekBar.isContinuous = true
    seekBar.setThumbImage(UIImage(imageLiteralResourceName: "slider-thumb"), for: .normal)
    
  }
}

extension PlayerView {
  @objc func playAndPause() {
    self.delegate?.playAndPause()
  }
  
  @objc func minimizePlayer() {
    self.delegate?.minimize()
  }
  
  @objc func like() {
    likeButton.setImage(nil, for: .normal)
    self.delegate?.likeEffect()
    if animationView.isAnimationPlaying {
      animationView.stop()
      animationView.play()
    } else {
      animationView.play()
    }
  }
}

//extension PlayerView: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    
//  }
//  
//  
//}
