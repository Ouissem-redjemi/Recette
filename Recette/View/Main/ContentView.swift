//
//  ContentView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink ( destination: ListIngredientView(listIngredient: ListeIngredientViewModel(from: ListIngredient()))){
                    VStack{
                        Text("Liste des ingredients disponibles ")
                            .padding()
                    }
                }
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
