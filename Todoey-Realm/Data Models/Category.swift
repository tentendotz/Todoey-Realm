//
//  Category.swift
//  Todoey-Realm
//
//  Created by tetsuta matsuyama on 2023/03/19.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String
    @Persisted var items: List<Item>
}
