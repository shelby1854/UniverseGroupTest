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
  private let filmsService: FilmsServiceProtocol

  init(window: UIWindow, filmsService: FilmsServiceProtocol) {
    self.window = window
    self.filmsService = filmsService
  }
  
  override func start() -> Observable<Void> {
    let tabBarController = TabBarController()
    
    let filmsNav = UINavigationController()
    filmsNav.tabBarItem = UITabBarItem(
      title: "Films",
      image: AppImage.MainTabBar.filmsLogo,
      tag: 0
    )
    
    let filmsCoordinator = FilmsCoordinator(
      navigationController: filmsNav,
      filmsService: filmsService
    )
    
    coordinate(to: filmsCoordinator)
      .subscribe()
      .disposed(by: disposeBag)
    
    let favoritesNav = UINavigationController()
    favoritesNav.tabBarItem = UITabBarItem(
      title: "Favorites",
      image: AppImage.MainTabBar.favsLogo,
      tag: 1
    )
    
    let favoritesCoordinator = FavoritesCoordinator(
      navigationController: favoritesNav,
      filmsService: filmsService
    )
    
    coordinate(to: favoritesCoordinator)
      .subscribe()
      .disposed(by: disposeBag)
    
    tabBarController.viewControllers = [filmsNav, favoritesNav]

    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    return .never()
  }
}
