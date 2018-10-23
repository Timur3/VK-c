//
//  DataProvider.swift
//  VK-c
//
//  Created by Timur on 04.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation
import RealmSwift

struct DataProvider {
    
    static func getObjects<T: Object>() -> [T]{
        var items = [T]()
        do {
            let realm = try Realm()
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            items = Array(realm.objects(T.self))
            return items
        } catch {
            print(error)
            return items
        }
    }
    
    static func saveObjects<T: Object>(_ items: [T]){
        do {
            let realm = try Realm()
            let oldItems = realm.objects(T.self)
            print("Realm path:", realm.configuration.fileURL ?? "no url")
            try realm.write {
                realm.delete(oldItems)
                realm.add(items)
            }
        } catch {
            print(error)
        }
    }
}
