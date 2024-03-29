//
//  Wave.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 05/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import UIKit

struct Wave {
  struct reuseIdentifier {
    static let menuCell = "MenuCell"
    static let headerCell = "HeaderCell"
    static let horizontalSongCell = "HorizontalSongCell"
    static let tableContainer = "TableContainerCell"
    static let collectionContainer = "CollectionContainerCell"
  }
  
  struct nib {
    static let horizontalSongCell = UINib(nibName: "HorizontalSongCell", bundle: .main)
  }
  
  struct storyboard {
    static let splash = "Splash"
    static let intro = "Intro"
    static let sign = "Sign"
    static let mainTab = "MainTab"
    static let home = "Home"
    static let assess = "Assess"
    static let search = "Search"
    static let library = "Library"
    static let myPage = "MyPage"
  }
  
  struct viewController {
    static let splash = "SplashViewController"
    static let intro = "IntroViewController"
    static let first = "FirstViewController"
    static let mainTab = "MainTabBarController"
    static let home = "HomeViewController"
    static let assess = "AssessViewController"
    static let search = "SearchViewController"
    static let library = "LibraryViewController"
    static let myPage = "MyPageViewController"
    
  }
  
  struct color {
    static let brownishGray = UIColor.rgb(red: 97, green: 97, blue: 97)
    static let pointBlue = UIColor.rgb(red: 0, green: 182, blue: 222)
  }
  
  struct image {
    
  }
  
  struct font {
    static let menu = UIFont(name: "NotoSansKR-Bold", size: 22) ?? UIFont.boldSystemFont(ofSize: 22)
  }
  
  struct string {
    static let genres: [String] = ["발라드", "POP", "어쿠스틱", "댄스", "힙합", "R&B/Soul", "락", "기타"]
    static let library: [String] = ["재생목록", "좋아요", "플레이리스트"]
  }
  
  struct device {
    enum model {
      case iPhone5s, iPhoneSE
      case iPhone6, iPhone6Plus
      case iPhone6s, iPhone6sPlus
      case iPhone7, iPhone7Plus
      case iPhone8, iPhone8Plus
      case iPhoneX
      case iPhoneXS, iPhoneXSMax
      case iPhoneXR
      case notXSeries
      case unknown
    }
    
    static func get() -> Wave.device.model {
      let modelName = UIDevice.modelName
      switch modelName {
      case "iPhone 5s":
        return .iPhone5s
      case "iPhone SE":
        return .iPhoneSE
      case "iPhone 6":
        return .iPhone6
      case "iPhone 6s":
        return .iPhone6s
      case "iPhone 7":
        return .iPhone7
      case "iPhone 8":
        return .iPhone8
      case "iPhone 6 Plus":
        return .iPhone6Plus
      case "iPhone 6s Plus":
        return .iPhone6sPlus
      case "iPhone 7 Plus":
        return .iPhone7Plus
      case "iPhone 8 Plus":
        return .iPhone8Plus
      case "iPhone X":
        return .iPhoneX
      case "iPhone XS":
        return .iPhoneXS
      case "iPhone XS Max":
        return .iPhoneXSMax
      case "iPhone XR":
        return .iPhoneXR
      default:
        return .unknown
      }
    }
  }
}
