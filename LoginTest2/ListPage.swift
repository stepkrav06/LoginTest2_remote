//
//  ListPage.swift
//  LoginTest2
//
//  Created by Степан Кравцов on 28.03.2022.
//

import SwiftUI

struct ListPage: View {
    @State private var item: String = ""
    @EnvironmentObject var items: Items
    var body: some View {
        ZStack {
            VStack{
            TextField(
                    "Item",
                    text: $item
                )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            Button(action: {
                addItem(item: item)
                print("-----------")
                print(items.items)
                print("-----------")
                
            }){
                Text("Add item")
            }
                ForEach(items.items) { item in
                    Text(item.name)
                }
            }
                
        }
    }
}

struct ListPage_Previews: PreviewProvider {
    static var previews: some View {
        ListPage()
    }
}
