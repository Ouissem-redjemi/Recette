//
//  EtapeView.swift
//  Recette
//
//  Created by Dalia Rdjm on 3/3/2022.
//

import SwiftUI

struct EtapeView: View {
    @State var isIngViewPresented = false
    @Environment(\.presentationMode) private var mode
    @ObservedObject var recette : FicheViewModel
    @ObservedObject var listRecette : ListeFicheViewModel
    @ObservedObject var listIngredients = ListeIngredientViewModel ()
    @State private var ingredient : Ingredient = Ingredient(id: "", allergene: Allergene.arachide, categorie: CategorieIngredient.epice, code: "", libelle: "", prix_unitaire: 10, unite: "", quantite: 5)
    @State var quantite : Double = 0
    @State var id : String = ""
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var intent : FicheIntent
    var intentIngredient : IngredientIntent = IngredientIntent()
    init(recette : FicheViewModel, listRecette : ListeFicheViewModel){
        self.recette = recette
        self.listRecette = listRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listRecette)
        self.intentIngredient.addObserver(viewModel: listIngredients)
        self.listIngredients.getData()
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
                    List{
                        ForEach(listIngredients.listeIngredient, id:\.id){ ingredient in
                            HStack{
                                Text(ingredient.libelle)
                                Text("Qtité : ")
                                TextField("Quantité", value: $quantite, formatter: formatter)
                                Button {
                                    self.recette.ingredients![ingredient.idIngredient] = Double(quantite)
                                } label: {
                                    Text("Valider")
                                }
                                
                            }
                            
                            
                            
                        }
                        
                    }
                }
                
                /*
                 Section(header: Text("Ingrédients")){
                 Picker("Ingrédients", selection: $ingredient){
                 ForEach(listIngredients.listeIngredient, id:\.id){ ingredient in
                 Text(ingredient.libelle)
                 }
                 }.pickerStyle(.menu)
                 
                 
                 }
                 */
                
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
                        
                        //Add step to the database and push into liste step of the recipe
                        self.id = self.recette.addDataStep(title: self.recette.titleStep, description: self.recette.description, duree: self.recette.duree, ingredients: self.recette.ingredients)
                        // self.recette.addStep(id: self.recette.addDataStep(title: self.recette.titleStep, description: self.recette.description, duree: self.recette.duree))
                        //print(self.recette.etapes.description)
                        print("\(recette.idFiche!)")
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
                .navigationTitle("Nouvelle Etape")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
    
    
}

/*struct EtapeView_Previews: PreviewProvider {
    static var previews: some View {
        EtapeView(recette: FicheViewModel(from: Fiche (id: "")), listRecette: ListeFicheViewModel())
    }
}*/


/* etapes [id1, .....] */
