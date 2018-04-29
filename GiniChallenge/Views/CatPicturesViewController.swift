//
//  CatPicturesViewController.swift
//  GiniChallenge
//
//  Created by A. J. on 28.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import UIKit

class CatPicturesViewController: UIViewController {
  fileprivate var presenter: CatPicturesPresenter?
  fileprivate var catsList: [Cat] = []
  @IBOutlet weak var collectionView: UICollectionView!
  
  var animator: UIDynamicAnimator?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter = instanciatePresenter()
    presenter?.notifyViewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter?.notifyViewWillAppear()
  }
  
  private func instanciatePresenter() -> CatPicturesPresenter {
    let imageService = ImagesService()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let persistantService = PersistantService(context: context)
    
    return CatPicturesPresenter(imagesService: imageService, persistantService: persistantService, catPicturesView: self)
  }
  
}

extension CatPicturesViewController: UICollectionViewDataSource
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return catsList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCollectionViewCell", for: indexPath) as? CatCollectionViewCell {
      let item = catsList[indexPath.row]
      cell.render(cat: item)
      presenter?.changedToPicAt(index: indexPath.row)
      return cell
    }
    
    return UICollectionViewCell()
  }
}

extension CatPicturesViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
      return CGSize(width: collectionView.frame.width , height: 346)
  }
}

extension CatPicturesViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter?.selectedCatPictureAt(indexPath: indexPath)
  }
}

extension CatPicturesViewController: CatPicturesView {
  func reloadCatCollection(cats: [Cat]) {
    catsList = cats
    collectionView.reloadData()
  }
  
  
  func reloadCatPicture(cat: Cat, indexPath: IndexPath) {
    catsList[indexPath.row] = cat
    collectionView.reloadItems(at: [indexPath])
  }
}
