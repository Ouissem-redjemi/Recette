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
        self.intent = IngredientIntent()
        self.intent.addObserver(viewModel: listIngredient)
        
    }
    var body: some View {
        VStack (){
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
                }
            }
        EditButton()
        }
    }
}
