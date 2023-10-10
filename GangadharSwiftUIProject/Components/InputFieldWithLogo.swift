//
//  InputFieldWithLogo.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI

struct InputFieldWithLogo: View {
    @State var InputField:String
    var PlaceHolder:String
    var ImageName:String
    var Password:Bool=false
    @State var ShowPassword=false
    var ShowEye:Bool=true
    var body: some View {
        HStack{
            Image(systemName: ImageName).foregroundColor(Color("Primary")).dynamicTypeSize(.xxxLarge).frame(maxWidth:13).scaledToFit()
            if(Password){
                if(ShowPassword){
                    TextField(PlaceHolder, text: $InputField)
                        .padding(10)
                        .background(Color(white: 0.9))
                        .cornerRadius(7.0).padding(.horizontal,10)
                        .textContentType(.password)
                }
                else{
                    SecureField(PlaceHolder, text: $InputField)
                        .padding(10)
                        .background(Color(white: 0.9))
                        .cornerRadius(7.0).padding(.horizontal,10)
                        .textContentType(.password)
                        .padding(.trailing,ShowEye ? 0 :40)
                }
                if(ShowEye){
                    withAnimation{
                        Button("", systemImage: ShowPassword ? "eye.fill" : "eye.slash.fill") {
                            ShowPassword.toggle()
                        }.foregroundColor(Color("Primary"))
                    }
                }
            }
            else{
                TextField(PlaceHolder, text: $InputField)
                    .padding(10)
                    .background(Color(white: 0.9))
                    .cornerRadius(7.0).padding(.horizontal,10).padding(.trailing,40)
            }
            
        }.padding(.horizontal,30)
    }
}

#Preview {
    InputFieldWithLogo(InputField: "",PlaceHolder: "PlaceHOler", ImageName:"person",Password: true)
}
