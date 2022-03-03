
//
//  Stock.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import Foundation
import FirebaseFirestoreSwift

class Stock: Identifiable{
    
    @DocumentID var idStock : String?
    public var delegate : StockDelegate?
    
    
    public var ingredient_stock : Ingredient {
        didSet{
            self.delegate?.change(ingredient_stock: self.ingredient_stock)
        }
    }
    public var quantite : Double{
        didSet{
            self.delegate?.change(quantite: self.quantite)
        }
    }

    init(id: String , ingredient_stock : Ingredient = Ingredient(id: "String", allergene: Allergene.arachide, categorie: CategorieIngredient.cremerie, code: "String", libelle: "test", prix_unitaire: 2, unite: "String"), quantite : Double = 0 ){
        self.ingredient_stock = ingredient_stock
        self.quantite = quantite
        self.idStock = id
    }
    
}
