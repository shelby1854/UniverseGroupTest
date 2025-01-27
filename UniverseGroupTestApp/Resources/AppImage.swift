//
//  AppImage.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit

enum AppImage {
    enum MainTabBar {
        static let filmsLogo = UIImage(systemName: "list.bullet")
        static let favsLogo = UIImage(systemName: "star.fill")
    }

    enum Films {
        static let addToFavStar = UIImage(systemName: "star.fill")
    }
    
    enum FavFilms {
        static let trashButton = UIImage(systemName: "trash")
        static let placeholderImage = UIImage(systemName: "film")
    }
    
    enum FilmCell {
        static let fillSquare = UIImage(named: "fillSquare")
        static let square = UIImage(named: "square")
    }
}
