//
//  CategorieView.swift
//  Recette
//
//  Created by Souhaila kesbi on 02/03/2022.
//

import SwiftUI

struct CategorieView: View {
    var listIngredient : [Ingredient]
    var body: some View {
        NavigationView{
            List{
                ForEach(CategorieIngredient.allCases){ categorie in
                    NavigationLink{
                        CategorieDetailView(categorie: categorie , listIngredient: listIngredient)
                    } label:{
                        Text(categorie.rawValue)
                    }
                    
                 
                }
            }.navigationTitle("Catégories")
        }.navigationViewStyle(.stack)
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        let ing : Ingredient = Ingredient(idIngredient: "String", allergene: Allergene.soja, categorie: CategorieIngredient.legume, code: "1", libelle: "mon ingr", prix_unitaire: 2, unite: "kg")
        let ing2 : Ingredient = Ingredient(idIngredient: "String", allergene: Allergene.celeri, categorie: CategorieIngredient.legume, code: "1", libelle: "mon ingr", prix_unitaire: 2, unite: "kg")
        let ing3 : Ingredient = Ingredient(idIngredient: "String", allergene: Allergene.arachide, categorie: CategorieIngredient.epice, code: "1", libelle: "mon ingr", prix_unitaire: 2, unite: "kg")
        CategorieView(listIngredient: [ing, ing2, ing3])
    }
}
