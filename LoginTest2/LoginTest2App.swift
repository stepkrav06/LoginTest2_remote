//
//  LoginTest2App.swift
//  LoginTest2
//
//  Created by Степан Кравцов on 28.03.2022.
//

import SwiftUI
import Firebase

@main
struct LoginTest2App: App {
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
