//
//  User.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright © 2018 West Coast IT. All rights reserved.
//

import Foundation
struct User: Equatable {
  let id: String
  let firstname: String
  let lastname: String
  let description: String
  
  public static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.id == rhs.id
  }
}

struct Profile: Account {
  let user: User
  
  var username: String {
    return "\(self.user.firstname) \(self.user.lastname)"
  }
  
  var description: String {
    return self.user.description
  }
}
