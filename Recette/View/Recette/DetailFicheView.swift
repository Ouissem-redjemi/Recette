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
    @Environment(\.presentationMode) private var mode
    @State var isModifyViewPresented = false
    @State var isRemovePresented = false
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
        NavigationView{
            ScrollView(.vertical, showsIndicators: true){
                AsyncImage(url: URL(string: "https://images.vexels.com/media/users/3/231368/isolated/preview/03f100290e37d6f7f5de39d9af357afc-plano-de-utensilios-de-cozinha.png")){
                    image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        //Dans une grid, le Responsable, le nombre de couvert et la durée totale de la recette
                        VStack(alignment: .leading, spacing: 20){
                            Text("Ingrédients :")
                                .font(.headline)
                            Text("La liste des ingrédients ici")
                        }
                        VStack(alignment: .leading, spacing: 20){
                            Text("Étapes :")
                                .font(.headline)
                            Text("La liste des étapes ici")
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity,  alignment: .leading)
                
                }
                .padding(.horizontal)}
                .ignoresSafeArea(.container, edges: .top)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action :{
                            self.isRemovePresented.toggle()
                        }){
                            Image(systemName: "clear")
                                .foregroundColor(.purple)
                                .font(.title)
                        }.actionSheet(isPresented: $isRemovePresented){
                            ActionSheet(title: Text("Are you sure ?"),
                                        buttons: [
                                            .destructive(Text("Supprimer la recette"), action: {
                                                self.recette.removeData()
                                                self.mode.wrappedValue.dismiss()
                                                print("Suppression réussie")
                                            }),
                                                .cancel()
                                        ])
                        }
                    }
                    ToolbarItem(){
                        Button(action :{
                            self.isModifyViewPresented = true
                            print("Modification réussie")
                        }){
                            Image(systemName: "pencil.circle")
                                .foregroundColor(.purple)
                                .font(.title)
                        }.sheet(isPresented: $isModifyViewPresented, content: {
                            ModificationFicheView(recette: self.recette, listRecette: self.listeRecette)})
                    }
                }).navigationBarTitleDisplayMode(.inline)
                
        }.navigationViewStyle(.stack)
            
        }
  
}


struct DetailFiche_Previews: PreviewProvider {
    static var previews: some View {
        DetailFicheView(recette: FicheViewModel(from: Fiche(id: "FObL0vgRlp2NDdKzmVsp" )) , listeRecette: ListeFicheViewModel())
    }
}



