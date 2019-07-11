//
//  PlayerContainerView.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 11/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class PlayerContainerView: UIView {
  
  public enum Direction {
    case up
    case down
    case none
  }

  @IBOutlet weak var playerTopControlBar: UIView!
  @IBOutlet weak var playAndPauseButton: UIButton!
  @IBOutlet weak var showTrackListButton: UIButton!
  
  @IBOutlet weak var songTitleLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  
  @IBOutlet weak var playerTableView: UITableView!
  
  var delegate: PlayerViewDelegate?
  
  var trackList: [String] = ["",""]
  var scrollLock: Bool = false
  var direction: Direction = .none
  var state: Player.ViewState = .minimum {
    didSet {
      self.playerTableView.isScrollEnabled = state == .maximum ? true : false
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
    setupGesture()
  }
}

extension PlayerContainerView {
  func setupView(){
    playerTableView.delegate = self
    playerTableView.dataSource = self
    playerTableView.register(Wave.nib.horizontalSongCell, forCellReuseIdentifier: Wave.reuseIdentifier.horizontalSongCell)
    playerTopControlBar.isHidden = false
    playerTableView.isHidden = true
  }
  
  func setupGesture() {
    let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    pan.delegate = self
    self.addGestureRecognizer(pan)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    tap.delegate = self
    self.addGestureRecognizer(tap)
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
        self.playerTopControlBar.isHidden = true
        self.playerTableView.isHidden = false
        self.layoutIfNeeded()
      })
    case .minimum:
      UIView.animate(withDuration: 0.3, animations: {
        self.playerTopControlBar.isHidden = false
        self.playerTableView.isHidden = true
        self.layoutIfNeeded()
      })
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
    return 768
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
  
  func showlike() {
    
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

