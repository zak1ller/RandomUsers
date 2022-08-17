//
//  UserDataManager.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import Foundation
import Alamofire
import Combine

enum UserDataManager {
  static let agent = Agent()
  static let base = "https://randomuser.me/api/"
  
  static func getRandomUser() -> AnyPublisher<UserResponse, NetworkError> {
    let request = AF.request(base)
    return agent.run(request)
      .map(\.value)
      .eraseToAnyPublisher()
  }
  
  static func getRandomUsers(count: Int) -> AnyPublisher<UserResponse, NetworkError> {
    var urlComponents = URLComponents(string: base)!
    urlComponents.queryItems = [
      URLQueryItem(name: "results", value: "\(count)")
    ]
    
    let request = AF.request(urlComponents.url!)
    return agent.run(request)
      .map(\.value)
      .eraseToAnyPublisher()
  }
}
