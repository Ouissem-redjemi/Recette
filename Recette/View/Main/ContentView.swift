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
            NavigationLink ( destination: ListFicheView(listFiche: ListeFicheViewModel(from: ListeFiche()))){
            VStack{
                Text("Liste des recettes disponibles ")
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
