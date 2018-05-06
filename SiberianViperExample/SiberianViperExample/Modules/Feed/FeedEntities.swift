//
//  FeedEntities.swift
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

enum Feed {
  // MARK: - Use cases
  enum DataContext {
  	struct ModuleIn {
  	}
  	struct ModuleOut {
  	}
    struct Request: PaginationRequest {
      var paginationParams: PaginationParameters
      init(skip: Int, take: Int) {
        self.paginationParams = PaginationParameters(skip: skip, take: take)
      }
    }
    struct Response: ModuleResponse  {
      var originalRequest: Request
      
      let items: [CollectionModel]
    }
    struct ProfileResponse {
      let profile: Profile
    }
    class ViewModel: CollectionViewModel {
      
      public var headerModel: CollectionModel?
      
      var batchSize: Int = 20
      
      var items: [CollectionModel] = []
      
      var changeSet: [CollectionChange] = []
      
      var isBusy: Bool = false
      
      init(moduleIn: ModuleIn) {
        
      }
    }
  }
}
