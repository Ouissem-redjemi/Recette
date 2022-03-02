//
//  StockFormView.swift
//  Recette
//
//  Created by Souhaila kesbi on 28/02/2022.
//


import SwiftUI

struct StockFormView: View {
    
    @Environment(\.presentationMode) private var mode
    @ObservedObject var stock : StockViewModel
    @ObservedObject var listStock : ListStockViewModel

    let  listIngredient = ListeIngredientViewModel()
    var intent : StockIntent
 
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()



    init(listStock :ListStockViewModel, stock : StockViewModel){
        self.listStock = listStock
        self.stock = stock
        self.intent = StockIntent()
        self.intent.addObserver(viewModel: stock)
        self.intent.addObserver(viewModel: listStock)
    }
    

  
    var body: some View {
        NavigationView{
            Form{
               
                Section(header: Text("Ingredient")){
                    Picker("Ingredient", selection: $stock.ingredient_stock) {
                        ForEach(listIngredient.listeIngredient){
                            ingredient in
                            Text(ingredient.libelle)
                      }
                    }.pickerStyle(.menu)
                    
                }
                
                Section(header : Text("Quantité")){
                    TextField("Quantité", value: $stock.quantite, formatter : formatter)
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
 
        StockFormView(listStock : ListStockViewModel(), stock : StockViewModel(from: Stock(id: "")))
        
    }
}
