//
//  LoginView.swift
//  Recette
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI


struct LoginView: View {
    @Environment(\.presentationMode) private var mode
    @EnvironmentObject var loginVM : LoginViewModel
    @State var email = ""
    @State var pwd = ""
    var body: some View {
        
        VStack{
            Text("Bienvenue")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            VStack{
                TextField("Adresse Mail", text: $email)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Mot de passe", text: $pwd)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button(action : {
                    if !email.isEmpty, !self.pwd.isEmpty{
                        self.loginVM.logIn(email: self.email, mdp: self.pwd)
                        
                    }else{
                        return
                    }
                    
                }, label: {
                    Text("Se connecter")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 200, height: 50)
                        .background(.green)
                }).clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                
                
                
            }.padding()
        }.background(Image("fond"))
    }
}

