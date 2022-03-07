//
//  IngredientIntent.swift
//  Recette
//
//  Created by Souhaila kesbi on 22/02/2022.
//

import Foundation
import Combine

enum IngredientIntentState : CustomStringConvertible,Equatable{
 
    case ready
    case libelleChanging(String)
    case allergeneChanging(Allergene)
    case categorieChanging(CategorieIngredient)
    case codeChanging(String)
    case prixUnitaireChanging(Double)
    case uniteChanging(String)
    case quantiteChanging(Double)
    case listUpdated


    var description: String{
       switch self{
        case .ready: return "state: .ready"
        case .libelleChanging(let libelle): return "state: .libelleChanging(\(libelle))"
        case .allergeneChanging(let allergene): return "state: .allergeneChanging(\(allergene))"
        case .categorieChanging(let categorie): return "state: .categorieChanging(\(categorie))"
        case .codeChanging(let code): return "state: .codeChanging(\(code))"
        case .prixUnitaireChanging(let prix_unitaire): return "state: .prixUnitaireChanging(\(prix_unitaire))"
       case .uniteChanging(let unite): return "state: .uniteChanging(\(unite))"
       case .quantiteChanging(let quantite): return "state: .quantiteChanging(\(quantite))"
        case .listUpdated: return  "state: .listUpdated"
       }
    }
}

struct IngredientIntent{
 
   private var state = PassthroughSubject<IngredientIntentState,Never>()
   
  
    //----------------add Observer  ------------------------------
    
   func addObserver(viewModel: IngredientViewModel){
      self.state.subscribe(viewModel)
   }
   func addObserver(viewModel: ListeIngredientViewModel){
       self.state.subscribe(viewModel)
    }
   
    
    //----------------Intent to change ------------------------------
    
   func intentToChange(libelle: String){
      self.state.send(.libelleChanging(libelle))
       self.state.send(.listUpdated)
   }
    
    func intentToChange(allergene: Allergene){
        self.state.send(.allergeneChanging(allergene))
        self.state.send(.listUpdated)
    }
   
    func intentToChange(categorie: CategorieIngredient){
        self.state.send(.categorieChanging(categorie))
        self.state.send(.listUpdated)
    }
    
    func intentToChange(code: String){
        self.state.send(.codeChanging(code))
        self.state.send(.listUpdated)
    }
    
    func intentToChange(prix_unitaire: Double){
        self.state.send(.prixUnitaireChanging(prix_unitaire))
        self.state.send(.listUpdated)
    }
  
    func intentToChange(unite: String){
        self.state.send(.uniteChanging(unite))
        self.state.send(.listUpdated)
    }
    
    func intentToChange(quantite: Double){
        self.state.send(.quantiteChanging(quantite))
        self.state.send(.listUpdated)
    }
    
  
}
