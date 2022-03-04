//
//  ListStock.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//

import SwiftUI

struct ListStockView: View {
    @ObservedObject var listStock = ListStockViewModel()
    var intent : StockIntent = StockIntent()
    
    init(){
        self.listStock.getData()
        self.intent.addObserver(viewModel: listStock)

    }
    
    @State var searchingFor = ""
    var results : [Stock]{
        if searchingFor.isEmpty{
            return listStock.listStock
        }
        else{
            return listStock.listStock.filter{
                $0.ingredient_stock.libelle.contains(searchingFor) || $0.ingredient_stock.allergene.rawValue.contains(searchingFor)
            }
        }
    }
    
    @State private var showingSheet = false
    var body: some View {
        VStack(){
            HStack{
                
                Button("Ajouter") { showingSheet.toggle() }.foregroundColor(Color.white).cornerRadius(100).background(Color.green).frame(width: 100,alignment: .center )

                    .sheet(isPresented: $showingSheet) { StockFormView(listStock: ListStockViewModel(), stock: StockViewModel(from: Stock(id: "")),ingredient : IngredientViewModel(from: Ingredient(id: "9aUzoaXP3yZxIQfjmuCx")))
                    }
        
                
        }
            NavigationView{
                List {
                    ForEach(listStock.listStock , id: \.id){
                        stock in
                        NavigationLink(destination: StockView(stock: StockViewModel(from: stock), listeStock: listStock )){
                            VStack(alignment: .leading){
                                Group{
                                    Text(stock.ingredient_stock.libelle).fontWeight(.bold)
                                    Text("Quantité : \(stock.quantite)").italic().font(.caption).foregroundColor(Color.secondary)
                                    }
                                }
                            }.padding(.vertical,4)
                        }
                    
                    }.navigationTitle("Mon Stock")
                    .onAppear(){
                        self.listStock.fetchData()
                        print("Liste stock mis a jour ")
                    }
                        .searchable(
                            text: $searchingFor,
                            placement: .navigationBarDrawer(displayMode : .always),
                            prompt : "Chercher un ingredient dans le stock"
                        
                        )
            }
        }
    }
}

/*struct ListStockView_Previews: PreviewProvider {
    static var previews: some View {
   
        ListStockView()
    }
}*/
