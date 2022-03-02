
//
//  CategorieIngredient.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import Foundation
enum CategorieIngredient : String , CaseIterable, Identifiable {

    
    case fruit = "Fruit"
    case legume = "Legume"
    case epice = "Epicerie"
    case viande_volaille = "Viandes/Volailles"
    case poisson_crustace = "Poisson/Crustacés"
    case cremerie = "Crémerie"
    case fruit_legume = "Fruit/Legume"
    case autre = "Autre"
    

    var id: String { self.rawValue }
}
