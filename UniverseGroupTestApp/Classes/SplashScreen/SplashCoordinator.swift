//
//  SplashCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 04.03.2025.
//

import UIKit
import RxSwift

final class SplashCoordinator: BaseCoordinator<Void> {
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }

  override func start() -> Observable<Void> {
    let viewModel = SplashViewModel()
    let viewController = SplashViewController(viewModel: viewModel)
    let navController = UINavigationController(rootViewController: viewController)
    
    window.rootViewController = navController
    window.makeKeyAndVisible()
    
    viewModel.startLoading()
    
    return viewModel.output.loadingFinished
      .asObservable()
      .take(1)
      .flatMap { [weak self] _ -> Observable<Void> in
        guard let self else { return .empty() }
        let tabBarCoordinator = TabBarCoordinator(window: window)
        return coordinate(to: tabBarCoordinator)
      }
  }
}
