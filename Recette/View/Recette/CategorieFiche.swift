//
//  CategorieFiche.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct CategorieFiche: View {
    //var categorieName : String
    @ObservedObject var  listFiches: ListeFicheViewModel = ListeFicheViewModel ()
    var intent : FicheIntent = FicheIntent ()
  
    
    init(){
       // self.categorieName = categoryName
        self.listFiches.getData()
        self.intent.addObserver(viewModel: listFiches)
        
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{

            List{
                
                ForEach(CategorieRecette.allValues,id :\.self) { categorie in
                    DisclosureGroup(categorie.rawValue) {
                        
                        VStack(alignment: .leading){
                        
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(listFiches.listeFiches , id: \.id){
                                        fiche in
                                        if(fiche.categorie.rawValue == categorie.rawValue){
                                            if(fiche.title != ""){
                                                NavigationLink(destination:
                                                                DetailFicheView(recette: FicheViewModel(from: fiche), listeRecette: listFiches)){
                                                    RecetteCarte(recette: FicheViewModel(from: fiche), listRecette: listFiches)
                                                }
                                            }
                                       
                                        }
                                        
                                        
                                    }
                                }
                            }
                        }
                
                
                }
                
            }
            }
            .listStyle(InsetGroupedListStyle())
         
            }
            .navigationTitle("Categories")
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
                .navigationBarBackButtonHidden(true)
        }
    }
}

