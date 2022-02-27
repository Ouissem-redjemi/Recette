//
//  FicheView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI


//View pour afficher les détails de la recette <-- Mise à jour automatique après modification.
//Utiliser des modal pour la modification
struct DetailFicheView: View {
    
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
        ScrollView{
            AsyncImage(url: URL(string: "https://cdn3.coloritou.com/dessins/coloriage/marmite_2.png")){
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom){
                        Text(recette.title)
                            .font(.headline)
                            .foregroundColor(.purple)
                            .shadow(color: .purple, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
            } placeholder: {
                Image(systemName: "Photo par défaut")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottom){
                        Text(recette.title)
                            .font(.headline)
                            .foregroundColor(.purple)
                            .shadow(color: .purple, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                        .padding()}
            }
            .frame(width: 300)
            
            VStack(spacing: 30){
                
                //Intitulé de la recette
                Text(recette.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                //Description de la recette dans le Vstack (optionnel)
                VStack(alignment: .leading, spacing: 30){
                    Text("Description : ")
                    VStack(alignment: .leading, spacing: 30){
                        Text("Ingrédients :")
                            .font(.headline)
                        Text("La liste des ingrédients ici")
                    }
                    VStack(alignment: .leading, spacing: 30){
                        Text("Étapes :")
                            .font(.headline)
                        Text("La liste des étapes ici")
                    }
                    
                    
                }
                .frame(maxWidth: .infinity,  alignment: .leading)
                //Dans une grid, le Responsable, le nombre de couvert et la durée totale de la recette
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}


struct DetailFiche_Previews: PreviewProvider {
    static var previews: some View {
        DetailFicheView(recette: FicheViewModel(from: Fiche(id: "FObL0vgRlp2NDdKzmVsp" )) , listeRecette: ListeFicheViewModel())
    }
}



