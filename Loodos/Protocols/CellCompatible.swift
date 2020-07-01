//
//  CellCompatible.swift
//  Icrypex
//
//  Created by iMac on 12.03.2020.
//  Copyright © 2020 DevTeam. All rights reserved.
//

import UIKit

protocol CellCompatible {
   
    var reuseIdentifier: String { get }
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
    func cellForSize(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CGSize
    
}

extension CellCompatible {
    
    func cellForSize(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}


