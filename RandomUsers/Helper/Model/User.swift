//
//  User.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import Foundation

struct User: Codable {
  let gender: String
  let name: Username
  let location: Locaton
  let email: String
  let picture: Picture
}

struct Username: Codable {
  let title: String
  let first: String
  let last: String
}

struct Locaton: Codable {
  let city: String
}

struct Picture: Codable {
  let large: String
  let medium: String
  let thumbnail: String
}
