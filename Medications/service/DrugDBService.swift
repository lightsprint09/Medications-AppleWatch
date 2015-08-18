//
//  DrugDBService.swift
//  Medications
//
//  Created by Lukas Schmidt on 18.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import CoreData

class DrugDBService: NSObject {
    
    func sortedFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: Drug.entityName)
        let sortDiscriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDiscriptor]
        
        return fetchRequest
    }
}
