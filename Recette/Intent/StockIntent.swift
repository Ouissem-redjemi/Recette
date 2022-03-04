//
//  File.swift
//  Recette
//
//  Created by Souhaila kesbi on 27/02/2022.
//
import Foundation
import Combine

enum StockIntentState : CustomStringConvertible, Equatable{
    case ready
    case ingredient_stockChanging(Ingredient)
    case quantite_stockChanging(Double)
    case listUpdated
    
    var description : String {
        switch self{
        case .ready : return "State : .ready"
        case .ingredient_stockChanging(let ingredient_stock): return "state : .ingredient_stockChanging(\(ingredient_stock)"
        case .quantite_stockChanging( let quantite) : return "state: .quantite_stockChanging(\(quantite))"
        case .listUpdated: return  "state: .listUpdated"
        }
    }
}

struct StockIntent{
    private var state = PassthroughSubject<StockIntentState, Never>()
    
    func addObserver(viewModel: StockViewModel){
       self.state.subscribe(viewModel)
    }
  
    func addObserver(viewModel: ListStockViewModel){
        self.state.subscribe(viewModel)
     }
    func intentToChange(ingredient_stock: Ingredient){
       self.state.send(.ingredient_stockChanging(ingredient_stock))
        self.state.send(.listUpdated)
    }
     
     func intentToChange(quantite: Double ){
         self.state.send(.quantite_stockChanging(quantite))
         self.state.send(.listUpdated)
     }
}
