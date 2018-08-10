//
//  PersistantService.swift
//  GiniChallenge
//
//  Created by A. J. on 29.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import Foundation
import CoreData

protocol CatPersistant {
  func save(cat: Cat)
  func delete(cat: Cat)
  func loadFavoriteCats() -> [Cat]
}

class PersistantService {
  
  fileprivate var context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext) {
    self.context = context
  }
}

extension PersistantService: CatPersistant {
  
  func save(cat: Cat) {
    if createModelObjectFrom(cat: cat) != nil {
      do {
        try context.save()
      } catch {
        print("Failed saving")
        }
    }
  }
  
  func delete(cat: Cat) {
    if let catId = cat.id  {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CatModel")
      request.returnsObjectsAsFaults = false
      request.predicate = NSPredicate(format: "catId == %@", catId)
      
      do {
        let result = try context.fetch(request) as! [CatModel]
        context.delete(result.first!)
      } catch {
        print("Failed")
      }
    }
  }
  
  func loadFavoriteCats() -> [Cat] {
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CatModel")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request) as! [CatModel]
      let catsToReturn = convertCatModelListToCatList(catModelList: result)
      return catsToReturn
    } catch {
      print("Failed")
    }
    return []
  }
  
  fileprivate func convertCatModelListToCatList(catModelList: [CatModel]) -> [Cat] {
    var catsToReturn = [Cat]()
    for catModel in catModelList {
      let cat = Cat()
      cat.id = catModel.catId
      cat.imgUrl = catModel.imgUrl
      cat.isFavorite = true
      catsToReturn.append(cat)
    }
    return catsToReturn
  }

  fileprivate func createModelObjectFrom(cat: Cat) -> NSManagedObject? {
    let entity = NSEntityDescription.entity(forEntityName: "CatModel", in: context)
    let catModel = NSManagedObject(entity: entity!, insertInto: context)
    catModel.setValue(cat.id, forKey: "catId")
    catModel.setValue(cat.imgUrl, forKey: "imgUrl")
    return catModel
  }
}

