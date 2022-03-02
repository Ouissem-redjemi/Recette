//
//  ListAllergeneView.swift
//  Recette
//
//  Created by Souhaila kesbi on 24/02/2022.
//
import SwiftUI

struct ListAllergeneView: View {
    
    var listAllergene : [Allergene] = Allergene.allValues
    
 
    @State var newAllergene = Allergene.arachide
    @State var searchingFor = ""
    var results : [Allergene]{
        if searchingFor.isEmpty{
            return listAllergene
        }
        else{
            return listAllergene.filter{
                $0.rawValue.contains(searchingFor)
            }
        }
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
            
        
            VStack (spacing : 40){
                HStack{
                    VStack(alignment : .leading){
                        Text("Mes Allergènes").bold().font(.title2)
                    }
                    
                
                        
                }
            
                List {
            
                    ForEach(listAllergene , id: \.id){
                        allergene  in
                            VStack(alignment: .leading){
                                Group{
                                    Text(allergene.rawValue).bold()
                                }
                            }
                        }
                }
                EditButton()
            }.navigationBarHidden(true)
            }
        }
    }


struct ListAllergeneView_Previews: PreviewProvider {
    static var previews: some View {
 
        ListAllergeneView(listAllergene: Allergene.allValues)
    }
}
