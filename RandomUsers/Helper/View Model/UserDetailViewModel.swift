//
//  UserDetailViewModel.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/18.
//

import Foundation
import Alamofire
import Combine

final class UserDetailViewModel {
  @Published var user: User
  
  init(user: User) {
    self.user = user
  }
}
