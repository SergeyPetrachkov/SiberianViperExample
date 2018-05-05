//
//  FeedAssembly.swift
//  SiberianViperExample
//
//  Created by Sergey Petrachkov on 05/05/2018.
//  Copyright (c) 2018 West Coast IT. All rights reserved.
//
//  This file was generated by the SergeyPetrachkov VIPER Xcode Templates so
//  you can apply VIPER architecture to your iOS projects
//

import UIKit

class FeedAssembly {
  // MARK: - Constants
  fileprivate static let storyboardId = "Module"
  fileprivate static let controllerStoryboardId = "Feed"
  // MARK: - Public methods
  static func createModule(moduleIn: Feed.DataContext.ModuleIn) -> FeedViewController {
    let controller = FeedViewController()
    var presenter = injectPresenter(moduleIn: moduleIn)
    presenter.output = controller
    presenter.view = controller
    controller.presenter = presenter
    return controller
  }
  // MARK: - Private injections
  fileprivate static func injectPresenter(moduleIn: Feed.DataContext.ModuleIn) -> FeedPresenterInput {
    let presenter = FeedPresenter(moduleIn: moduleIn)
    let interactor = injectInteractor()
    interactor.output = presenter
    presenter.interactor = interactor
    let router = injectRouter()
    presenter.router = router
    return presenter
  }
  fileprivate static func injectInteractor() -> FeedInteractorInput {
    let service = injectService()
    return FeedInteractor(service: service)
  }
  fileprivate static func injectService() -> FeedServiceProtocol {
    return FeedService(reporter: nil)
  }
  fileprivate static func injectRouter() -> FeedRoutingLogic {
    return FeedRouter()
  }
}
