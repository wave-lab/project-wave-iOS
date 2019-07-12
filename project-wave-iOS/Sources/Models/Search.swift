//
//  Search.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 12/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct Search: Codable {
  let originArtistName: [OriginArtist]?
  let originTitle: [Song]?
  let artistName: [Artist]?
}
