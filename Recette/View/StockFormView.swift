//
//  StockFormView.swift
//  Recette
//
//  Created by Souhaila kesbi on 28/02/2022.
//


import SwiftUI

struct StockFormView: View {
    
    @State private var libelle : String = ""
    // @State private var allergene : Allergene

     var listIngredient : ListIngredient = ListIngredient(listIngredient: [])

    @State private var quantite : Double = 2

    @State var ingredient  : Ingredient? = nil

 
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()



    init(listIngredient :ListIngredient ){
        self.listIngredient = listIngredient
       
    }
    

  
    var body: some View {
        NavigationView{
            Form{
               
                Section(header: Text("Ingredient")){
                    Picker("Ingredient", selection: $ingredient) {
                        ForEach(self.listIngredient.listIngredient ){ ingredient in
                            Text(ingredient.libelle)
                      }
                    }.pickerStyle(.menu)
                    
                }
                
                Section(header : Text("Quantité")){
                    TextField("Quantité", value: $quantite, formatter : formatter)
                }
                
                Section(header : Text("Prix Total")){
                    // Text("\(quantite*ingredient!.prix_unitaire )")
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
            
            .navigationTitle("Nouveau Stock")
            .navigationBarTitleDisplayMode(.inline).font(.body)
        }
    }
}

struct StockFormView_Previews: PreviewProvider {
    static var previews: some View {
        let ing = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        let ing2 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        
        let ing3 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        
        StockFormView(listIngredient: ListIngredient(listIngredient: [ing, ing2,ing3]))
        
    }
}
