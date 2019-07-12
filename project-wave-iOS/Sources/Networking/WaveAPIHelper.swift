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
import ObjectMapper

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
  
}
