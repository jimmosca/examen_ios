//
//  Category.swift
//  examen_ios
//
//  Created by Jaime Casado Aparicio on 26/2/20.
//  Copyright © 2020 Jaime Casado Aparicio. All rights reserved.
//

import Foundation

class Category {
    var id: String?
    var nombre: String?
    var items: Array<String>?
    
    convenience init(id: String, nombre: String, items: Array<String>) {
        self.init()
        self.id = id
        self.nombre = nombre
        self.items = items
        
        
    }
}
