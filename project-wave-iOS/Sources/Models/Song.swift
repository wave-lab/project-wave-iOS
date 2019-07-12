//
//  Song.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 10/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct Song: Codable {
  let genre, mood: [String]?
  let id, originTitle: String?
  let userIdx: Int?
  let coverArtistName: String?
  let streamCount, likeCount: Int?
  let artwork: String?
  let originArtistIdx: Int?
  let originArtistName, enrollTime: String?
  let songURL: String?
  let songComment: String?
  let reportCount, rateScore: Int?
  let highlightTime: String?
  let songStatus: Int?
  let uploadDate, deleteTime: String?
  let rateUserCount: Int?
  
  enum CodingKeys: String, CodingKey {
    case genre, mood
    case id
    case originTitle, userIdx, coverArtistName, streamCount, likeCount, artwork, originArtistIdx, originArtistName, enrollTime
    case songURL
    case songComment, reportCount, rateScore, highlightTime, songStatus, uploadDate, deleteTime, rateUserCount
  }
}
