//
//  GenreAndMood.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 13/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct GenreAndMood: Codable {
  let id: String?
  let top10Category: String?
  let top10Name: String?
  let checkTime: String?
  let playlistIdx: String?
  let top10Thumbnail: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case top10Category, top10Name, checkTime, playlistIdx, top10Thumbnail
  }
}
