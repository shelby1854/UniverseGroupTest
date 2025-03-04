//
//  FilmsMapper.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 26.01.2025.
//

import Foundation

enum FilmsMapper {
  static func convert(from dto: [FilmDTO]) -> [FilmBO] {
    dto.map {
      FilmBO(id: $0.id, title: $0.title, description: $0.description, releaseDate: $0.releaseDate)
    }
  }
}
