//
//  SceneDelegate.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  private var appCoordinator: AppCoordinator!
  private let disposeBag = DisposeBag()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    self.window = window

    appCoordinator = AppCoordinator(window: window)
    
    appCoordinator.start()
      .subscribe()
      .disposed(by: disposeBag)
  }
}
