//
//  Stock.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
class Stock{
    
    public var ingredient_stock : Ingredient
    public var quantite : Double
    public var delegate : StockDelegate?
    init(ingredient_stock : Ingredient, quantite : Double){
        self.ingredient_stock = ingredient_stock
        self.quantite = quantite
    }
    
}
