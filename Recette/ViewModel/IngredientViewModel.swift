//
//  IngredientViewModel.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//


import Foundation

protocol IngredientDelegate {
    func change(allergene : Allergene)
    func change(categorie : CategorieIngredient)
    func change(code : Int)
    func change(libelle : String)
    func change(prix_unitaire : Double)
    func change(unite : String)
}

class IngredientViewModel : IngredientDelegate{
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
    
    var delegate : IngredientDelegate?
    typealias Input = IngredientIntentState
    
    typealias Failure = Never
    
    var ingredient : Ingredient
    
    @Published var allergene : Allergene
    @Published var categorie : CategorieIngredient?
    @Published var code : Int
    @Published var libelle : String
    @Published var prix_unitaire : Double
    @Published var unite : String
    
    init(from ingredient : Ingredient){
        self.ingredient = ingredient
        self.categorie = ingredient.categorie
        self.libelle = ingredient.libelle
        self.unite = ingredient.unite
        self.prix_unitaire = ingredient.prix_unitaire
        self.code = ingredient.code
        self.allergene = ingredient.allergene
        self.ingredient.delegate = self
    }
}

