//
//  CustomSplashInteractor.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright (c) 2018 West Coast IT. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit

protocol CustomSplashInteractorInput: class {
  var output: CustomSplashInteractorOutput? { get set }
  func requestData(request: CustomSplash.DataContext.Request)
}

protocol CustomSplashInteractorOutput: class {
  func didReceive(response: CustomSplash.DataContext.Response)
  func didFail(with error: Error)
}

class CustomSplashInteractor: CustomSplashInteractorInput {
  let service: CustomSplashServiceProtocol = CustomSplashService()
  weak var output: CustomSplashInteractorOutput?
  
  // MARK: - Input
  func requestData(request: CustomSplash.DataContext.Request) {
    // Let's say we execute some async operation, then we want to be able to inform our output when the operation is finshed
    // self.service.requestSomeDataAsync(requestParams: params, 
    //                                          succes: {
    //                                            receivedData in
    //                                              self.output?.didReceive(some: receivedData)
    //                                          }),
    //                                          failure: {
    //                                            error in 
    //                                              NSLog("An error has occured while retrieving some data: \(error)")
    //                                              self.output?.didFail(error: error)
    //                                          })
    self.service.doSomeWork()
  }
}