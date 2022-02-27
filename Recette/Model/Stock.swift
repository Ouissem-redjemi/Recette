//
//  Stock.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation
class Stock{
    public var idStock : String
    public var ingredient_stock : Ingredient
    public var quantite : Double
    public var delegate : StockDelegate?
    init(idStock : String , ingredient_stock : Ingredient, quantite : Double){
        self.ingredient_stock = ingredient_stock
        self.quantite = quantite
        self.idStock = idStock
    }
    
}
