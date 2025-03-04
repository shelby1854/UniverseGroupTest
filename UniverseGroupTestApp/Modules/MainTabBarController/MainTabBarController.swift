//
//  MainTabBarController.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBarAppearance()
  }
  
  // MARK: - Setup
  private func setupNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = AppColor.MainTabBar.navigationBarBG
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
}
