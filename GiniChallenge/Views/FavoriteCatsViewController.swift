//
//  FavoriteCatsViewController.swift
//  GiniChallenge
//
//  Created by A. J. on 29.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import UIKit

class FavoriteCatsViewController: UIViewController {
  fileprivate var presenter: FavoriteCatsPresenter?
  fileprivate var catsList: [Cat] = []
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = instanciatePresenter()
    presenter?.notifyViewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.notifyViewWillAppear()
  }
  
  private func instanciatePresenter() -> FavoriteCatsPresenter {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let persistantService = PersistantService(context: context)
    
    return FavoriteCatsPresenter(persistantService: persistantService, favoriteCatView: self)
  }
  
}

extension FavoriteCatsViewController: UICollectionViewDataSource
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return catsList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as? CatCollectionViewCell {
      let item = catsList[indexPath.row]
      cell.render(cat: item)
      return cell
    }
    
    return UICollectionViewCell()
  }
}

extension FavoriteCatsViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collectionView.frame.width , height: 346)
  }
}

extension FavoriteCatsViewController: FavoriteCatView {
  func reloadCatCollection(cats: [Cat]) {
    catsList = cats
    collectionView.reloadData()
  }
}
