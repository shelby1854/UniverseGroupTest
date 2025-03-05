//
//  AnimatableSection.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 05.03.2025.
//

import RxDataSources

typealias IdentifiableItem = IdentifiableType & Equatable

struct AnimatableSection<SectionItem: IdentifiableItem>: AnimatableSectionModelType, Equatable {
  typealias Item = SectionItem
  typealias Identity = String
  
  var items: [Item]
  var uniqueId: String = ""
  
  public init(original: AnimatableSection, items: [Item]) {
    self = original
    self.items = items
  }
  
  public init(uniqueId: String = "", items: [Item]) {
    self.items = items
    self.uniqueId = uniqueId
  }
  
  public var identity: String {
    uniqueId
  }
}
