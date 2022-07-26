//
//  createYourDictApp.swift
//  createYourDict
//
//  Created by Bora Erdem on 26.07.2022.
//

import SwiftUI

@main
struct createYourDictApp: App {
    @StateObject var vm = CoreData()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
            }
            .environmentObject(vm)
        }
    }
}
