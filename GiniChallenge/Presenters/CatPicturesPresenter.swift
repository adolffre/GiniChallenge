//
//  CatPicturesPresenter.swift
//  GiniChallenge
//
//  Created by A. J. on 28.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import Foundation
import CoreData

protocol CatPicturesView: NSObjectProtocol {
  func reloadCatCollection(cats: [Cat])
  func reloadCatPicture(cat: Cat, indexPath: IndexPath)
}

class CatPicturesPresenter {
  weak fileprivate var catPicturesView: CatPicturesView?
  fileprivate var imagesService: ImagesService
  fileprivate var persistantService: PersistantService
  fileprivate var catImages: [Cat] = []
  
  init(imagesService: ImagesService, persistantService: PersistantService, catPicturesView: CatPicturesView) {
    self.imagesService = imagesService
    self.catPicturesView = catPicturesView
    self.persistantService = persistantService
  }
  
  func notifyViewDidLoad() {
    loadCatImages { [weak self] (cats) in
      guard let `self` = self else { return }
      self.updateCatsList(cats: cats)
    }
  }
  
  func notifyViewWillAppear() {
    
  }
  
  func showFavoriteCatPicturesPressed() {
    //TODO:
  }
  
  func selectedCatPictureAt(indexPath: IndexPath) {
  
    let cat = catImages[indexPath.row]
    cat.isFavorite = !cat.isFavorite
    
    if cat.isFavorite {
      setFavorite(cat: cat)
    } else {
      removeFromFavorite(cat: cat)
    }
    
    catPicturesView?.reloadCatPicture(cat: cat, indexPath: indexPath)
  }
  
  func changedToPicAt(index: Int) {
    if index == catImages.count - 2 {
      reachingLastPictures()
    }
    
  }
  
  func reachingLastPictures() {
    loadCatImages { [weak self] (cats) in
      guard let `self` = self else { return }
      self.updateCatsList(cats: cats)
    }
  }
  
}
// MARK: -  private methods
fileprivate extension CatPicturesPresenter {
  func setFavorite(cat: Cat) {
    if let catId = cat.id {
      save(cat: cat)
      imagesService.setFavorite(catId: catId)
    }
  }
  
  func removeFromFavorite(cat: Cat) {
    if let catId = cat.id {
      delete(cat: cat)
      imagesService.removeFavorite(catId: catId)
    }
  }
  
  func save(cat: Cat) {
    persistantService.save(cat: cat)
  }
  func delete(cat: Cat) {
    persistantService.delete(cat: cat)
  }
  
  func loadCatImages(completion: @escaping (CatsCallBack)) {
    imagesService.getCatImages(completion: completion)
  }
  
  func updateCatsList(cats: [Cat]?) {
    if let catsList = cats {
      self.catImages.append(contentsOf: catsList)
      self.catPicturesView?.reloadCatCollection(cats: self.catImages)
    }
  }
  
  
}
