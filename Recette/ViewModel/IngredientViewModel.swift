//
//  IngredientViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//


import Foundation
import Combine

protocol IngredientDelegate {
    func change(allergene : Allergene)
    func change(categorie : CategorieIngredient)
    func change(code : Int)
    func change(libelle : String)
    func change(prix_unitaire : Double)
    func change(unite : String)
    func change(idIngredient : String)
}

class IngredientViewModel : IngredientDelegate, ObservableObject, Subscriber{
    
    typealias Input = IngredientIntentState
    
    typealias Failure = Never
    
    
    

    func change(allergene: Allergene) {
        self.allergene = allergene
    }
    
    func change(categorie: CategorieIngredient) {
        self.categorie = categorie
    }
    
    func change(code: Int) {
        self.code = code
    }
    
    func change(libelle: String) {
        self.libelle = libelle
    }
    
    func change(prix_unitaire: Double) {
        self.prix_unitaire = prix_unitaire
    }
    
    func change(unite : String) {
        self.unite = unite
    }
    
    func change(idIngredient : String) {
        self.idIngredient = idIngredient
    }
    
    var delegate : IngredientDelegate?

    
    var ingredient : Ingredient
    
    @Published var allergene : Allergene
    @Published var categorie : CategorieIngredient?
    @Published var code : Int
    @Published var libelle : String
    @Published var prix_unitaire : Double
    @Published var unite : String
    @Published var idIngredient : String
    
    
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: IngredientIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
       switch input{
          case .ready:
             break
          case .libelleChanging(let libelle):
           self.ingredient.libelle = libelle
       case .allergeneChanging(let allergene):
           self.ingredient.allergene = allergene
       case .categorieChanging(let categorie):
           self.ingredient.categorie = categorie
       case .codeChanging(let code):
           self.ingredient.code = code
       case .prixUnitaireChanging(let prix_unitaire):
           self.ingredient.prix_unitaire = prix_unitaire
       case .uniteChanging(let unite):
           self.ingredient.unite = unite
           
        case .listUpdated:
           break
           
          
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    
    init(from ingredient : Ingredient){
        self.ingredient = ingredient
        self.categorie = ingredient.categorie
        self.libelle = ingredient.libelle
        self.unite = ingredient.unite
        self.prix_unitaire = ingredient.prix_unitaire
        self.code = ingredient.code
        self.allergene = ingredient.allergene
        self.idIngredient = ingredient.idIngredient
        self.ingredient.delegate = self
    }
}

