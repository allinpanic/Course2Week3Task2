//
//  CustomFlowLayout.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

//protocol CustomFlowLayoutDelegate: AnyObject {
//  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
//}

class CustomFlowLayout: UICollectionViewLayout {
  //weak var delegate: CustomFlowLayoutDelegate?
  private var numberOfColumns = 2
  private var columnHeight: CGFloat = 0
  
  var cachedAttributes: [UICollectionViewLayoutAttributes] = []
  var contentBounds: CGRect = .zero
  
  override var collectionViewContentSize: CGSize {
    return contentBounds.size
  }
  override func prepare() {
    super.prepare()
    
    guard let collectionView = collectionView else {return}
    
    cachedAttributes.removeAll()
    contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
    
    let cellWidth = (UIScreen.main.bounds.width - 3 * 16) / 2
    
    let columnWidth = UIScreen.main.bounds.width / CGFloat(numberOfColumns)
    var xOffset: [CGFloat] = []
    for column in 0..<numberOfColumns {
      if column == 0 {
      xOffset.append(CGFloat(column) * columnWidth + 16)
      } else {
        xOffset.append(CGFloat(column) * columnWidth + 8)
      }
    }
    var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
    
    var currentIndex = 0
    var column = 0
    
    while currentIndex < collectionView.numberOfItems(inSection: 0) {
      let itemFrame: CGRect
      var height: CGFloat
      
      if currentIndex == 0 {
        height = 300
      } else { height = 200}
      
      itemFrame = CGRect(x: xOffset[column] , y: yOffset[column], width: cellWidth, height: height)
      
      let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0) )
      attributes.frame = itemFrame
      cachedAttributes.append(attributes)
      yOffset[column] = yOffset[column] + height + 16
      
      let heightInCurrentColumn = UIScreen.main.bounds.height - yOffset[column]
      let currColumn = column
      column = column < (numberOfColumns - 1) ? (column + 1) : 0
      let heightInOtherColumn = UIScreen.main.bounds.height - yOffset[column]
      
      if heightInOtherColumn < heightInCurrentColumn {
        column = currColumn
      }
      
      currentIndex += 1
      contentBounds = contentBounds.union(itemFrame)
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    for attributes in cachedAttributes {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.item]
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
      guard let collectionView = collectionView else { return false }
      return !newBounds.size.equalTo(collectionView.bounds.size)
  }
}
