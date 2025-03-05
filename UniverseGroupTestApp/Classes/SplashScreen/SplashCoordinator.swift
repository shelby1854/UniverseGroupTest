//
//  SplashCoordinator.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 04.03.2025.
//

import UIKit
import RxSwift

enum FilmsLoadingResult {
  case success
  case error
}

final class SplashCoordinator: BaseCoordinator<Void> {
  private let window: UIWindow
  private let filmsService: FilmsServiceProtocol
  
  init(window: UIWindow, filmsService: FilmsServiceProtocol) {
    self.window = window
    self.filmsService = filmsService
  }

  override func start() -> Observable<Void> {
    let viewModel = SplashViewModel(filmsService: filmsService)
    let viewController = SplashViewController(viewModel: viewModel)
    let navController = UINavigationController(rootViewController: viewController)

    window.rootViewController = navController
    window.makeKeyAndVisible()
    
    viewModel.startLoading()
    
    let coordinatorSubject = PublishSubject<Void>()
    
    viewModel.output.loadingFinished
      .subscribe(onNext: { [weak self] result in
        guard let self else { return }
        
        switch result {
        case .success:
          coordinatorSubject.onNext(())
          coordinatorSubject.onCompleted()
          
        case .error:
          self.showErrorAlert(on: viewController) {
            viewModel.startLoading()
          }
        }
      })
      .disposed(by: disposeBag)
    
    return coordinatorSubject.asObservable()
  }
  
  private func showErrorAlert(on baseVC: UIViewController, retryAction: @escaping () -> Void) {
    let alert = UIAlertController(
      title: "Error",
      message: "Failed to load films. Try again?",
      preferredStyle: .alert
    )
    
    let retry = UIAlertAction(title: "Retry", style: .default) { _ in
      retryAction()
    }
    alert.addAction(retry)

    baseVC.present(alert, animated: true, completion: nil)
  }
}
