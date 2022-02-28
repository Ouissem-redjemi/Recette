//
//  StockView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//
import SwiftUI

struct StockView : View {
    @ObservedObject var stock : StockViewModel
    @ObservedObject var listeStock: ListStockViewModel
    var intent : StockIntent
    
    init(stock : StockViewModel, listeStock : ListStockViewModel){
        self.stock = stock
        self.listeStock = listeStock
        self.intent = StockIntent()
        self.intent.addObserver(viewModel: stock)
        self.intent.addObserver(viewModel: listeStock)
    }
    
    var body: some View{
        let cols=[GridItem(.fixed(140), alignment: .leading),GridItem(.flexible(),alignment: .leading)]
        VStack(alignment: .leading){
            Text("Ingredient  ").font(.largeTitle)
    
            Text("Intitulé  : \(stock.ingredient_stock.libelle)")

            Text("allergene  :\(stock.ingredient_stock.allergene.libelle)")
            Text("Catégorie: \(stock.ingredient_stock.categorie.rawValue)")
            Text("Code: \(stock.ingredient_stock.code)")
    
            Text("Prix Unitaire: \(stock.ingredient_stock.prix_unitaire)")
            Text("Unite: \(stock.ingredient_stock.unite)")
            Text("quantité : \(stock.quantite)")
            Spacer()
        }.navigationTitle(stock.ingredient_stock.libelle).fixedSize().padding().border(.cyan)

    }
}
struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        let ing = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        let stock = Stock(idStock: "First", ingredient_stock: ing, quantite: 2)
        StockView(stock: StockViewModel(from: Stock(idStock: "First", ingredient_stock: ing, quantite: 2)), listeStock: ListStockViewModel(from: ListStock(listStock: [stock])))
    }
}
