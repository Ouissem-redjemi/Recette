//
//  StepView.swift
//  Recette
//
//  Created by Dalia Rdjm on 6/3/2022.
//

import SwiftUI

struct StepView: View {
    @State var isChecked = false
    @State var isRemovePresented = false
    @State var tabStep : [String] = []
    @ObservedObject var etape : FicheViewModel
    @ObservedObject var recette : FicheViewModel
    var intent : FicheIntent
    init (etape : FicheViewModel, recette: FicheViewModel){
        self.etape = etape
        self.recette = recette
        self.intent = FicheIntent()
        self.intent.addObserver(viewModel: recette)
        
    }
    var body: some View {
        HStack{
            HStack{
            Button(action : {
                self.isChecked.toggle()
                self.recette.addStep(id: etape.idFiche!)
                
            }, label: {
                Image(systemName: isChecked ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.purple)
            }).padding()
            
                if etape.titleStep!.isEmpty {
                    Text("\(etape.title)")
                        .foregroundColor(.black)
                }else{
                    Text("\(etape.titleStep!)")
                    .foregroundColor(.black)
                }
            }
            /*HStack{
            Button(action :{
                self.isRemovePresented.toggle()
            }){
                Image(systemName: "clear")
                    .foregroundColor(.purple)
                    .font(.title)
            }.actionSheet(isPresented: $isRemovePresented){
                ActionSheet(title: Text("Are you sure ?"),
                            buttons: [
                                .destructive(Text("Supprimer l'étape"), action: {
                                    self.etape.removeData()
                                    print("Suppression réussie")
                                }),
                                    .cancel()
                            ])
            }
            }*/
        }
        
    }
}

/*struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(recette: FicheViewModel(from: Fiche(id: "")))
    }
}*/
