//
//  AppCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit
import RxSwift

final class AppCoordinator {
  private let window: UIWindow
  private let dependenciesContainer: AppDIContainer
  private let disposeBag = DisposeBag()
  
  init(window: UIWindow, dependenciesContainer: AppDIContainer) {
    self.window = window
    self.dependenciesContainer = dependenciesContainer
  }
  
  func start() {
    showSplashScreen()
  }
  
  private func showSplashScreen() {
    let splashScene = dependenciesContainer.makeSplashScene()
    
    splashScene.viewModel.finishLoading
      .drive(onNext: { [weak self] in
        self?.showMainFlow()
      })
      .disposed(by: disposeBag)
    
    window.rootViewController = splashScene.view
  }
  
  private func showMainFlow() {
    let mainCoordinator = MainCoordinator(
      window: window,
      dependenciesContainer: dependenciesContainer
    )
    mainCoordinator.start()
  }
}
