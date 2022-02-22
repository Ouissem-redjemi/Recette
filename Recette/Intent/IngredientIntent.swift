//
//  IngredientIntent.swift
//  Recette
//
//  Created by Souhaila kesbi on 22/02/2022.
//

import Foundation
import Combine

enum IngredientIntentState : CustomStringConvertible, Equatable{
    case ready
    case libelleChanging(String)
    case allergeneChanging(Allergene)
    case matSpeChanging(String)
    case matDressChanging(String)
    case couvertChanging(Int)
    case listUpdated


var description: String{
   switch self{
    case .ready: return "state: .ready"
    case .libelleChanging(let libelle): return "state: .libelleChanging(\(libelle))"
    case .allergeneChanging(let allergene): return "state: .allergeneChanging(\(allergene))"
   case .matSpeChanging(let materiel): return "state: .matSpeChanging(\(materiel))"
   case .couvertChanging(let couvert): return "state: .couvertChanging(\(couvert))"
   case .matDressChanging(let matDress): return "state: .matDressChanging(\(matDress))"
    case .listUpdated: return  "state: .listUpdated"
   }
}
}

struct IngredientIntent{
 
   private var state = PassthroughSubject<IngredientIntentState,Never>()
   
  
   
   func addObserver(viewModel: FicheViewModel){
      self.state.subscribe(viewModel)
   }
    func addObserver(viewModel: ListeFicheViewModel){
       self.state.subscribe(viewModel)
    }
   
   func intentToChange(title: String){
      self.state.send(.titleChanging(title))
       self.state.send(.listUpdated)
   }
    func intentToChange(responsable: String){
        self.state.send(.responsableChanging(responsable))
        self.state.send(.listUpdated)
    }
    
    
  
}
