//
//  LoginView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct LoginView: View {
    @State var InputEmail:String=""
    @State var InputPassword:String=""
    @State var ShowPassword:Bool=false
    @State var ShowRegisterView:Bool=false
    var body: some View {
        if(ShowRegisterView){
            RegistrationView(ShowLoginView: $ShowRegisterView)
        }
        else{
            ZStack{
                VStack{
                    Spacer()
                    Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width:200,height: 200)
                    InputFieldWithLogo(InputField: InputEmail, PlaceHolder: "Enter Email", ImageName: "person.fill").padding(.vertical,5)
                    
                    InputFieldWithLogo(InputField: InputPassword, PlaceHolder: "Enter Password", ImageName: "lock.fill",Password: true,ShowPassword: ShowPassword).padding(.vertical,5)
                    
                    Button {
                        
                    }label:{
                        Text("Login").frame(maxWidth: .infinity)
                            .foregroundColor(.white).padding(8)
                            .font(.system(size: 21))
                            .background(Color("Primary"))
                            .cornerRadius(7.0)
                        
                    }.frame(maxWidth: 200)
                        .padding()
                    Spacer()
                    Spacer()
                    Button{
                        ShowRegisterView.toggle()
                    }label: {
                        Text("New User? Register")
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
