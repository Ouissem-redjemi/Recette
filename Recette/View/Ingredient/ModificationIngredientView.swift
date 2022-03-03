//
//  ModificationIngredientView.swift
//  Recette
//
//  Created by Souhaila kesbi on 03/03/2022.
//

import SwiftUI


import SwiftUI

struct ModificationIngredientView: View {
    @Environment(\.presentationMode) private var mode
    @ObservedObject var ingredient : IngredientViewModel
    @ObservedObject var listIngredient : ListeIngredientViewModel


    let listeAllergene  =  Allergene.allValues

    let categories = CategorieIngredient.allValues
    var intent : IngredientIntent
    

    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()


    init(ingredient : IngredientViewModel , listIngredient: ListeIngredientViewModel ){
 
        self.ingredient = ingredient
        self.listIngredient = listIngredient
        self.intent = IngredientIntent()
        self.intent.addObserver(viewModel: ingredient)
        self.intent.addObserver(viewModel: listIngredient)
    }
  
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Appelation de l'ingredient")){
                    TextField("Libelle de l'ingrédient ", text : $ingredient.libelle)
                    TextField("Code de l'ingrédient ", text : $ingredient.code)
                }
                Section(header: Text("Categorie et Allergene")){
                    Picker("Catégorie", selection: $ingredient.categorie) {
                        ForEach(categories,id:\.self) {
                        Text($0.rawValue)
                      }
                    }.pickerStyle(.menu)
                    Picker("Allergene", selection: $ingredient.allergene) {
                        ForEach(listeAllergene, id: \.self) {
                            Text($0.rawValue)
                      }
                    }.pickerStyle(.menu)
                }
                
                Section(header : Text("Unité")){
                    TextField("Unité", text: $ingredient.unite)
                }
                Section(header : Text("Prix Unitaire")){
                    TextField("Prix Unitaire", value: $ingredient.prix_unitaire, formatter : formatter)
                }
               
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                        print("Annuler l'ajout de l'ingredient")
                    }){
                        Image(systemName: "xmark").foregroundColor(.purple)
                    }

                }
                
                ToolbarItem{
                    Button(action:{
                        self.ingredient.UpdateData(ingredient: ingredient)
      
                        self.mode.wrappedValue.dismiss()
                        print("Modification de l'ingredient dans la base de données ")
                    } ){
                        Image(systemName: "checkmark").foregroundColor(.purple)
                    
                    }
                }
            })
            
            .navigationTitle("Modification")
            .navigationBarTitleDisplayMode(.inline)
   
        }.navigationViewStyle(.stack)
    }
}

