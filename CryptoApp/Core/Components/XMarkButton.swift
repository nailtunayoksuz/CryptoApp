//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Nail Tunay ÖKSÜZ on 26.11.2021.
//

import SwiftUI

struct XMarkButton: View {
    @Binding  var showPortfolioView: Bool
    var body: some View {
        Button(action: {
            showPortfolioView.toggle()
        }, label: {
            
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton( showPortfolioView: .constant(true))
        
    }
}
