//
//  FavoritesViewModel.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import RxSwift
import RxCocoa
//
//final class FavoritesViewModel {
//  let filmsService: FilmsServiceProtocol
//  let selectedFilms = BehaviorRelay<[FilmBO]>(value: [])
//  
//  var isPlaceholderHidden: Observable<Bool> {
//    filmsService.favoriteFilms
//      .map { !$0.isEmpty }
//  }
//  
//  init(filmsService: FilmsServiceProtocol) {
//    self.filmsService = filmsService
//  }
//  
//  func removeFromFavorites(film: FilmBO) {
//    filmsService.toggleFavorites(for: [film])
//  }
//  
//  func removeSelectedFromFavorites() {
//    filmsService.toggleFavorites(for: selectedFilms.value)
//    selectedFilms.accept([])
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
//  func isSelected(_ film: FilmBO) -> Bool {
//    selectedFilms.value.contains(where: { $0.id == film.id })
//  }
//}
//
//// MARK: - Strings providing
//extension FavoritesViewModel {
//  var placeholderText: String {
//    "You haven't selected any films."
//  }
//  
//  var removeAllAlertTexts: (title: String, message: String, confirm: String, cancel: String) {
//    (
//      title: "Remove All Favorites?",
//      message: "Are you sure you want to remove all films from favorites?",
//      confirm: "Yes",
//      cancel: "Cancel"
//    )
//  }
//}
