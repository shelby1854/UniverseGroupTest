//
//  MainCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 26.01.2025.
//

import UIKit

final class MainCoordinator {
    private let window: UIWindow
    private let dependenciesContainer: AppDIContainer

    init(window: UIWindow, dependenciesContainer: AppDIContainer) {
        self.window = window
        self.dependenciesContainer = dependenciesContainer
    }

    func start() {
        let mainTabBarController = MainTabBarController()
        setupTabBar(mainTabBarController)
        window.rootViewController = mainTabBarController
    }

    private func setupTabBar(_ tabBarController: MainTabBarController) {
        let filmsScene = dependenciesContainer.makeFilmsScene()
        filmsScene.view.title = "Films"

        let favoritesScene = dependenciesContainer.makeFavoritesScene()
        favoritesScene.view.title = "Favorites"

        let navItems = UINavigationController(rootViewController: filmsScene.view)
        let navFavorites = UINavigationController(rootViewController: favoritesScene.view)

        navItems.tabBarItem = UITabBarItem(
            title: "Films",
            image: AppImage.MainTabBar.filmsLogo,
            tag: 0
        )
        
        navFavorites.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: AppImage.MainTabBar.favsLogo,
            tag: 1
        )
        
        tabBarController.viewControllers = [navItems, navFavorites]
    }
}
