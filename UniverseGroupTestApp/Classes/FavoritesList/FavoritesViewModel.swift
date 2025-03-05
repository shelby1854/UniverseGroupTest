//
//  FavoritesViewModel.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 05.03.2025.
//

import RxSwift
import RxCocoa

final class FavoritesViewModel {
  // MARK: - Nested Types
  struct Input {
    let selectFilm: AnyObserver<FilmBO>
    let removeSelected: AnyObserver<Void>
  }
  
  struct Output {
    let favoriteFilms: Observable<[FilmBO]>
    let selectedFilms: Observable<[FilmBO]>
    let isPlaceholderHidden: Observable<Bool>
  }
  
  // MARK: - Public
  let input: Input
  let output: Output
  
  // MARK: - Private
  private let disposeBag = DisposeBag()
  private let filmsService: FilmsServiceProtocol
  
  private let selectedFilmsRelay = BehaviorRelay<[FilmBO]>(value: [])
  
  private let selectFilmSubject = PublishSubject<FilmBO>()
  private let removeSelectedSubject = PublishSubject<Void>()

  //MARK: - Init
  init(filmsService: FilmsServiceProtocol) {
    self.filmsService = filmsService
    
    let favoriteFilms = filmsService.favoriteFilms
    let selectedFilms = selectedFilmsRelay.asObservable()
    let isPlaceholderHidden = favoriteFilms.map { !$0.isEmpty }
    
    output = Output(
      favoriteFilms: favoriteFilms,
      selectedFilms: selectedFilms,
      isPlaceholderHidden: isPlaceholderHidden
    )
    
    input = Input(
      selectFilm: selectFilmSubject.asObserver(),
      removeSelected: removeSelectedSubject.asObserver()
    )
    
    setupBindings()
  }
  
  //MARK: - Private
  private func setupBindings() {
    selectFilmSubject
      .subscribe(onNext: { [weak self] film in
        self?.toggleSelection(for: film)
      })
      .disposed(by: disposeBag)
    
    removeSelectedSubject
      .subscribe(onNext: { [weak self] in
        self?.removeSelectedFromFavorites()
      })
      .disposed(by: disposeBag)
  }
  
  private func toggleSelection(for film: FilmBO) {
    var currentSelection = selectedFilmsRelay.value
    
    if currentSelection.contains(where: { $0.id == film.id }) {
      currentSelection.removeAll(where: { $0.id == film.id })
    } else {
      currentSelection.append(film)
    }
    
    selectedFilmsRelay.accept(currentSelection)
  }
  
  private func removeSelectedFromFavorites() {
    let toRemove = selectedFilmsRelay.value
    filmsService.toggleFavorites(for: toRemove)
    selectedFilmsRelay.accept([])
  }
  
  func removeFromFavorites(film: FilmBO) {
    filmsService.toggleFavorites(for: [film])
  }


}

// MARK: - Strings providing
extension FavoritesViewModel {
  var placeholderText: String {
    "You haven't selected any films."
  }
  
  var removeAllAlertTexts: (title: String, message: String, confirm: String, cancel: String) {
    (
      title: "Remove All Favorites?",
      message: "Are you sure you want to remove all films from favorites?",
      confirm: "Yes",
      cancel: "Cancel"
    )
  }
  
  func isSelected(_ film: FilmBO) -> Bool {
    selectedFilmsRelay.value.contains(where: { $0.id == film.id })
  }
}
