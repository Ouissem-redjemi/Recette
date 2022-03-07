//
//  ListStepView.swift
//  Recette
//
//  Created by Dalia Rdjm on 5/3/2022.
//

import SwiftUI

struct ListStepView: View {
    @State var isChecked = false
    @State var isAddStepViewPresented = false
    @State var isAdded = false
    @Environment(\.presentationMode) private var mode
    @ObservedObject var listRecette : ListeFicheViewModel
    @ObservedObject var recette : FicheViewModel
    var intent : FicheIntent
    init (listRecette : ListeFicheViewModel, recette : FicheViewModel){
        self.listRecette = listRecette
        self.recette = recette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: listRecette)
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("\(listRecette.listeFiches.count) étapes disponibles ")
                    .font(.headline)
                    .fontWeight(.thin)
                    .opacity(0.7)
                    .padding()
                List(){
                    ForEach(listRecette.listeFiches){ step in
                        
                        StepView(etape: FicheViewModel(from: step),recette: self.recette )
                        
                        
                        
                    }.onMove { IndexSet, Int in
                        listRecette.listeFiches.move(fromOffsets: IndexSet, toOffset: Int)
                    }
                }.onAppear(){
                    print("fetchData ici ------- liste des etapes ici aussi")
                    self.listRecette.fetchData()
                }
                
                
                Button(action : {
                    self.isAddStepViewPresented.toggle()
                }, label: {
                    Label("Ajouter une étape", systemImage: "plus.circle.fill")
                        .foregroundColor(.purple)
                }).padding()
                    .sheet(isPresented: $isAddStepViewPresented, content: {
                        EtapeView(recette : self.recette, listRecette: self.listRecette)
                        
                    })
                
                
            }.navigationTitle("Étapes 📑")
                .navigationBarItems(leading:HStack{
                    Button(action :{
                        self.mode.wrappedValue.dismiss()
                        print("Annulation réussie")
                    }){
                        Image(systemName: "xmark")
                            .foregroundColor(.purple)
                    }
                    
                } , trailing: HStack{
                    Button(action :{
                        self.isAdded.toggle()
                        self.mode.wrappedValue.dismiss()
                        print("Ajout de la recette dans la base de données --- Réussie !")
                    }){
                        Image(systemName: "checkmark")
                            .foregroundColor(.purple)
                    }
                    
                    
                })
        }
    }
    
}

/*struct ListStepView_Previews: PreviewProvider {
 static var previews: some View {
 ListStepView(listRecette: ListeFicheViewModel())
 }
 }*/
