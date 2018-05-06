//
//  ProfileService.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 06/05/2018.
//  Copyright © 2018 West Coast IT. All rights reserved.
//

import Foundation
protocol ProfileServiceProtocol: class {
  func fetchProfile(success: @escaping ((User) -> ()), failure: @escaping ((Error) -> ()))
}

class LocalProfileStore: ProfileServiceProtocol {
  func fetchProfile(success: @escaping ((User) -> ()), failure: @escaping ((Error) -> ())) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
      success(User(id: "1",
                   firstname: "Sergey",
                   lastname: "Petrachkov",
                   description: "VIPER fan"))
    })
  }
}
// Later fetch profile from some web service
class RemoteProfileStore: ProfileServiceProtocol {
  func fetchProfile(success: @escaping ((User) -> ()), failure: @escaping ((Error) -> ())) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
      success(User(id: "1",
                   firstname: "Sergey",
                   lastname: "Petrachkov",
                   description: "VIPER fan"))
    })
  }
}
