//
//  Defaults.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 13/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation

struct Defaults {
  
  static let searchHistoryKey = "com.search.history"
  static let userTokenKey = "com.save.usertoken"
  
  static func save(_ token: String) {
    UserDefaults.standard.set(token, forKey: userTokenKey)
  }
  
  static func save(_ history: [String]) {
    UserDefaults.standard.set(history, forKey: searchHistoryKey)
  }
  
  
  
  
  static func clearUserData(){
    UserDefaults.standard.removeObject(forKey: userTokenKey)
  }
}
