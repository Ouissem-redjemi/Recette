//
//  MoficationFicheView.swift
//  Recette
//
//  Created by Dalia Rdjm on 2/3/2022.
//

import SwiftUI

struct ModificationFicheView: View {
    @Environment(\.presentationMode) private var mode
    @ObservedObject var recette : FicheViewModel
    @ObservedObject var listRecette : ListeFicheViewModel
    
    let catégories = [CategorieRecette.accompagnement, CategorieRecette.dessert, CategorieRecette.entree, CategorieRecette.plat]
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
                    TextField("Intitulé de la recette", text: $recette.title)
                }
                Section(header: Text("Catégorie")){
                    Picker("Catégorie", selection: $recette.categorie){
                        ForEach(catégories, id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.menu)
                }
                Section(header: Text("Nombre de couverts")){
                    Stepper("\(recette.nbCouverts)", value: $recette.nbCouverts, in: 1...100, step : 1)
                }
                Section(header: Text("Responsable")){
                    TextField("Nom du responsable", text: $recette.responsable)
                }
                Section(header: Text("Matériel de dressage")){
                    TextEditor(text: $recette.materielDressage ?? "Pas de matériels de dressage")
                }
                Section(header: Text("Matériel spécifique")){
                    TextEditor(text: $recette.materielSpecifique ?? "Pas de matériels spécifique ")
                }
                Section(header: Text("étapes")){}
                
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
                        //Update data of firestore
                        self.recette.UpdateData(recette: recette)
                        //Close the view after
                        self.mode.wrappedValue.dismiss()
                        print("Modification des données --- Réussie !")
                        
                    }){
                        Image(systemName: "checkmark")
                            .foregroundColor(.purple)
                    }
                }
            })
            .navigationTitle("Modification")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}


