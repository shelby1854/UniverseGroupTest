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
        films.forEach {
            $0.isFavorite.toggle()
        }

        filmsRelay.accept(filmsRelay.value)
    }
}
