//
//  BarrePlus.swift
//  Recette
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct BarrePlus: View {
    @State var isAddViewPresented = false
    @ObservedObject var listRecette : ListeFicheViewModel
    @ObservedObject var recette : FicheViewModel
    var intent : FicheIntent
    init (recette : FicheViewModel, listRecette : ListeFicheViewModel){
        self.recette = recette
        self.listRecette = listRecette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        self.intent.addObserver(viewModel: listRecette)}
    var body: some View {
        HStack{
            Button(action:{
                print("Passage à l'ajout de la fiche")
                self.isAddViewPresented = true
            }){
                Image(systemName: "plus.rectangle.fill")
                    .font(.title)
                    .foregroundColor(.purple)
                    .cornerRadius(15)
                    
            }.frame(maxWidth : .infinity )
                .sheet(isPresented: $isAddViewPresented, content: {
                    AjoutFicheView(recette: recette, listRecette: listRecette)
                })
                
     /*
            Button(action:{
                
            }){
                Image(systemName: "circle")
                    .font(.title)
                    .foregroundColor(.purple)
                    .cornerRadius(15)
                    
            }*/
        }.padding([.horizontal,.top])
            .cornerRadius(15)
            
    }
}

/*struct BarrePlus_Previews: PreviewProvider {
    static var previews: some View {
        BarrePlus()
    }
}*/

