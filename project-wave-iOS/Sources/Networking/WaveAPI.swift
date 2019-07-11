//
//  TargetType.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 12/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import Alamofire
import Moya

public enum WaveAPI {
  case search(keyword: String)
  case song(index: String)
  case myPage
  case user(index: String)
  case emailCheck(email: String)
  case homeInfo
  case originArtist
  
  case top10
  case recommend
  case hits(status: String)
  case rateReady
  case uploadList(status: String)
}

extension WaveAPI: TargetType {
  public var baseURL: URL {
    let base = "https://wave-studio.ml:8080"
    switch self {
      case .search,
           .song,
           .myPage,
           .user,
           .emailCheck,
           .homeInfo,
           .originArtist:
        guard let url = URL(string: base + "/core") else {
          fatalError("baseURL could not be configured")
        }
      return url
    default:
      guard let url = URL(string: base + "/pl") else {
        fatalError("baseURL could not be configured")
      }
      return url
    }
  }
  
  public var path: String {
    switch self {
    case .search: return "/search"
    case .song(let song): return "/song/\(song)"
    case .myPage: return "/users"
    case .user(let index): return "/users/\(index)"
    case .emailCheck: return "/users/emailCheck"
    case .homeInfo: return "/userInfo"
    case .originArtist: return "/originArtist"
      
    case .top10: return "/top10"
    case .recommend: return "/recommend"
    case .hits: return "/hits"
    case .rateReady: return "/rateReady"
    case .uploadList: return "/upload"
    }
  }
  
  var parameters: [String: Any]? {
    var params: [String: Any] = [:]
    switch self {
    case .search(let keyword):
      params["originArtistName"] = keyword
      params["artistName"] = keyword
      params["originTitle"] = keyword
    case .hits(let status):
      params["status"] = status
    case .uploadList(let status):
      params["status"] = status
    default: break
    }
    return params
  }
  
  public var parameterEncoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  public var method: Moya.Method {
    switch self {
    case .emailCheck:
      return .post
    default:
      return .get
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var task: Task {
    switch self {
    case .search, .hits, .uploadList:
      if let parameters = parameters {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
      }
      return .requestPlain
    default: return .requestPlain
    }
  }
  
  public var headers: [String : String]? {
    var hd: [String: String] = [:]
    hd["Content-Type"] = "application/json"
    switch self {
    case .song,
         .myPage,
         .homeInfo,
         .top10,
         .recommend,
         .hits,
         .rateReady,
         .uploadList:
      hd["Authorization"] = ""
    default: break
    }
    return hd
  }
  
  
}
