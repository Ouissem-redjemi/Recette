    //
    //  ListFicheView.swift
    //  Recette
    //
    //  Created by m1 on 22/02/2022.
    //

    import SwiftUI

    struct ListFicheView : View {
        @ObservedObject var listFiches = ListeFicheViewModel ()
        var intent : FicheIntent = FicheIntent()
        init(){
            self.listFiches.getData()
            self.intent.addObserver(viewModel: listFiches)
            
        }
    
        var body: some View {
           VStack{
               HStack{
                   Text("\(listFiches.listeFiches.count) recettes disponibles")
                       .font(.headline)
                       .fontWeight(.medium)
                       .opacity(0.7)
                   Spacer()
                }
               LazyVGrid(columns: [GridItem (.adaptive(minimum: 160), spacing: 15)], spacing: 15){
                   ForEach(listFiches.listeFiches){
                       fiche in RecetteCarte(recette: FicheViewModel(from: fiche), listRecette: listFiches)
                   }
               }
               .padding(.top)
            }
            .padding(.horizontal)
           }
 
    }
               
               
                
struct ListFicheView_Previews: PreviewProvider {
    static var previews: some View {
        ListFicheView()
    }
}


