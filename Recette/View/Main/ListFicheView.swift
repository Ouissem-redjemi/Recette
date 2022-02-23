//
//  ListFicheView.swift
//  Recette
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct ListFicheView : View {
    @ObservedObject var listFiches : ListeFicheViewModel
    var intent : FicheIntent
    
    init(listFiche : ListeFicheViewModel){
        self.listFiches = listFiche
        listFiche.getData()
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: listFiche)
        
    }
    var body: some View {
        VStack (){
            NavigationView{
                List {
                    ForEach(listFiches.listeFiches.listFiche, id: \.idFiche){
                        fiche in
                        NavigationLink(destination: FicheView(recette: FicheViewModel(from: fiche), listeRecette: listFiches)){
                            VStack(alignment: .leading){
                                Group{
                                    Text(fiche.title).bold()
                                    Text(fiche.responsable)
                                }
                            }
                        }
                       
                    }
                    .onDelete{ indexSet in
                        listFiches.listeFiches.listFiche.remove(atOffsets: indexSet)
                    }.onMove{ indexSet, index in
                        listFiches.listeFiches.listFiche.move(fromOffsets: indexSet, toOffset: index)
                        
                    }.navigationTitle("Mes recettes")
                  
                    
            }
            
        }
        EditButton()
        }
    }
}

