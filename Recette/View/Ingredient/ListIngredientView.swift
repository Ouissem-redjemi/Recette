//
//  ListIngredients.swift
//  Recette
//
//  Created by Souhaila kesbi on 23/02/2022.
//
import SwiftUI

struct ListIngredientView : View {
    @ObservedObject var listIngredients : ListeIngredientViewModel
    var intent : IngredientIntent
  
    
    init(listIngredient : ListeIngredientViewModel){
        self.listIngredients = listIngredient
        listIngredient.getData()
        self.intent = IngredientIntent()
        self.intent.addObserver(viewModel: listIngredient)
    }
    
    @State var searchingFor = ""
    var results : [Ingredient]{
        if searchingFor.isEmpty{
            return listIngredients.listeIngredient.listIngredient
        }
        else{
            return listIngredients.listeIngredient.listIngredient.filter{
                $0.libelle.contains(searchingFor) || $0.allergene.libelle.contains(searchingFor)
            }
        }
    }
    var body: some View {
        NavigationView{
            VStack{
               Text("Mes Ingredients").bold().font(.title).foregroundColor(Color.blue)
                
                    TabView{
                
                            ForEach(listIngredients.listeIngredient.listIngredient , id: \.idIngredient){
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

struct ListIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        let ing = Ingredient(idIngredient: "12", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "First Ingredient", prix_unitaire: 1, unite: "")
        let ing2 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: "String"), categorie: CategorieIngredient.fruit, code: 2, libelle: "second Ingredient", prix_unitaire: 1, unite: "")
        let ing3 = Ingredient(idIngredient: "", allergene: Allergene(libelle: "Premier", idAllergene: ""), categorie: CategorieIngredient.fruit, code: 2, libelle: "third Ingredient", prix_unitaire: 1, unite: "")
        ListIngredientView(listIngredient : ListeIngredientViewModel(from: ListIngredient(listIngredient: [ing, ing2, ing3] )))
    }
}
