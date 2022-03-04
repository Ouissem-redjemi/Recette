//
//  VenteView.swift
//  Recette
//
//  Created by Souhaila kesbi on 04/03/2022.
//

import SwiftUI

struct VenteView: View {
    
    @ObservedObject var listFiches = ListeFicheViewModel ()
    var intent : FicheIntent = FicheIntent ()
  
    @State var quantite :  Int = 0
    @State private var selection = 1
    let formatter: NumberFormatter = {
      let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
      return formatter
    }()
 
    
    init(){
        self.listFiches.getData()
        self.intent.addObserver(viewModel: listFiches)
    }
    
    var body: some View {
        VStack{
            Text("Vente").font(.title).foregroundColor(.purple)
            Form{
          
                
                Text("Selectionner une fiche pour la vente ").font(.title3)
                Section(header: Text("Fiches ")){
                    Picker("Fiches : ", selection: $selection) {
                        ForEach(listFiches.listeFiches,id :\.self) {
                            if($0.title != ""){
                                Text($0.title)
                            }
                      }
                    }.pickerStyle(.menu)
                }
                
                Section(header: Text("Nombre de plat")){
                    TextField("Quantité", value: $quantite, formatter : formatter)

                }
                
                
                    
                    
                    //Text("\(listFiches.listeFiches[0].responsable  )")
                   // Text(Picker.label)
       
   
            
            }
      
        }
    }
}

struct VenteView_Previews: PreviewProvider {
    static var previews: some View {
        VenteView()
    }
}
