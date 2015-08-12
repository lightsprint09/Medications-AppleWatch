//
//  CoustomDrugCollectionViewDataSource.swift
//  Medications
//
//  Created by Lukas Schmidt on 12.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

extension CoustomDrugViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DrugRenderEnum.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("coustom-pill-cell", forIndexPath: indexPath)
        if let cell = cell as? CustomPillCell {
            let pillKind = DrugRenderEnum(rawValue: indexPath.row)
            cell.pillView.drugKind = pillKind
            cell.pillView.pillBaseColor = rgbColor
        }
        
        return cell;
    }
}
