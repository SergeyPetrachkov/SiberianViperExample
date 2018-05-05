//
//  FeedMapper.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright (c) 2018 West Coast IT. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit
import SiberianVIPER
protocol FeedMapperProtocol: CollectionModuleMapper {
  
}
class FeedMapper: FeedMapperProtocol {
  
  typealias EntityType = Any
  
  typealias ViewModelType = FeedModel

  func map(items: [Any]) -> [FeedModel] {
    return items.map( { FeedModel(currentModel: $0) } )
  }

  // func map(request: Feed.DataContext.Request) -> Feed.DataContext.Response {
  //   return Feed.DataContext.Response(originalRequest: (originalRequest: request))
  // }
}
