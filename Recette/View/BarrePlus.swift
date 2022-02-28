//
//  BarrePlus.swift
//  Recette
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct BarrePlus: View {
    var body: some View {
        HStack{
            Spacer(minLength: 0)
            Button(action:{}){
                Image(systemName: "plus.rectangle.fill")
                    .font(.title)
                    .foregroundColor(.purple)
                    .cornerRadius(15)
                    
            }.frame(maxWidth : .infinity )
        }.padding([.horizontal,.top])
            .background(.white)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: -5)
            .cornerRadius(15)
            
    }
}

struct BarrePlus_Previews: PreviewProvider {
    static var previews: some View {
        BarrePlus()
    }
}

