//
//  ListeFicheViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import Combine

class ListeFicheViewModel: ObservableObject, Subscriber {
    typealias Input = FicheIntentState
    
    typealias Failure = Never
    
    var listeFiches : ListeFiche
    
    init(from listeFiches : ListeFiche){
        self.listeFiches = listeFiches
    }
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }
    func receive(_ input: FicheIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
       case .titleChanging(_):
           break
       case .responsableChanging(_):
           break
       case .matSpeChanging(_):
           break
       case .matDressChanging(_):
          break
       case .couvertChanging(_):
           break
        case .listUpdated:
           self.objectWillChange.send()
           
          
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
}
