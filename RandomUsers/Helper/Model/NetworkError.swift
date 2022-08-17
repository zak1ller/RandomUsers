//
//  NetworkError.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import Foundation
import Alamofire

enum NetworkError: Error {
  case http(BackendError)
  case unknown
}

struct BackendError: Codable, Error {
  var status: String
  var message: String
}
