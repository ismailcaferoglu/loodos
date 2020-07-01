//
//  Datasource.swift
//  Icrypex
//
//  Created by iMac on 12.03.2020.
//  Copyright © 2020 DevTeam. All rights reserved.
//

import UIKit

class Datasource:NSObject,UICollectionViewDataSource {
    
    var sections = [CollectionViewSection]() {
        didSet {
            sections.sort {
                $0.sortOrder < $1.sortOrder
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = sections[indexPath.section].items[indexPath.row]
        
        return model.cellForCollectionView(collectionView: collectionView, atIndexPath: indexPath)
    }
    
    
}

class CollectionViewSection: Sectionable {
    
    var sortOrder: Int = 0
    var items: [CellCompatible]
    var headerTitle: String?
    var footerTitle: String?
    
    required init(sortOrder: Int, items: [CellCompatible], headerTitle: String? = nil, footerTitle: String? = nil)  {
        self.sortOrder = sortOrder
        self.items = items
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
    
}

protocol Sectionable {
    
    var sortOrder: Int { get set }
    var items: [CellCompatible] { get set }
    var headerTitle: String? { get set }
    var footerTitle: String? { get set }
    
    init(sortOrder: Int, items: [CellCompatible], headerTitle: String?, footerTitle: String?)
    
}
