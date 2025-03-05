//
//  FilmsViewModel.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import RxSwift
import RxCocoa

final class FilmsViewModel {
  //MARK: - Nested Types
  struct Input {
    let selectFilm: AnyObserver<FilmBO>
    let addSelected: AnyObserver<Void>
  }
  
  struct Output {
    let films: Observable<[FilmBO]>
    let selectedFilms: Observable<[FilmBO]>
  }
  
  // MARK: - Public Properties
  let input: Input
  let output: Output
  
  // MARK: - Private
  private let disposeBag = DisposeBag()
  private let filmsService: FilmsServiceProtocol
  
  private let selectFilmSubject = PublishSubject<FilmBO>()
  private let addSelectedSubject = PublishSubject<Void>()
 
  private let selectedFilmsRelay = BehaviorRelay<[FilmBO]>(value: [])
  
  // MARK: - Init
  init(filmsService: FilmsServiceProtocol) {
    self.filmsService = filmsService
    
    let films = filmsService.films
    let selectedFilms = selectedFilmsRelay.asObservable()
    
    output = Output(
      films: films,
      selectedFilms: selectedFilms
    )
    
    let selectedFilmObserver: AnyObserver<FilmBO> = selectFilmSubject.asObserver()
    let addSelectedObserver: AnyObserver<Void> = addSelectedSubject.asObserver()
    
    input = Input(
      selectFilm: selectedFilmObserver,
      addSelected: addSelectedObserver
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
    
    addSelectedSubject
      .subscribe(onNext: { [weak self] in
        self?.addSelectedToFavorites()
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
  
  private func addSelectedToFavorites() {
    let selected = selectedFilmsRelay.value
    filmsService.toggleFavorites(for: selected)
    selectedFilmsRelay.accept([])
  }
  
  //MARK: - Public
  func toggleFavorite(for film: FilmBO) {
    filmsService.toggleFavorites(for: [film])
  }
  
  func isSelected(_ film: FilmBO) -> Bool {
    selectedFilmsRelay.value.contains { $0.id == film.id }
  }
}

// MARK: - Strings providing
extension FilmsViewModel {
  func alertTexts(for film: FilmBO) -> (title: String, message: String, confirm: String, cancel: String) {
    (
      title: "Remove from Favorites?",
      message: "Are you sure you want to remove \(film.title) from favorites?",
      confirm: "Yes",
      cancel: "Cancel"
    )
  }
}
