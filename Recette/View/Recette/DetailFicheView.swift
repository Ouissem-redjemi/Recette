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
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    var intent : FicheIntent
    @State var tabLibelle : [String : Double] = [:]
    init(recette : FicheViewModel, listeRecette : ListeFicheViewModel){
        self.recette = recette
        self.listeRecette = listeRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listeRecette)
        self.listIngredients.getData()
        
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
                        //Text("Description : ")
                        LazyVGrid(columns: [GridItem (.adaptive(minimum: 160), spacing: 15)], spacing: 15){
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.purple)
                                .font(.title)
                            Text("\(recette.responsable)")
                            Image(systemName: "fork.knife.circle.fill")
                                .foregroundColor(.purple)
                                .font(.title)
                            Text("\(recette.nbCouverts)")
                            Image(systemName: "timer")
                                .foregroundColor(.purple)
                                .font(.title)
                            
                            
                        }
                        VStack(alignment: .leading, spacing: 20){
                            Text("Ingrédients :")
                                .font(.headline)
                            
                        }
                        VStack(alignment: .leading, spacing: 20){
                            Text("Étapes :")
                              .font(.headline)
                            ForEach(0..<recette.etapes.count){ i in
                                   ForEach(listeRecette.listeFiches){ fiche in
                                       if recette.etapes[i] == fiche.idFiche{
                                           if fiche.titleStep!.isEmpty{
                                               Text("\(fiche.title)")
                                               
                                           }else{
                                               Text("\(fiche.titleStep!)")
                                                   .bold()
                                               Text("Durée : \(fiche.duree!)")
                                                   .italic()
                                               Text("Ingrédients : ")
                                                   .underline()
                                               Button {
                                                   self.tabLibelle = affichage_Dico(dico: fiche.ingredients!)
                                               } label: {
                                                   Text("Afficher")
                                               }
                                               Text(self.tabLibelle.description)
                                                   /*.onTapGesture {
                                                       print("tapped")
                                                       let libelle = affichage_Dico(dico: fiche.ingredients!)
                                                       print(libelle)
                                                       print("tapped")
                                                   }*/
                                               
                                               
                                               Text("Description : ")
                                                   Text("- \(fiche.description!)")}
                            Divider()
                                           
                                   }
                                   }
                               }
                            
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
    func affichage_Dico(dico : [String:Double]) -> [String : Double]{
        var libelle : [String:Double] = [:]
        //var quantite : Double
        for (cle, valeur) in dico {
            listIngredients.listeIngredient.forEach { Ingredient in
                if cle == Ingredient.idIngredient{
                    libelle[Ingredient.libelle] = valeur
                }
                
            }
        }
        return libelle
    }
        
}



struct DetailFiche_Previews: PreviewProvider {
    static var previews: some View {
        DetailFicheView(recette: FicheViewModel(from: Fiche(id: "" )) , listeRecette: ListeFicheViewModel())
    }
}





