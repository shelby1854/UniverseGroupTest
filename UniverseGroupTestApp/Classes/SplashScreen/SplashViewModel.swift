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
  // MARK: - Nested Types
  struct Input {
    
  }
  struct Output {
    let loadingText: Driver<String>
    let loadingFinished: Driver<Void>
  }
  
  // MARK: - Public Properties
  let input: Input
  let output: Output
  
  // MARK: - Private
  private let disposeBag = DisposeBag()
  private let filmsService: FilmsServiceProtocol
  private let finishLoadingSubject = PublishSubject<Void>()

  // MARK: - Init
  init(filmsService: FilmsServiceProtocol = FilmsService()) {
    self.filmsService = filmsService
    
    input = Input()
    
    let loadingText = Driver.just("Loading films...")
    let finishLoading = finishLoadingSubject.asDriver(onErrorDriveWith: .empty())
    
    output = Output(
      loadingText: loadingText,
      loadingFinished: finishLoading
    )
    
    observeFilms()
  }
  
  func startLoading() {
    // Network request imitation
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
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
