//
//  AjoutFiche.swift
//  Recette
//
//  Created by Dalia Rdjm on 28/2/2022.
//

import SwiftUI

struct AjoutFicheView: View {
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
                Section(header: Text("étapes")){BarrePlus()}
                
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action :{}){
                        Image(systemName: "xmark")
                            .foregroundColor(.purple)
                    }
                }
                ToolbarItem{
                    Button(action :{}){
                        Image(systemName: "checkmark")
                            .foregroundColor(.purple)
                    }.disabled(recette.title.isEmpty)
                        .disabled(recette.responsable.isEmpty)
                        .disabled(recette.nbCouverts.description.isEmpty)
                        .disabled(recette.categorie.rawValue.isEmpty)
                }
            })
            .navigationTitle("Nouvelle recette")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

struct AjoutFicheView_Previews: PreviewProvider {
    static var previews: some View {
        AjoutFicheView(recette: FicheViewModel(from: Fiche (id: "")), listRecette: ListeFicheViewModel())
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
