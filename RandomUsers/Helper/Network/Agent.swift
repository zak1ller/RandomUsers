//
//  Agent.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import Foundation
import Alamofire
import Combine

struct Agent {
  struct Response<T> {
    let value: T
    let response: URLResponse
  }
  
  func run<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, NetworkError> {
    return request
      .validate()
      .publishData(emptyResponseCodes: [200, 204, 205])
      .tryMap { result -> Response<T> in
        if let error = result.error {
          if let errorData = result.data {
            let value = try decoder.decode(BackendError.self, from: errorData)
            throw NetworkError.http(value)
          } else {
            throw error
          }
        }
        
        if let data = result.data {
          let value = try decoder.decode(T.self, from: data)
          return Response(value: value, response: result.response!)
        } else {
          return Response(value: Empty.emptyValue() as! T, response: result.response!)
        }
      }
      .mapError { error -> NetworkError in
        if let networkError = error as? NetworkError {
          return networkError
        } else {
          return .unknown
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
