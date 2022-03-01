//
//  StockViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//


import Foundation
import Combine

protocol StockDelegate{
    func change(ingredient_stock : Ingredient)
    func change(quantite : Double)
}
class StockViewModel: StockDelegate, ObservableObject, Subscriber{
    
    typealias Input = StockIntentState
    
    typealias Failure = Never
    
    
    func change(ingredient_stock: Ingredient) {
        self.ingredient_stock = ingredient_stock
    }
    
    func change(quantite: Double) {
        self.quantite = quantite
    }
    
    @Published var idStock : String
    @Published var ingredient_stock : Ingredient
    @Published var quantite : Double
    
    var stock : Stock
    
    var delegate : StockDelegate?
    
    

    init(from stock : Stock){
        self.stock = stock
        self.quantite = stock.quantite
        self.ingredient_stock = stock.ingredient_stock
        self.idStock = stock.idStock
        self.stock.delegate = self
    }
    
    
    public var  calculCoutTotal : Double {
        return self.quantite * self.ingredient_stock.prix_unitaire
    }
    
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: StockIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
          case  .ingredient_stockChanging(let ingredient_stock):
           self.stock.ingredient_stock = ingredient_stock
        
       case .quantite_stockChanging(let quantite):
           self.stock.quantite = quantite
      
        case .listUpdated:
           break
           
          
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
}
