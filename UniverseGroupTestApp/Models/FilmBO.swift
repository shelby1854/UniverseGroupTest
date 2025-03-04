//
//  FilmBO.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 26.01.2025.
//

import UIKit

final class FilmBO {
  let id: UUID
  let title: String
  let description: String
  let releaseDate: Int
  
  var isFavorite: Bool
  
  init(id: UUID, title: String, description: String, releaseDate: Int, isFavorite: Bool = false) {
    self.id = id
    self.title = title
    self.description = description
    self.releaseDate = releaseDate
    self.isFavorite = isFavorite
  }
}

extension FilmBO {
  var trailingActionTitle: String {
    isFavorite ? "Unfavorite" : "Favorite"
  }
  
  var trailingActionBackgroundColor: UIColor {
    isFavorite ? AppColor.FilmCell.removeFromFavActionBG : AppColor.FilmCell.addToFavActionBG
  }
}
