//
//  HorizontalSongCell.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 07/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import UIKit

class HorizontalSongCell: UITableViewCell {
  
  @IBOutlet weak var songImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  
  
  var delegate: SongDetailDelegate?
  
  var index: Int?
  
  var item: String? {
    didSet {
      setupItems()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func showSongDetail(_ sender: Any) {
    self.delegate?.showSongDetail(index: index ?? 0)
  }
  
}

extension HorizontalSongCell {
  func setupItems() {
    //데이터 셋업 필요
    titleLabel.sizeToFit()
    artistNameLabel.sizeToFit()
    genreLabel.sizeToFit()
  }
}
