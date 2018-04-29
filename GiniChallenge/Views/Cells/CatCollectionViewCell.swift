//
//  CatCollectionViewCell.swift
//  GiniChallenge
//
//  Created by A. J. on 28.04.18.
//  Copyright © 2018 Adolf Jurgens. All rights reserved.
//

import SDWebImage

class CatCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var favoriteImage: UIImageView!
  
  static let reuseIdentifier = "CatCollectionViewCell"
  
  func render(cat: Cat)  {
    favoriteImage.image = cat.isFavorite ? #imageLiteral(resourceName: "heart_on") : #imageLiteral(resourceName: "heart_fade")
    imageView.sd_setImage(with: URL(string: cat.imgUrl!), placeholderImage: UIImage(named: "no_image"))
  }
}
