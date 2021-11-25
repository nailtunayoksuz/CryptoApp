//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Nail Tunay ÖKSÜZ on 24.11.2021.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject{
    @Published var allcoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchtext: String = ""
    
    
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allcoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $searchtext
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allcoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        let filteredCoins = coins.filter { (coin) in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
        return filteredCoins
    }
}

