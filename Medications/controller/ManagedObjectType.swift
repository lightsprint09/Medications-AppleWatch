//
//  ManagedObjectType.swift
//  Medications
//
//  Created by Lukas Schmidt on 10.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import Foundation

public protocol ManagedObjectType {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}