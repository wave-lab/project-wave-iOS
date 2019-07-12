//
//  Artist.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 12/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

struct Artist: Codable {
  var userIdx: Int?
  var nickname: String?
  var profileImg: String?
}

struct OriginArtist: Codable {
  let originArtistIdx: Int?
  let originArtistName: String?
  let originArtistImg: String?
}
