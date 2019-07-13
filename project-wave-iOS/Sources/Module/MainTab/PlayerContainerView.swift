//
//  PlayerContainerView.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlayerContainerView: UIView {
  
  public enum Direction {
    case up
    case down
    case none
  }
  
  var direction: Direction = .none
  var state: Player.ViewState = .minimum {
    didSet {
      self.playerTableView.isScrollEnabled = state == .maximum ? true : false
    }
  }
  
  var delegate: PlayerViewDelegate?
  
  @IBOutlet weak var backEffectView: UIView!
  @IBOutlet weak var playerTopControlBar: UIView!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var playAndPauseButton: UIButton!
  @IBOutlet weak var showTrackListButton: UIButton!
  
  @IBOutlet weak var songTitleLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  
  @IBOutlet weak var playerTableView: UITableView!
  
  var asset: AVAsset!
  var player: AVPlayer!
  var playerItem: AVPlayerItem!
  
  var trackList: [Song] = []
  var currentTrack: Int = 0
  var isPlaying: Bool = false
  
  var scrollLock: Bool = false
  
  var heightOfDevice: CGFloat = 768 {
    didSet {
      playerTableView.reloadData()
    }
  }
  
  let requiredAssetKeys = [
    "playable",
    "hasProtectedContent"
  ]
  
  var effectAsset: AVAsset!
  var effectPlayer: AVPlayer!
  var effectPlayerItem: AVPlayerItem!
  var effectPlayLayer: AVPlayerLayer!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
    setupGesture()
    setupDevice()
    prepareToEffect()
  }
}

extension PlayerContainerView {
  func setupView(){
    playerTableView.delegate = self
    playerTableView.dataSource = self
    playerTableView.register(Wave.nib.horizontalSongCell, forCellReuseIdentifier: Wave.reuseIdentifier.horizontalSongCell)
    playerTopControlBar.isHidden = false
    playerTableView.isHidden = true
    
    let gradientImage = UIImage.gradientImage(with: progressView.frame,
                                              colors: [UIColor.init(hexString: "#A80039").cgColor, UIColor.init(hexString: "#007F9B").cgColor],
                                              locations: nil)?.withHorizontallyFlippedOrientation()
    progressView.trackImage = gradientImage!
    progressView.transform = CGAffineTransform(scaleX: -1, y: -1)
  }
  
  func setupGesture() {
    let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    pan.delegate = self
    self.addGestureRecognizer(pan)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    tap.delegate = self
    self.addGestureRecognizer(tap)
  }
  
  func setupDevice() {
    let model = Wave.device.get()
    switch model {
    case .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
      heightOfDevice = 647
    case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
      heightOfDevice = 716
    case .iPhoneX, .iPhoneXS:
      heightOfDevice = 768
    case .iPhoneXSMax, .iPhoneXR:
      heightOfDevice = 852
    default:
      heightOfDevice = 548
    }
  }
  
  
  
  func prepareToEffect() {
    guard let path = Bundle.main.path(forResource: "backgroundEffect", ofType: "mp4") else { return }
    effectAsset = AVAsset(url: URL(fileURLWithPath: path))
    effectPlayerItem = AVPlayerItem(asset: effectAsset, automaticallyLoadedAssetKeys: requiredAssetKeys)
    effectPlayer = AVPlayer(playerItem: effectPlayerItem)
    effectPlayLayer = AVPlayerLayer(player: self.effectPlayer)
    effectPlayLayer.frame = UIScreen.main.bounds
    effectPlayLayer.videoGravity = .resizeAspectFill
    self.backEffectView.layer.insertSublayer(effectPlayLayer, at: 0)
    self.backEffectView.contentMode = .scaleToFill
  }
  
