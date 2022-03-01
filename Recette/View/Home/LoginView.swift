//
//  LoginView.swift
//  Recette
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct LoginView: View {
    @State var connected = false
    @State var email = ""
    @State var pwd = ""
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
