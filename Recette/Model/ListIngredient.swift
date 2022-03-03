//
//  ListIngredient.swift
//  Recette
//
//  Created by Souhaila kesbi on 23/02/2022.
//
import Foundation
struct ListIngredient{
    
    var listIngredient = [Ingredient] ()
    
    func recupererElement(i : Int )-> Ingredient{
        self.listIngredient[i]
    }
    
    mutating func addIngredient(ingredient : Ingredient){
        self.listIngredient.append(ingredient)
    }
}
