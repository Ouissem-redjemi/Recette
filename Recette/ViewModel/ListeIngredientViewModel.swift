//
//  ListeIngredientViewModel.swift
//  Recette
//
//  Created by Souhaila kesbi on 22/02/2022.
//

import Foundation
import Combine


class ListeIngredientViewModel: ObservableObject, Subscriber {
    typealias Input = IngredientIntentState
    
    typealias Failure = Never
    
    var listeIngredient : ListIngredient
    
    init(from listeIngredient : ListIngredient){
        self.listeIngredient = listeIngredient
    }
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }
    
    func receive(_ input: IngredientIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input{
           case .ready:
              break
           case .libelleChanging(_):
            break
        case .allergeneChanging(_):
            break
        case .categorieChanging(_):
            break
        case .codeChanging(_):
            break
        case .prixUnitaireChanging(_):
            break
        case .uniteChanging(_):
            break
         case .listUpdated:
            self.objectWillChange.send()
        }
        return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
}
