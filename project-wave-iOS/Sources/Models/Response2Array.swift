//
//  Response2Array.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 13/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct Response2Array<T: Codable>: Codable {
  var status: Int? = nil
  var success: Bool? = nil
  var message: String? = nil
  var data: [[T]]? = nil
}
