//
//  CatPicturesPresenter.swift
//  GiniChallenge
//
//  Created by A. J. on 28.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import Foundation
import CoreData

protocol CatPicturesView: NSObjectProtocol{
  func reloadCatCollection()
  func reloadCatPicture(index: Int)
}

class CatPicturesPresenter {
  weak fileprivate var catPicturesView: CatPicturesView?
  fileprivate var imagesService: ImagesService
  fileprivate var catImages: [Cat] = []
  
  init(imagesService: ImagesService, catPicturesView: CatPicturesView) {
    self.imagesService = imagesService
    self.catPicturesView = catPicturesView
    
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
  
  func selectedCatPicture(cat: Cat) {
  
   
  }
  
  func reachedLastPicture() {
    loadCatImages { [weak self] (cats) in
      guard let `self` = self else { return }
      self.updateCatsList(cats: cats)
    }
  }
  
}
// MARK: -  private methods
fileprivate extension CatPicturesPresenter {
  
  func loadCatImages(completion: @escaping (CatsCallBack)) {
    imagesService.getCatImages(completion: completion)
  }
  
  func updateCatsList(cats: [Cat]?) {
    if let catsList = cats {
      self.catImages.append(contentsOf: catsList)
      self.catPicturesView?.reloadCatCollection()
    }
  }
  
  
}
