//
//  ImagesService.swift
//  GiniChallenge
//
//  Created by A. J. on 28.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import Foundation
import Alamofire
import XMLMapper

typealias CatsCallBack = (_ cats: [Cat]?) -> Void

protocol CatImagesProvider {
  func getCatImages(completion: @escaping (CatsCallBack))
}

class ImagesService {
  
  fileprivate let baseUrl = "http://thecatapi.com/api/images/"
  fileprivate let apiKey = "MzA1MzI1"
  
  fileprivate func requestUrl(url: String, completion: @escaping (_ data: CatsResponse?) -> Void) {
    
    Alamofire.request(url).responseXMLObject { (response: DataResponse<CatsResponse>) in
      let data = response.result.value
      completion(data)
    }
  }
}

extension ImagesService: CatImagesProvider {
  func getCatImages(completion: @escaping (CatsCallBack)) {
    let catImagesUrl = baseUrl + "get?api_key=\(apiKey)&format=xml&results_per_page=20"
    requestUrl(url: catImagesUrl) { (data) in
      if let data = data {
        completion(data.catsList)
      }
    }
  }
  func setFavorite(catId: String) {
    let defaults = UserDefaults.standard
    let userId = defaults.object(forKey: "userId") as! String
    let catImagesUrl = baseUrl + "favourite?api_key=\(apiKey)&sub_id=\(userId)&image_id=\(catId)"
    requestUrl(url: catImagesUrl) { (data) in
    }
  }
  
  func removeFavorite(catId: String) {
    let defaults = UserDefaults.standard
    let userId = defaults.object(forKey: "userId") as! String
    let catImagesUrl = baseUrl + "favourite?api_key=\(apiKey)&sub_id=\(userId)&image_id=\(catId)&action=remove"
    requestUrl(url: catImagesUrl) { (data) in
    }
  }
}

