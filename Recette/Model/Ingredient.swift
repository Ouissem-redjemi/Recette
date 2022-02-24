//
//  Ingredient.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import Foundation

class Ingredient{
    public var delegate : IngredientDelegate?
    
    public var idIngredient : String{
        didSet{
            self.delegate?.change(idIngredient: self.idIngredient)
        }
    }
    public var allergene : Allergene{
        didSet{
            self.delegate?.change(allergene: self.allergene)
        }
    }
    public var categorie : CategorieIngredient{
        didSet{
            self.delegate?.change(categorie: self.categorie)
        }
    }
    public var code : Int{
        didSet{
            self.delegate?.change(code: self.code)
        }
    }
    
    public var libelle : String{
        didSet{
            self.delegate?.change(libelle: self.libelle)
        }
    }
    
    public var prix_unitaire : Double{
        didSet{
            self.delegate?.change(prix_unitaire: self.prix_unitaire)
        }
    }
    public var unite : String{
        didSet{
            self.delegate?.change(unite: self.unite)
        }
    }
    
    
    init(idIngredient : String , allergene : Allergene, categorie : CategorieIngredient, code : Int , libelle : String , prix_unitaire : Double , unite : String ){
        self.allergene = allergene
        self.categorie = categorie
        self.code  = code
        self.libelle = libelle
        self.prix_unitaire = prix_unitaire
        self.unite = unite
        self.idIngredient = idIngredient
    }
}

