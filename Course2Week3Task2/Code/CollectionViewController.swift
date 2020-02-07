//
//  CollectionViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  @IBOutlet weak var photosCollectionView: UICollectionView!
  var photos: [Photo] = []
  let imageCellIdentifier = "imageCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    photos = PhotoProvider().photos()
    print(photos.count)
    //photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: imageCellIdentifier)
    photosCollectionView.register(UINib(nibName:"PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: imageCellIdentifier)
    
    photosCollectionView.delegate = self
    photosCollectionView.dataSource = self
    
    photosCollectionView.reloadData()
  }
 // UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath)
      as? PhotoCollectionViewCell
      else {return UICollectionViewCell()}
    
    cell.configure(with: photos[indexPath.item])

    return cell
  }
}


