//
//  CategorieRecette.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
enum CategorieRecette : String , CaseIterable{
    case entree = "Entrée"
    case plat = "Plat Principal"
    case dessert = "Dessert"
    case accompagnement = "Accompagnement"
    
    static let allValues : [CategorieRecette] = [entree,plat,dessert,accompagnement]
}
