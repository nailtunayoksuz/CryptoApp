//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Nail Tunay ÖKSÜZ on 25.11.2021.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding  var showPortfolioView: Bool
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 0) {
                ScrollView{
                    SearchBarView(searchText: $vm.searchtext)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(showPortfolioView: $showPortfolioView)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarbuttons
                    
                }
            }
        }
        
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showPortfolioView: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
extension PortfolioView{
    private var coinLogoList: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10){
                ForEach(vm.allcoins){coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame( height: 120)
            .padding(.leading )
        }
    }
    
    private func getCurrentValue() -> Double{
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection : some View{
        VStack(spacing: 20){
            HStack{
                Text("Currrent price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amoun holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                
            }
            Divider()
            HStack{
                Text("Current Value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: selectedCoin)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarbuttons: some View{
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("save".uppercased())
            })
                .opacity(
                    (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))
                    ? 1.0 : 0.0
                )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin else {
            return
        }
        
        withAnimation(.easeIn){
            showCheckMark = true
            removeSelectedCoin()
            
            UIApplication.shared.endEditing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        
        vm.searchtext = ""
    }
}
