//
//  Response.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 01/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
  var status: Int? = nil
  var success: Bool? = nil
  var message: String? = nil
  var data: T? = nil
}
