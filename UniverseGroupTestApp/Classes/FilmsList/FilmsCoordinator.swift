//
//  FilmsCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 04.03.2025.
//

import RxSwift
import UIKit

final class FilmsCoordinator: BaseCoordinator<Void> {
  private let navigationController: UINavigationController
  private let filmsService: FilmsServiceProtocol
  
  init(navigationController: UINavigationController,
       filmsService: FilmsServiceProtocol) {
    self.navigationController = navigationController
    self.filmsService = filmsService
  }
  
  override func start() -> Observable<Void> {
    let filmsVM = FilmsViewModel(filmsService: filmsService)
    let filmsVC = FilmsViewController(viewModel: filmsVM)
    
    navigationController.viewControllers = [filmsVC]
    return .never()
  }
}
