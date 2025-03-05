//
//  AppCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  override func start() -> Observable<Void> {
    let filmsService = FilmsService()
    let splashCoordinator = SplashCoordinator(
      window: window,
      filmsService: filmsService
    )
    return coordinate(to: splashCoordinator)
      .take(1)
      .flatMap { [weak self] _ -> Observable<Void> in
        guard let self else { return .empty() }
        
        let tabBarCoordinator = TabBarCoordinator(
          window: window,
          filmsService: filmsService
        )
        return coordinate(to: tabBarCoordinator)
      }
  }
}
