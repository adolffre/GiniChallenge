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
  func loadFavoriteCats() -> [CatModel]
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
    if let catToDelete = createModelObjectFrom(cat: cat) {
      context.delete(catToDelete)
    }
  }
  
  func loadFavoriteCats() -> [CatModel] {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CatModel")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request) as! [CatModel]
      return result
    } catch {
      print("Failed")
    }
    return []
  }
  
  fileprivate func createModelObjectFrom(cat: Cat) -> NSManagedObject? {
    let entity = NSEntityDescription.entity(forEntityName: "CatModel", in: context)
    let catModel = NSManagedObject(entity: entity!, insertInto: context)
    catModel.setValue(cat.id, forKey: "catId")
    catModel.setValue(cat.imgUrl, forKey: "imgUrl")
    return catModel
  }
}

