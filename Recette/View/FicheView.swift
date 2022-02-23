//
//  FicheView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct FicheView: View {
    @ObservedObject var recette : FicheViewModel
    @ObservedObject var listeRecette: ListeFicheViewModel
    var intent : FicheIntent
    init(recette : FicheViewModel, listeRecette : ListeFicheViewModel){
        self.recette = recette
        self.listeRecette = listeRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listeRecette)
        
    }
    var body: some View{
        VStack(){
            NavigationLink(destination: FicheView(recette: self.recette, listeRecette: self.listeRecette)){
                Image(systemName: "tv.music.note.fill")
                .imageScale(.large)
            }
                
            Text("Intitulé:")
            TextField("title", text: $recette.title).onSubmit {
                intent.intentToChange(title: recette.title )
            }
            //Text("Nom de l'auteur: \($track.artistName)")
            //Text("Nom de l'album: \(track.collectionName)")
            Text("Responsable: \(recette.responsable)")
            Text("Nombre de couverts: \(recette.nbCouverts)")
            
        }.navigationTitle(recette.title)
        
    }
}



