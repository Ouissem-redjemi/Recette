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

    
    @State var ingredient = IngredientViewModel(from: Ingredient(id: "String", allergene: Allergene.arachide, categorie: CategorieIngredient.cremerie, code: "String", libelle: "test", prix_unitaire: 12, unite: "kg"))


    
    var  listIngredient = ListeIngredientViewModel()
    var intent : StockIntent
 
    var tabIngredient : [Ingredient] = [Ingredient(id: "1", allergene: Allergene.arachide, categorie: CategorieIngredient.cremerie, code: "String", libelle: "test", prix_unitaire: 12, unite: "kg"),Ingredient(id: "2", allergene: Allergene.arachide, categorie: CategorieIngredient.cremerie, code: "String", libelle: "test", prix_unitaire: 12, unite: "kg"),Ingredient(id: "3", allergene: Allergene.arachide, categorie: CategorieIngredient.cremerie, code: "String", libelle: "test", prix_unitaire: 12, unite: "kg"),Ingredient(id: "4", allergene: Allergene.arachide, categorie: CategorieIngredient.cremerie, code: "String", libelle: "test", prix_unitaire: 12, unite: "kg")]
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()



    init(listStock :ListStockViewModel, stock : StockViewModel, ingredient : IngredientViewModel){

        listIngredient.getData()
   
        self.listStock = listStock
        self.stock = stock
        self.intent = StockIntent()
        self.intent.addObserver(viewModel: stock)
        self.intent.addObserver(viewModel: listStock)
   

        self.ingredient = ingredient
     
    }
    

  
    var body: some View {
        NavigationView{
            Form{
               
                Section(header: Text("Ingredient")){
                    
                 /*   Picker("Ingredient", selection: $stock.ingredient_stock.libelle ) {
                        ForEach(tabIngredient, id:\.self){
                            Text($0.libelle)
                            
                          
                      }
                    }.pickerStyle(.menu)*/
                    
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
                    Button(action : {
                        
                        //print(listIngredient.listeIngredient)
                        print(listIngredient.getList())
                        print(ingredient.ingredient.libelle)

                        print(tabIngredient)
                        
                    
                    }){
                        
                        Image( systemName: "xmark").foregroundColor(.red)
                    }
                }
                
                ToolbarItem{
                    Button(action : {
                        stock.addData(ingredient_stock: self.stock.ingredient_stock, quantite: self.stock.quantite)
                        self.mode.wrappedValue.dismiss()
                        print("ajout du stock  réussie")
                    }){
                        
                        Image( systemName: "checkmark").foregroundColor(.purple)
                    }.disabled(stock.quantite.description.isEmpty)
                }
            })
            
            .navigationTitle("Nouveau Stock")
            .navigationBarTitleDisplayMode(.inline).font(.body)
        }
    }
}

/*struct StockFormView_Previews: PreviewProvider {
    static var previews: some View {
 
        StockFormView(listStock : ListStockViewModel(), stock : StockViewModel(from: Stock(id: "")),  ingredient: IngredientViewModel(from: Ingredient(id: "9aUzoaXP3yZxIQfjmuCx")))
        
    }
}*/
