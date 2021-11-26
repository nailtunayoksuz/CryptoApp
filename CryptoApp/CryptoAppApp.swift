//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Nail Tunay ÖKSÜZ on 24.11.2021.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
