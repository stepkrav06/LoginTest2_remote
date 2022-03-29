//
//  Database.swift
//  LoginTest
//
//  Created by Степан Кравцов on 27.03.2022.
//

import Foundation
import Firebase

public struct GroceryItem: Identifiable {
    public var id = UUID()
  let ref: DatabaseReference?
  let key: String
  let name: String
  let addedByUser: String
  var completed: Bool

  // MARK: Initialize with Raw Data
  public init(name: String, addedByUser: String, completed: Bool, key: String = "") {
    self.ref = nil
    self.key = key
    self.name = name
    self.addedByUser = addedByUser
    self.completed = completed
  }

  // MARK: Initialize with Firebase DataSnapshot
  public init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let name = value["name"] as? String,
      let addedByUser = value["addedByUser"] as? String,
      let completed = value["completed"] as? Bool
    else {
      return nil
    }

    self.ref = snapshot.ref
    self.key = snapshot.key
    self.name = name
    print(name)
    self.addedByUser = addedByUser
    self.completed = completed
  }

  // MARK: Convert GroceryItem to AnyObject
  public func toAnyObject() -> Any {
    return [
      "name": name,
      "addedByUser": addedByUser,
      "completed": completed
    ]
  }
}
public let ref = Database.database().reference(withPath: "grocery-items")
public var refObservers: [DatabaseHandle] = []
public func addItem(item: String){
    let newItem = GroceryItem(
        name: item,
        addedByUser: item,
        completed: false)

    let groceryItemRef = ref.child(item.lowercased())
    groceryItemRef.setValue(newItem.toAnyObject())
    
}
public var itemList: [GroceryItem] = []


class Items: ObservableObject {
    @Published var items: [GroceryItem] = []
}

public class Settings {
    public static var itemList: [GroceryItem] = []
    public static func loadItems(){
        let completed = ref.observe(.value) { snapshot in
          // 2
          var newItems: [GroceryItem] = []
          // 3
          for child in snapshot.children {
            // 4
            
            if
              let snapshot = child as? DataSnapshot,
              let groceryItem = GroceryItem(snapshot: snapshot) {
              newItems.append(groceryItem)
                print(newItems)
            }
          }
            self.itemList = newItems
            print("this is before \(self.itemList)")
        }
        // 6
        refObservers.append(completed)
    }
}

public class Event: Identifiable{
    public var id = UUID()
    let title: String
    public init(title: String){
        self.title = title
    }
}
