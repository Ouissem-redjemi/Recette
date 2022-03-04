//
//  ListIngredients.swift
//  Recette
//
//  Created by Souhaila kesbi on 23/02/2022.
//
import SwiftUI

struct ListIngredientView : View {
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : IngredientIntent = IngredientIntent ()
  
    
    init(){
        self.listIngredients.getData()
        self.intent.addObserver(viewModel: listIngredients)
    }
    
    @State var searchingFor = ""
    var results : [Ingredient]{
        if searchingFor.isEmpty{
            return listIngredients.listeIngredient
        }
        else{
            return listIngredients.listeIngredient.filter{
                $0.libelle.contains(searchingFor) || $0.allergene.rawValue.contains(searchingFor)
            }
        }
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
            VStack{
               Text("Mes Ingredients").bold().font(.title).foregroundColor(Color.blue)
                
                    HStack{
                        VStack(alignment : .leading){
                            Text("Mes Allergènes").bold().font(.title2)
                        }
                        Button("Ajouter") { showingSheet.toggle() }.foregroundColor(Color.white).cornerRadius(100).background(Color.green).frame(width: 100,alignment: .center )
                            .sheet(isPresented: $showingSheet) { IngredientFormView(listeAllergene: Allergene.allValues)
                            }
                
                        
                }
                    TabView{
                
                            ForEach(listIngredients.listeIngredient , id: \.idIngredient){
                                ingredient in
                                NavigationLink(destination: IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients )){
                                    
                                    IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients)
                                }
                            }
                    }
                    .tabViewStyle((PageTabViewStyle()))
                    
            }    .navigationBarHidden(true)
           
        }
       
        
        /* VStack (){
            NavigationView{
                List {
                    ForEach(listIngredients.listeIngredient.listIngredient , id: \.idIngredient){
                        ingredient in
                        NavigationLink(destination: IngredientView(ingredient: IngredientViewModel(from: ingredient), listeingredient: listIngredients )){
                            VStack(alignment: .leading){
                                Group{
                                    Text(ingredient.libelle).bold()
                                }
                            }
                        }
                    }
                    .onDelete{ indexSet in
                        listIngredients.listeIngredient.listIngredient.remove(atOffsets: indexSet)
                    }.onMove{ indexSet, index in
                        listIngredients.listeIngredient.listIngredient.move(fromOffsets: indexSet, toOffset: index)
                    }.navigationTitle("Mes Ingredients")
                        .searchable(
                            text: $searchingFor,
                            placement: .navigationBarDrawer(displayMode : .always),
                            prompt : "Chercher un ingredient"
                        
                        )
                }
            }
        EditButton()
        }*/
    }
}

/*struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {/*
        let ing = Ingredient(idIngredient: "12", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        let ing2 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: "String"), categorie: CategorieIngredient.fruit, code: 2, libelle: "second Ingredient", prix_unitaire: 1, unite: "")
        let ing3 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "third Ingredient", prix_unitaire: 1, unite: "")
        ListIngredientView(listIngredient : ListeIngredientViewModel(from: ListIngredient(listIngredient: [ing, ing2, ing3] )))*/
        ListIngredientView()
    }
}*/
