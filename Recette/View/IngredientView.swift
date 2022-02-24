//
//  IngredientVIew.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import SwiftUI


struct IngredientView: View {
    
    @ObservedObject var ingredient : IngredientViewModel
    @ObservedObject var listeingredient: ListeIngredientViewModel
    var intent : IngredientIntent
    
    init(ingredient : IngredientViewModel, listeingredient : ListeIngredientViewModel){
        self.ingredient = ingredient
        self.listeingredient = listeingredient
        self.intent = IngredientIntent()
        self.intent.addObserver(viewModel: ingredient)
        self.intent.addObserver(viewModel: listeingredient)
    }
    
    var body: some View{
        let cols=[GridItem(.fixed(140), alignment: .leading),GridItem(.flexible(),alignment: .leading)]
        VStack(alignment: .leading){
            LazyVGrid(columns: cols, spacing: 5){
                Text("Intitulé: "); Text("\(ingredient.libelle)")
                //TODO DANS UN MODAL POUR MODIFICATION
               /* TextField("title", text: $recette.title).onSubmit {
                    intent.intentToChange(title: recette.title )
                }*/
                Text("allergene: \(ingredient.allergene.libelle)")
                Text("Catégorie: \(ingredient.categorie!.rawValue)")
                Text("Code: \(ingredient.code)")
            
            }
        
            Text("Prix Unitaire: \(ingredient.prix_unitaire)")
            Text("Unite: \(ingredient.unite)")

        }.navigationTitle(ingredient.libelle).fixedSize()
    }
}

