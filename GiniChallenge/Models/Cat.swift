//
//  Cat.swift
//  GiniChallenge
//
//  Created by A. J. on 28.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import Foundation
import XMLMapper

class CatsResponse: XMLMappable {
  var nodeName: String!
  var catsList: [Cat]?
  
  required init(map: XMLMap) {
    
  }
  
  func mapping(map: XMLMap) {
    catsList <- map["data.images.image"]
  }
}

class Cat: XMLMappable {
  var nodeName: String!
  
  var imgUrl: String?
  var id: String?
  var isFavorite = false
  
  required init(map: XMLMap) {
    
  }
  
  func mapping(map: XMLMap) {
    imgUrl <- map["url"]
    id <- map["id"]
  }
}

