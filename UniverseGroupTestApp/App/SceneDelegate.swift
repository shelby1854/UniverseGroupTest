//
//  SceneDelegate.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  private var appCoordinator: AppCoordinator?
  private let appDIContainer = AppDIContainer()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    
    let appCoordinator = AppCoordinator(window: window, dependenciesContainer: appDIContainer)
    self.appCoordinator = appCoordinator
    appCoordinator.start()
    self.window = window
    window.makeKeyAndVisible()
  }
}
