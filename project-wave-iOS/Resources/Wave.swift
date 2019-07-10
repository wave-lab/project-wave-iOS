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
  }
  
  struct nib {
    static let headerCell = UINib(nibName: "HeaderCell", bundle: .main)
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
}
