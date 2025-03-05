//
//  FavoritesCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 04.03.2025.
//

import RxSwift
import UIKit

final class FavoritesCoordinator: BaseCoordinator<Void> {
  private let navigationController: UINavigationController
  private let filmsService: FilmsServiceProtocol
  
  init(navigationController: UINavigationController,
       filmsService: FilmsServiceProtocol) {
    self.navigationController = navigationController
    self.filmsService = filmsService
  }
  
  override func start() -> Observable<Void> {
    let favoritesVM = FavoritesViewModel(filmsService: filmsService)
    let favoritesVC = FavoritesViewController(viewModel: favoritesVM)
    
    navigationController.viewControllers = [favoritesVC]
    return .never()
  }
}
