//
//  IngredientFormView.swift
//  Recette
//
//  Created by Souhaila kesbi on 28/02/2022.
//

import SwiftUI

struct IngredientFormView: View {
    
    @State private var libelle : String = ""
    // @State private var allergene : Allergene
    @State private var selectedCategorie : CategorieIngredient = CategorieIngredient.fruit
    var listeAllergene : ListAllergene = ListAllergene(listAllergene: [])
    @State private var code : String  = ""
    @State private var prix_unitaire : Double=0
    @State private var unite : String = ""
    @State private var allergeneSelected  = Allergene(libelle: "crutaces", idAllergene: "lol")

    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()


    init(listeAllergene :ListAllergene ){
        self.listeAllergene = listeAllergene
        self.listeAllergene.addAllergene(allergene:allergeneSelected)
    }
  
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Appelation de l'ingredient")){
                    TextField("Libelle de l'ingrédient ", text : $libelle)
                    TextField("Code de l'ingrédient ", text : $code)
                }
                Section(header: Text("Categorie et Allergene")){
                    Picker("Catégorie", selection: $selectedCategorie) {
                      ForEach(CategorieIngredient.allCases) { categorie in
                        Text(categorie.rawValue)
                      }
                    }.pickerStyle(.menu)
                    Picker("Allergene", selection: $allergeneSelected) {
                        ForEach(self.listeAllergene.listAllergene, id: \.self) { allergene in
                            Text(allergene.libelle)
                      }
                    }.pickerStyle(.menu)
                }
                
                Section(header : Text("Unité")){
                    TextField("Unité", text: $unite)
                }
                Section(header : Text("Prix Unitaire")){
                    TextField("Prix Unitaire", value: $prix_unitaire, formatter : formatter)
                }
               
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        
                    }label : {
                        Label("Cancel", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                    }
                }
                
                ToolbarItem{
                    Button{
                        
                    }label : {
                        Label("Don", systemImage: "checkmark")
                            .labelStyle(.iconOnly)
                    }
                }
            })
            
            .navigationTitle("Nouvel Ingrédient")
            .navigationBarTitleDisplayMode(.inline).font(.body)
        }
    }
}

struct IngredientFormView_Previews: PreviewProvider {
    static var previews: some View {
        var allergene1 : Allergene = Allergene(libelle: "crutaces", idAllergene: "lol")
        var allergene2 : Allergene = Allergene(libelle: "crutaces", idAllergene: "lol")
        IngredientFormView(listeAllergene: ListAllergene(listAllergene: [allergene1,allergene2]))
    }
}