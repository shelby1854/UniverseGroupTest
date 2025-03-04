//
//  FilmsViewModel.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import RxSwift
import RxCocoa
//
//final class FilmsViewModel {
//  private let disposeBag = DisposeBag()
//  
//  let filmsService: FilmsServiceProtocol
//  let selectedFilms = BehaviorRelay<[FilmBO]>(value: [])
//  
//  init(filmsService: FilmsServiceProtocol) {
//    self.filmsService = filmsService
//  }
//  
//  func toggleSelection(for film: FilmBO) {
//    var currentSelection = selectedFilms.value
//    
//    if currentSelection.contains(where: { $0.id == film.id }) {
//      currentSelection.removeAll(where: { $0.id == film.id })
//    } else {
//      currentSelection.append(film)
//    }
//    
//    selectedFilms.accept(currentSelection)
//  }
//  
//  func addSelectedToFavorites() {
//    filmsService.toggleFavorites(for: selectedFilms.value)
//    selectedFilms.accept([])
//  }
//  
//  func toggleFavorite(for film: FilmBO) {
//    filmsService.toggleFavorites(for: [film])
//  }
//  
//  func isSelected(_ film: FilmBO) -> Bool {
//    selectedFilms.value.contains(where: { $0.id == film.id })
//  }
//}
//
//// MARK: - Strings providing
//extension FilmsViewModel {
//  func alertTexts(for film: FilmBO) -> (title: String, message: String, confirm: String, cancel: String) {
//    (
//      title: "Remove from Favorites?",
//      message: "Are you sure you want to remove \(film.title) from favorites?",
//      confirm: "Yes",
//      cancel: "Cancel"
//    )
//  }
//}
