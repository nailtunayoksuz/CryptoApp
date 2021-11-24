//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Nail Tunay ÖKSÜZ on 24.11.2021.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
