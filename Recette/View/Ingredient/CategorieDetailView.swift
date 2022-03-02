//
//  CategorieDetailView.swift
//  Recette
//
//  Created by Souhaila kesbi on 02/03/2022.
//

import SwiftUI

struct CategorieDetailView: View {
    var categorie : CategorieIngredient
    var listIngredient : [Ingredient]
    var listIngredientFiltrer : [Ingredient] {
        return self.listIngredient.filter{
            $0.categorie.rawValue == categorie.rawValue
        }
    }
    var body: some View {
        TabView{
            ListIngredientView(listIngredient: ListeIngredientViewModel(from: ListIngredient(listIngredient : listIngredientFiltrer)))
        }.navigationTitle(categorie.rawValue)
    }
}

struct CategorieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let ing : Ingredient = Ingredient(idIngredient: "String", allergene: Allergene(libelle: "", idAllergene: "ing"), categorie: CategorieIngredient.legume, code: 1, libelle: "mon gingembre", prix_unitaire: 2, unite: "kg")
        let ing2 : Ingredient = Ingredient(idIngredient: "String", allergene: Allergene(libelle: "", idAllergene: "ing"), categorie: CategorieIngredient.legume, code: 2, libelle: "carotte ", prix_unitaire: 2, unite: "kg")
        let ing3 : Ingredient = Ingredient(idIngredient: "String", allergene: Allergene(libelle: "", idAllergene: "ing"), categorie: CategorieIngredient.epice, code: 3, libelle: "mon poivre", prix_unitaire: 2, unite: "kg")
        CategorieDetailView(categorie: CategorieIngredient.legume, listIngredient: [ing, ing2, ing3])
    }
}