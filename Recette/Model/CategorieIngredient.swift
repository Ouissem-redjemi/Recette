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
    case epice = "Epice"

    var id: String { self.rawValue }
}
