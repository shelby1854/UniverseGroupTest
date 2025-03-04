//
//  SplashViewModel.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashViewModel {
  private let disposeBag = DisposeBag()
  private let filmsService: FilmsServiceProtocol
  
  let loadingText: Driver<String>
  
  private let finishLoadingSubject = PublishSubject<Void>()
  var finishLoading: Driver<Void> {
    finishLoadingSubject.asDriver(onErrorDriveWith: .empty())
  }
  
  init(filmsService: FilmsServiceProtocol) {
    self.filmsService = filmsService
    
    loadingText = .just("Loading films...").asDriver()
    
    observeFilms()
  }
  
  func startLoading() {
    // Network request imitation
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.filmsService.loadData()
    }
  }
}

// MARK: - Private methods
private extension SplashViewModel {
  func observeFilms() {
    filmsService.films
      .subscribe(onNext: { [weak self] films in
        self?.finishLoadingSubject.onNext(())
      }, onError: { error in
        print("Failed to load films: \(error)")
      })
      .disposed(by: disposeBag)
  }
}
