//
//  InputFieldWithLogo.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/10/23.
//

import SwiftUI
struct InputFieldWithLogo: View {
    @Binding var InputField:String
    var PlaceHolder:String
    var ImageName:String
    var Password:Bool=false
    @Binding var warningMessage:WarningMessage
    @State var ShowPassword=false
    @State var showAlert=false
    var ShowEye:Bool=true
    var body: some View {
        HStack{
            Image(systemName: ImageName).foregroundColor(Color(ColorConstants.primaryColor)).dynamicTypeSize(.xxxLarge).frame(maxWidth:13).scaledToFit()
            HStack{
                
                if(Password){
                    if(ShowPassword){
                        TextField(PlaceHolder, text: $InputField)
                            .padding(10)
                            .cornerRadius(7.0).padding(.horizontal,10)
                            .textContentType(.password).frame(maxHeight: 40)
                            .autocapitalization(.none)
                            
                        if(warningMessage.showWarning){
                            Button("", systemImage:ImageConstants.SYSError) {
                                showAlert.toggle()
                            }.foregroundColor(.red)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text(warningMessage.title),
                                        message: Text(warningMessage.message),
                                        dismissButton: .default(Text(warningMessage.dismissText), action: {
                                            warningMessage.showWarning.toggle()
                                        })
                                    )
                                
                                
                            }
                        }
                    }
                    else{
                        SecureField(PlaceHolder, text: $InputField)
                            .padding(10)
                            .cornerRadius(7.0).padding(.horizontal,10)
                            .textContentType(.password).frame(maxHeight: 40)
                            .autocapitalization(.none)
                            .background(Color(ColorConstants.blackAndWhite))
                        if(warningMessage.showWarning){
                            Button("", systemImage:"exclamationmark.triangle.fill") {
                                showAlert.toggle()
                            }.foregroundColor(.red)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text(warningMessage.title),
                                        message: Text(warningMessage.message),
                                        dismissButton: .default(Text(warningMessage.dismissText), action: {
                                            warningMessage.showWarning.toggle()
                                        })
                                    )
                                }
                                
                            
                        }
                    }
                    if(ShowEye){
                        withAnimation{
                            Button("", systemImage: ShowPassword ? "eye.fill" : "eye.slash.fill") {
                                ShowPassword.toggle()
                            }.foregroundColor(Color("Primary")).background(Color(ColorConstants.blackAndWhite))
                        }
                    }
                }
                else{
                    TextField(PlaceHolder, text: $InputField)
                        .padding(10)
                        .cornerRadius(7.0).padding(.horizontal,10)
                        .padding(.trailing,40)
                        .frame(maxHeight: 40)
                        .autocapitalization(.none)
                    if(warningMessage.showWarning){
                        Button("", systemImage:ImageConstants.SYSError) {
                            showAlert.toggle()
                        }.foregroundColor(.red)
                        .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text(warningMessage.title),
                                    message: Text(warningMessage.message),
                                    dismissButton: .default(Text(warningMessage.dismissText), action: {
                                        warningMessage.showWarning.toggle()
                                    })
                                )
                            }
                            
                        
                    }
                    
                    
                }
            }.background(Color(ColorConstants.blackAndWhite))
                .cornerRadius(7.0).padding(.horizontal,10)
            
        }.padding(.horizontal,25)
        
    }
}

#Preview {
    InputFieldWithLogo(InputField: .constant(""),PlaceHolder: "PlaceHOler", ImageName:"person",Password: false,warningMessage: .constant(WarningMessage(title: "", message: "", dismissText: "")))
}


