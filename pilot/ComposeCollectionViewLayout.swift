//
//  ComposeCollectionViewLayout.swift
//  pilot
//
//  Created by Nick Eckert on 11/23/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import UIKit

// This class defines the layout and properties of each cell for the ComposeCollectionView

class ComposeCollectionViewLayout: UICollectionViewLayout {

  override var collectionViewContentSize: CGSize {
    return CGSize.init(width: 1, height: 1)
  }

  override func prepare() {

  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return nil
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return nil
  }

}