  @objc func handlePan(_ sender: UIPanGestureRecognizer) {
    let velocity = sender.velocity(in: nil)
    let translation = sender.translation(in: nil)
    
    if sender.state == .began {
      if velocity.y < 0 {
        self.direction = .up
      } else if velocity.y > 0 && self.playerTableView.contentOffset.y <= 0 {
        self.direction = .down
      }
    }
    
    if direction == .down {
      
    }

    let factor = (abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height)
    
  }
  
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
    maximize()
  }
  
  func animate() {
    switch self.state {
    case .maximum:
      UIView.animate(withDuration: 0.3, animations: {
        self.playerTopControlBar.alpha = 0
        self.playerTableView.alpha = 1
        self.layoutIfNeeded()
      }) { _ in
        self.playerTopControlBar.isHidden = true
        self.playerTableView.isHidden = false
      }
    case .minimum:
      UIView.animate(withDuration: 0.3, animations: {
        self.playerTopControlBar.alpha = 1
        self.playerTableView.alpha = 0
        self.layoutIfNeeded()
      }) { _ in
        self.playerTopControlBar.isHidden = false
        self.playerTableView.isHidden = true
      }
    }
  }
}

extension PlayerContainerView {
  func setupAudio(){
    let url = URL(fileURLWithPath: trackList[currentTrack].songURL ?? "")
    asset = AVAsset(url: url)
    playerItem = AVPlayerItem(asset: asset,
                              automaticallyLoadedAssetKeys: requiredAssetKeys)
    player = AVPlayer(playerItem: playerItem)
    NotificationCenter.default.addObserver(self, selector: #selector(endCurrentItem), name:
      NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
  }
  
  @objc func play() {
    isPlaying.toggle()
  }
  
  @objc func endCurrentItem() {
    nextTrack()
  }
  
  @objc func previousTrack() {
    if currentTrack - 1 < 0 {
      currentTrack = (trackList.count - 1) < 0 ? 0 : (trackList.count - 1)
    } else {
      currentTrack -= 1
    }
    playTrack()
  }
  
  @objc func nextTrack() {
    if currentTrack + 1 > trackList.count {
      currentTrack = 0
    } else {
      currentTrack += 1;
    }
    playTrack()
  }
  
  func playTrack() {
    if trackList.count > 0 {
      let url = URL(fileURLWithPath: trackList[currentTrack].songURL ?? "")
      let currentItem = AVPlayerItem(url: url)
      player.replaceCurrentItem(with: currentItem)
      player.play()
      //setupNowPlaying()
    }
  }
}

extension PlayerContainerView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trackList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = playerTableView.dequeueReusableCell(withIdentifier: Wave.reuseIdentifier.horizontalSongCell) as! HorizontalSongCell
    
    return cell
  }
}

extension PlayerContainerView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 94
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)?.first as! PlayerView
    view.delegate = self
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return heightOfDevice
  }
  
}

// MARK: - Set up scroll control
extension PlayerContainerView {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if scrollLock {
      if scrollView.contentOffset.y < 0 {
        scrollView.contentOffset.y = 0
      }
    }
    
  }
  
  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    scrollLock = false
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scrollLock = true
  }

}

// MARK: - Set up Gesture
extension PlayerContainerView: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    if self.state == .maximum {
      return false
    }
    return true
  }
}


extension PlayerContainerView: PlayerViewActionDelegate {
  func playAndPause() {
    
  }
  
  func playShuffle() {
    
  }
  
  func scrollDownToTrackList() {
    
  }
  
  func likeEffect() {
    effectPlayer.pause()
    effectPlayer.seek(to: CMTime(seconds: 0, preferredTimescale: 60000))
    effectPlayer.play()
  }
  
  func showShareView() {
    
  }
  
  func showMoreView() {
    
  }
  
  @objc func minimize() {
    self.state = .minimum
    self.animate()
    self.delegate?.didMinimize()
  }
  
  // Not PlayerViewActionDelegate
  @objc func maximize() {
    self.state = .maximum
    self.animate()
    self.delegate?.didmaximize()
  }
}

// MARK: - Player
extension PlayerContainerView {
  
}

