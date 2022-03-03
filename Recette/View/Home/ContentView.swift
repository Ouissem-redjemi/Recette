//
//  ContentView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView{/*
            NavigationLink ( destination: HomeView()){
            VStack{
                Text("Liste des recettes disponibles ")
                    .padding()
            }
            }*/
            
            NavigationLink ( destination: ListIngredientView()){
            VStack{
                Text("Liste des ingredient disponibles ")
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
