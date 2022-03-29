//
//  ContentView.swift
//  LoginTest
//
//  Created by Степан Кравцов on 27.03.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @StateObject var items = Items()
//    @State var settings = Settings()
    var body: some View {
        ListPage().environmentObject(items).onAppear{
//            settings.loadItems()
//            items.items = settings.itemList
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
                items.items = newItems
            }
            // 6
            refObservers.append(completed)
            
        }
        .onDisappear{
            refObservers.forEach(ref.removeObserver(withHandle:))
            refObservers = []
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
