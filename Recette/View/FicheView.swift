//
//  FicheView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI


//View pour afficher les détails de la recette <-- Mise à jour automatique après modification.
//Utiliser des modal pour la modification
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
        VStack(alignment: .leading){
            Text("Intitulé: \(recette.title)")
            //TODO DANS UN MODAL POUR MODIFICATION
           /* TextField("title", text: $recette.title).onSubmit {
                intent.intentToChange(title: recette.title )
            }*/
            Text("Responsable: \(recette.responsable)")
            Text("Nombre de couverts: \(recette.nbCouverts)")
            
        }.navigationTitle(recette.title).fixedSize()
        
    }
}



