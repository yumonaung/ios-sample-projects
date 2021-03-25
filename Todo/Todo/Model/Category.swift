//
//  Category.swift
//  Todoey
//
//  Created by Yu Mon Aung on 2021/02/24.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
    
   
    
}
