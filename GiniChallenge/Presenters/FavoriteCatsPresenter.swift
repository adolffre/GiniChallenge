//
//  FavoriteCatsPresenter.swift
//  GiniChallenge
//
//  Created by A. J. on 29.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import Foundation

protocol FavoriteCatView: NSObjectProtocol {
  func reloadCatCollection(cats: [Cat])
}

class FavoriteCatsPresenter {
  weak fileprivate var favoriteCatView: FavoriteCatView?
  fileprivate var persistantService: PersistantService
  fileprivate var catImages: [Cat] = []
  
  init(persistantService: PersistantService, favoriteCatView: FavoriteCatView) {
    self.favoriteCatView = favoriteCatView
    self.persistantService = persistantService
  }
  
  func notifyViewDidLoad() {
    let cats = loadFavoriteCats()
    updateCatsList(cats: cats)
  }
  func notifyViewWillAppear() {
  }
}

// MARK: -  private methods
fileprivate extension FavoriteCatsPresenter {
  func loadFavoriteCats() -> [Cat] {
    let cats = persistantService.loadFavoriteCats()
    return cats
  }
  func updateCatsList(cats: [Cat]) {
    catImages = cats
    favoriteCatView?.reloadCatCollection(cats: cats)
  }
  
}
