//
//  BarrePlus.swift
//  Recette
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct BarrePlus: View {
    @State var isAddViewPresented = false
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
                    AjoutFicheView(recette: FicheViewModel(from: Fiche(id:"")), listRecette: ListeFicheViewModel())
                })
            
            Button(action:{
                
            }){
                Image(systemName: "circle")
                    .font(.title)
                    .foregroundColor(.purple)
                    .cornerRadius(15)
                    
            }
        }.padding([.horizontal,.top])
            .cornerRadius(15)
            
    }
}

/*struct BarrePlus_Previews: PreviewProvider {
    static var previews: some View {
        BarrePlus()
    }
}*/

