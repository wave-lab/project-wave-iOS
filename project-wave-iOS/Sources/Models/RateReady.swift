//
//  RateReady.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 13/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct RateReady: Codable {
  let songs: [Song]?
  let id, playlistName, playlistComment: String?
  let userIdx: Int?
  
  enum CodingKeys: String, CodingKey {
    case songs = "songList"
    case id
    case playlistName, playlistComment, userIdx
  }
}
