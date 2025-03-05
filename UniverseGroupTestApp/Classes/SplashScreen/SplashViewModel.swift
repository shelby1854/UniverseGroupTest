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
  struct Input {}
  struct Output {
    let loadingText: Observable<String>
    let loadingFinished: Observable<FilmsLoadingResult>
  }
  
  // MARK: - Public Properties
  let input: Input
  let output: Output
  
  // MARK: - Private
  private let disposeBag = DisposeBag()
  private let filmsService: FilmsServiceProtocol
  private let finishLoadingSubject = PublishSubject<FilmsLoadingResult>()
  
  // MARK: - Init
  init(filmsService: FilmsServiceProtocol) {
    self.filmsService = filmsService
    
    input = Input()
    
    let loadingText = Observable.just("Loading films...")
    let finishLoading = finishLoadingSubject.asObservable()
    
    output = Output(
      loadingText: loadingText,
      loadingFinished: finishLoading
    )
    
    observeFilms()
  }
  
  func startLoading() {
    // Network request imitation
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      let success = Bool.random()
      if success {
        self.filmsService.loadData()
      } else {
        self.finishLoadingSubject.onNext(.error)
      }
    }
  }
}

// MARK: - Private methods
private extension SplashViewModel {
  func observeFilms() {
    filmsService.films
      .subscribe(onNext: { [weak self] _ in
        self?.finishLoadingSubject.onNext(.success)
      }, onError: { error in
        print("Failed to load films: \(error)")
      })
      .disposed(by: disposeBag)
  }
}
