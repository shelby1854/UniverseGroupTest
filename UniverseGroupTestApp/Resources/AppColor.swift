//
//  AppColor.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit

struct AppColorrr {
    static let mainBG = UIColor(named: "mainBG")
}

enum AppColor {
    private static let defaultColor: UIColor = .red
    private static func UIColor(named color: String) -> UIColor {
      .init(named: color) ?? defaultColor
    }
    
    enum Common {
        static let mainBG = UIColor(named: "mainBG")
    }
    
    enum MainTabBar {
        static let navigationBarBG = UIColor(named: "navigationBarBG")
    }
    
    enum Splash {
        static let indicatorColor = UIColor(named: "indicatorColor")
    }

    enum FavFilms {
        static let placeholderColor = UIColor(named: "placeholderColor")
    }
    
    enum FilmCell {
        static let removeFromFavActionBG = UIColor(named: "removeFromFavActionBG")
        static let addToFavActionBG = UIColor(named: "addToFavActionBG")
        static let selectedCell = UIColor(named: "selectedCell")
        static let title = UIColor(named: "title")
        static let description = UIColor(named: "description")
        static let favImage = UIColor(named: "favImage")
    }
}
