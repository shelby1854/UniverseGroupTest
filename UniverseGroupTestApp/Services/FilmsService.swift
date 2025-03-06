//
//  Untitled.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import RxSwift
import RxCocoa

protocol FilmsServiceProtocol: AnyObject {
  var films: Observable<[FilmBO]> { get }
  var filmsValue: [FilmBO] { get }
  var favoriteFilms: Observable<[FilmBO]> { get }
  
  func loadData()
  func toggleFavorites(for films: [FilmBO])
  func updateAllFilms(_ films: [FilmBO])
}

final class FilmsService {
  private let filmsRelay: BehaviorRelay<[FilmBO]> = BehaviorRelay(value: [])
  private let favoriteFilmsRelay: BehaviorRelay<[FilmBO]> = BehaviorRelay(value: [])
}

// MARK: - FilmsServiceProtocol implementation

extension FilmsService: FilmsServiceProtocol {
  var films: Observable<[FilmBO]> {
    filmsRelay.asObservable()
  }
  
  var filmsValue: [FilmBO] {
    filmsRelay.value
  }
  
  var favoriteFilms: Observable<[FilmBO]> {
    filmsRelay.map { $0.filter { $0.isFavorite } }
  }
  
  func loadData() {
    let mockFilms = FilmDTO.mockData
    filmsRelay.accept(FilmsMapper.convert(from: mockFilms))
  }
  
  func toggleFavorites(for films: [FilmBO]) {
    let updatedFilms = filmsRelay.value.map { film in
      if films.contains(where: { $0.id == film.id }) {
        var modifiedFilm = film
        modifiedFilm.isFavorite.toggle()
        return modifiedFilm
      }
      return film
    }

    filmsRelay.accept(updatedFilms)
  }
  
  func updateAllFilms(_ films: [FilmBO]) {
    filmsRelay.accept(films)
  }
}
