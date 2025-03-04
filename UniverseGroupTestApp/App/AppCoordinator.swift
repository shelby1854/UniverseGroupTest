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
    let splashCoordinator = SplashCoordinator(window: window)
    return coordinate(to: splashCoordinator)
  }
}
