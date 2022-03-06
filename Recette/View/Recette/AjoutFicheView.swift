//
//  AjoutFiche.swift
//  Recette
//
//  Created by Dalia Rdjm on 28/2/2022.
//

import SwiftUI

struct AjoutFicheView: View {
    @State var isStepViewPresented = false
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
                    TextField("Intitulé de la recette", text: $recette.title )
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
                Section(header: Text("étapes")){
                    HStack{
                        Button(action : {
                            self.isStepViewPresented = true
                        }, label: {
                            Text("Ajouter")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 100, height: 50)
                                .background(.purple)
                        }).clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .sheet(isPresented: $isStepViewPresented, content: {
                                ListStepView(listRecette: self.listRecette, recette : self.recette)
                                
                            })

                            
                        
                        
                        /*Button(action : {
                            print("hello")
                            
                        }, label: {
                            Text("Add step")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 100, height: 50)
                                .background(.purple)
                        }).clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))*/
                    }
                   
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
                        //Add data to firestore
                        print("Before adding recipe to db")
                        recette.addData(title: self.recette.title, categorie: self.recette.categorie.rawValue, responsable: self.recette.responsable, materielDressage: self.recette.materielDressage, materielSpecifique: self.recette.materielSpecifique, nbCouverts: self.recette.nbCouverts, etapes : self.recette.etapes)
                        print("After adding recipe to db")
                        //Close the view after adding data
                        self.mode.wrappedValue.dismiss()
                        print("Ajout de la recette dans la base de données --- Réussie !")
                        
                    }){
                        Image(systemName: "checkmark")
                            .foregroundColor(.purple)
                    }.disabled(recette.title.isEmpty)
                        .disabled(recette.responsable.isEmpty)
                        .disabled(recette.nbCouverts.description.isEmpty)
                        .disabled(recette.categorie.rawValue.isEmpty)
                }
            })
            .navigationTitle("Nouvelle recette 📝 ")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

/*struct AjoutFicheView_Previews: PreviewProvider {
    static var previews: some View {
        AjoutFicheView(recette: FicheViewModel(from: Fiche (id: "")), listRecette: ListeFicheViewModel())
    }
}*/

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
