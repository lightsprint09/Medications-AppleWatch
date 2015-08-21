//
//  DaytimeCollectionViewDataSource.swift
//  Medications
//
//  Created by Lukas Schmidt on 20.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

extension DayTimeSource: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func objectAtIndexPath(indexPath:NSIndexPath) -> DaytimeMedication {
        return source[indexPath.item]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("daytime-cell", forIndexPath: indexPath)
        if let cell = cell as? DaytimeCell {
            let object = self.objectAtIndexPath(indexPath)
            cell.confirgureWithDaytimeMedication(object)
        }
        
        return cell
    }
}