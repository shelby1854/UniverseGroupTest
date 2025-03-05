//
//  FilmsViewModel.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import RxSwift
import RxCocoa

typealias FilmSection = AnimatableSection<FilmBO>

final class FilmsViewModel {
  //MARK: - Nested Types
  struct Input {
    let selectFilm: AnyObserver<FilmBO>
    let addSelected: AnyObserver<Void>
    let toogleSort: AnyObserver<Void>
  }
  
  struct Output {
    let sections: Observable<[FilmSection]>
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
  private let toggleSortSubject = PublishSubject<Void>()
 
  private let selectedFilmsRelay = BehaviorRelay<[FilmBO]>(value: [])
  private let isSortedRelay = BehaviorRelay<Bool>(value: false)
  
  // MARK: - Init
  init(filmsService: FilmsServiceProtocol) {
    self.filmsService = filmsService
    
    let allFilms = filmsService.films
    
    let sections = Observable
      .combineLatest(allFilms, isSortedRelay)
      .map { films, isSorted -> [FilmSection] in
        if isSorted {
          let favorites = films.filter { $0.isFavorite }
          let others = films.filter { !$0.isFavorite }
          
          return [
            FilmSection(uniqueId: "Favorires", items: favorites),
            FilmSection(uniqueId: "Others", items: others)
          ]
        } else {
          return [
            FilmSection(uniqueId: "All", items: films)
          ]
        }
      }
    
    let selectedFilms = selectedFilmsRelay.asObservable()
    
    output = Output(
      sections: sections,
      selectedFilms: selectedFilms
    )
    
    input = Input(
      selectFilm: selectFilmSubject.asObserver(),
      addSelected: addSelectedSubject.asObserver(),
      toogleSort: toggleSortSubject.asObserver()
    )
    
    setupBindings()
  }
  
  //MARK: - Private
  private func setupBindings() {
    toggleSortSubject
      .subscribe(onNext: { [weak self] in
        guard let self else { return }
        self.isSortedRelay.accept(!self.isSortedRelay.value)
      })
      .disposed(by: disposeBag)
    
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
