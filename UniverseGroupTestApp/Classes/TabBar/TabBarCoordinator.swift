//
//  TabBarCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 04.03.2025.
//

import UIKit
import RxSwift

final class TabBarCoordinator: BaseCoordinator<Void> {
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  override func start() -> Observable<Void> {
    let tabBarController = TabBarController()
    
    let filmsVC = UIViewController()
    filmsVC.tabBarItem = UITabBarItem(
      title: "Films",
      image: AppImage.MainTabBar.filmsLogo,
      tag: 0
    )
    
    let settingsVC = UIViewController()
    settingsVC.tabBarItem = UITabBarItem(
      title: "Favorites",
      image: AppImage.MainTabBar.favsLogo,
      tag: 1
    )
    
    tabBarController.viewControllers = [filmsVC, settingsVC]
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    return .never()
  }
}
