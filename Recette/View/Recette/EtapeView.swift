//
//  EtapeView.swift
//  Recette
//
//  Created by Dalia Rdjm on 3/3/2022.
//

import SwiftUI

struct EtapeView: View {
    
    @Environment(\.presentationMode) private var mode
    @ObservedObject var recette : FicheViewModel
    @ObservedObject var listRecette : ListeFicheViewModel
    
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()
    
    var intent : FicheIntent
    
    init(recette : FicheViewModel, listRecette : ListeFicheViewModel){
        self.recette = recette
        self.listRecette = listRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listRecette)
        
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Intitulé")){
                    TextField("Intitulée de l'étape", text: $recette.titleStep ?? "")
                }
                Section(header: Text("Durée")){
                    TextField("Durée de l'étape", value: $recette.duree ?? 0, formatter: formatter)
                }
                Section(header: Text("Description")){
                    TextEditor(text: $recette.description ?? "")
                }
        
                Section(header: Text("Ingrédients")){
                   
                }
                
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action :{
                        self.mode.wrappedValue.dismiss()
                        print("Annulation réussie")
                    }){
                        Image(systemName: "xmark")
                            .foregroundColor(.purple)
                    }
                }
                ToolbarItem{
                    Button(action :{
                        
                        //Add step to the listeStep
                        self.recette.addStep()
                        
                        print(self.recette.etapes.description)
                        //Add step to the database
                        self.recette.addDataStep(title: self.recette.titleStep, description: self.recette.description, duree: self.recette.duree)
                        
                        //Close the view after adding data
                        self.mode.wrappedValue.dismiss()
                        print("Ajout de l'étape dans la base de données --- Réussie !")
                        
                    }){
                        Image(systemName: "checkmark")
                            .foregroundColor(.purple)
                    }.disabled(recette.titleStep!.isEmpty)
                        .disabled(recette.duree!.description.isEmpty)
                        .disabled(recette.description!.isEmpty)
                }
            })
            .navigationTitle("Nouvelle recette")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

/*struct EtapeView_Previews: PreviewProvider {
    static var previews: some View {
        EtapeView(recette: FicheViewModel(from: Fiche (id: "")), listRecette: ListeFicheViewModel())
    }
}*/


