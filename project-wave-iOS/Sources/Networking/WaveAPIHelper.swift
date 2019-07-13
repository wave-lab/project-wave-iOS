//
//  WaveAPIHelper.swift
//  project-wave-iOS
//
//  Created by LeeSeungsoo on 12/07/2019.
//  Copyright © 2019 WAVE-Lab. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import Moya_ObjectMapper
//import ObjectMapper

private class DefaultAlamofireManager: Alamofire.SessionManager {
  static let sharedManager: DefaultAlamofireManager = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 10 * 60
    configuration.timeoutIntervalForResource = 10 * 60
    
    return DefaultAlamofireManager(configuration: configuration)
  }()
}

let WaveApiProvider = MoyaProvider<WaveAPI>(endpointClosure: tourEndpointClosure, manager: DefaultAlamofireManager.sharedManager)

let tourEndpointClosure = { (target: WaveAPI) -> Endpoint in
  let url = target.baseURL.appendingPathComponent(target.path).absoluteString
  var endpoint: Endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
  return endpoint
}

class WaveApiHelper {
  
  static let shared = WaveApiHelper()
  
  func search(keyword: String, completion: @escaping ((Search)?, String?) -> Void) {
    WaveApiProvider.request(.search(keyword: keyword)) { response in
      switch response.result {
      case .success(let value):
        do {
          let decoder = JSONDecoder()
          let responseBody = try decoder.decode(Response<Search>.self, from: value.data)
          guard let success = responseBody.success else { return }
          if success {
            completion(responseBody.data, nil)
          } else {
            completion(nil, "request fail")
          }
        } catch let error {
          completion(nil, error.localizedDescription)
        }
      case .failure(let error):
        completion(nil, error.localizedDescription)
      }
    }
  }
}
