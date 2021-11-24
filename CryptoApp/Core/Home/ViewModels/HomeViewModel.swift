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
    }
}
