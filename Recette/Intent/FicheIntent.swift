//
//  FicheIntent.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
import Combine

enum FicheIntentState : CustomStringConvertible, Equatable{
    case ready
    case titleChanging(String)
    case responsableChanging(String)
    case matSpeChanging(String)
    case matDressChanging(String)
    case couvertChanging(Int)
    case listUpdated


    var description: String{
       switch self{
        case .ready: return "state: .ready"
        case .titleChanging(let title): return "state: .titleChanging(\(title))"
        case .responsableChanging(let name): return "state: .nameChanging(\(name))"
       case .matSpeChanging(let materiel): return "state: .matSpeChanging(\(materiel))"
       case .couvertChanging(let couvert): return "state: .couvertChanging(\(couvert))"
       case .matDressChanging(let matDress): return "state: .matDressChanging(\(matDress))"
        case .listUpdated: return  "state: .listUpdated"
       }
    }
}

struct FicheIntent{
 
   private var state = PassthroughSubject<FicheIntentState,Never>()
   
  
   
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
