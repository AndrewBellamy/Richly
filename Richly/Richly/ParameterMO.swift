//
//  ParameterMO.swift
//  Richly
//
//  Created by Andrew Bellamy on 27/4/17.
//  Copyright © 2017 Andrew Bellamy. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ParameterMO: NSManagedObject {
    
    @NSManaged var type: String?
    @NSManaged var name: String?
    @NSManaged var category: String?

}
