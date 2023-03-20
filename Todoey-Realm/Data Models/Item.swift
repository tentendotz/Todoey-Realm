//
//  Item.swift
//  Todoey-Realm
//
//  Created by tetsuta matsuyama on 2023/03/19.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String
    @Persisted var done = false
    @Persisted var dateCreated: Date?
    @Persisted(originProperty: "items") var parentCategory: LinkingObjects<Category>
}
