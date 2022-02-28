//
//   ProductCard.swift
//  Recette
//
//  Created by Souhaila kesbi on 27/02/2022.
//

import SwiftUI
struct ProductCard: View {
    

    var title: String
    var type: String
    var price: Double
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(type)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                HStack {
                    Text("$" + String.init(format: "%0.2f", price))
                        .font(.system(size: 19, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
            }.padding( .leading , 30)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 100/255, green: 36/255, blue: 100/255))
        .modifier(CardModifier())
        .padding(.all)
    }
}
struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard( title: "Autumn Soup", type: "dessert", price: 11.99)
    }
}
