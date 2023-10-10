//
//  RegistrationView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct RegistrationView: View {
    @State var InputName:String=""
    @State var InputEmail:String=""
    @State var InputPassword:String=""
    @State var ReTypePassword:String=""
    @State var ShowPassword:Bool=false
    @Binding var ShowLoginView:Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width:200,height: 200)
                InputFieldWithLogo(InputField: InputName, PlaceHolder: "Enter Name", ImageName: "person.fill").padding(.vertical,5)
                InputFieldWithLogo(InputField: InputEmail, PlaceHolder: "Enter Email", ImageName: "envelope.fill").padding(.vertical,5)
                
                InputFieldWithLogo(InputField: InputPassword, PlaceHolder: "Enter Password", ImageName: "lock.fill",Password: true,ShowEye:false).padding(.vertical,5)
                InputFieldWithLogo(InputField: ReTypePassword, PlaceHolder: "Re-Enter Password", ImageName: "lock.fill",Password: true,ShowPassword: ShowPassword).padding(.vertical,5)
                
                Button {
                    
                }label:{
                    Text("Register").frame(maxWidth: .infinity)
                        .foregroundColor(.white).padding(8)
                        .font(.system(size: 21))
                        .background(Color("Primary"))
                        .cornerRadius(7.0)
                    
                }.frame(maxWidth: 200)
                    .padding()
                Spacer()
                Spacer()
                Button{
                    ShowLoginView.toggle()
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Registered Already? Login")
                }
                
            }
        }
    }
}

#Preview {
    RegistrationView(ShowLoginView: .constant(false))
}
