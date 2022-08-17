//
//  HomeViewModel.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import Foundation
import Combine

final class HomeViewModel {
  private var subscriptions = Set<AnyCancellable>()
  
  @Published var user: User?
  @Published var errorMessage: String?
  
  func fetchUser() {
    UserDataManager.getRandomUser()
      .sink { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          switch error {
          case .http(let error):
            self.errorMessage = error.message
          case .unknown:
            self.errorMessage = "Unknown error"
          }
        }
      } receiveValue: { response in
        guard let user = response.results.first else { return }
        self.user = user
      }
      .store(in: &subscriptions)
  }
}
