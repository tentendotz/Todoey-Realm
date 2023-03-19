//
//  Item.swift
//  Todoey-Realm
//
//  Created by tetsuta matsuyama on 2023/03/19.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
}
