//
//  ListStock.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//

import SwiftUI

struct ListStockView: View {
    @ObservedObject var listStock : ListStockViewModel
    var intent : StockIntent
    
    init(listStock : ListStockViewModel){
        self.listStock = listStock
        listStock.getData()
        self.intent = StockIntent()
        self.intent.addObserver(viewModel: listStock)
    }
    
    @State var searchingFor = ""
    var results : [Stock]{
        if searchingFor.isEmpty{
            return listStock.listStock.listStock
        }
        else{
            return listStock.listStock.listStock.filter{
                $0.ingredient_stock.libelle.contains(searchingFor) || $0.ingredient_stock.allergene.libelle.contains(searchingFor)
            }
        }
    }
    var body: some View {
        VStack(){
            NavigationView{
                List {
                    ForEach(listStock.listStock.listStock , id: \.idStock){
                        stock in
                        NavigationLink(destination: StockView(stock: StockViewModel(from: stock), listeStock: listStock )){
                            VStack(alignment: .leading){
                                Group{
                                    Text(stock.ingredient_stock.libelle).bold()
                                    Text("Quantité : \(stock.quantite))").italic()
                                }
                            }
                        }
                    }
                    .onDelete{ indexSet in
                        listStock.listStock.listStock.remove(atOffsets: indexSet)
                    }.onMove{ indexSet, index in
                        listStock.listStock.listStock.move(fromOffsets: indexSet, toOffset: index)
                    }.navigationTitle("Mon Stock")
                        .searchable(
                            text: $searchingFor,
                            placement: .navigationBarDrawer(displayMode : .always),
                            prompt : "Chercher un ingredient dans le stock"
                        
                        )
                }
            }
        EditButton()
        }
    }
}

struct ListStockView_Previews: PreviewProvider {
    static var previews: some View {
        let ing = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        
        let stock = Stock(idStock: "First", ingredient_stock: ing, quantite: 2)
        
        let ing2 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        let  stock2 = Stock(idStock: "First", ingredient_stock: ing2, quantite: 2)
        
            
        ListStockView(listStock: ListStockViewModel(from: ListStock(listStock: [stock,stock2])))
    }
}
