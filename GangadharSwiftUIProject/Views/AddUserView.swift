//
//  AddUserView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/18/23.
//

import SwiftUI
import PhotosUI

struct AddUserView: View {
    @State var InputFirstName:String=""
    @State var InputLastName:String=""
    @State var InputEmail:String=""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var cameraShow:Bool=false
    @State var textArea:String=""
    @State var textStyle=UIFont.TextStyle.headline
    @State var pickImage:Bool=false
    @State var userImage:UIImage=UIImage()
    @State var imagePath:String=""
    @Binding var newUser:[UserData]
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
//                    TextView(text: $textArea, textStyle:$textStyle )
//                    WebView(url: URL(string: "https://www.google.com")!)
                    Form{
                        Section(Titles.AddProfilePicture){
                            ZStack(alignment: .topTrailing){
//                                if  selectedImageData != nil{
                                    Image(uiImage: userImage)
                                        .resizable()
                                        .scaledToFit().onTapGesture {
                                            cameraShow.toggle()
                                        }
//                                }else{
//                                    Image(systemName: "person.and.background.dotted")
//                                        .resizable()
//                                        .scaledToFit().onTapGesture {
//                                            cameraShow.toggle()
//                                        }
//                                }
                                Image(systemName: ImageConstants.SYSCameraFill)
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .scaledToFit()
                                    .frame(width: 40).onTapGesture {
                                        pickImage.toggle()
                                    }
                                
//                                if(cameraShow){
//                                    
//                                        PhotosPicker(
//                                               selection: $selectedItem,
//                                               matching: .images,
//                                               photoLibrary: .shared()) {
//                                                   Image(systemName: "camera.fill")
//                                                       .resizable()
//                                                       .foregroundColor(.blue)
//                                                       .scaledToFit()
//                                                       .scaleEffect(0.2)
//                                                       .background(Color(white: 0.9,opacity:0.5))
//                                                       .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight:.infinity)
//                                               }.onChange(of: selectedItem) { newItem in
//                                                   Task {
//                                                       if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                                                           selectedImageData = data
//                                                       }
//                                                   }
//                                               }
//                                        
//                                }
                                
                            }
                        }
                        Section(PlaceholdersConstants.UserDetails){
                            TextField(PlaceholdersConstants.FirstName, text: $InputFirstName)
                            TextField(PlaceholdersConstants.LastName, text: $InputLastName)
                            TextField(PlaceholdersConstants.Email, text: $InputEmail)
                        }

                    }
                  
                }
            }.onTapGesture {
                cameraShow=false
            }
            .sheet(isPresented: $pickImage) {
                ImagePicker(selectedImage: $userImage, imagePath: $imagePath)
            }.navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        
                        Text(LabelConstants.Cancel)
                        Image(systemName: ImageConstants.SYSCancel )
                    }.foregroundColor(.red)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        newUser.append(UserData(id: Int.random(in: 7...100), email: InputEmail, firstName:InputFirstName, lastName: InputLastName, avatar: imagePath))
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(LabelConstants.Save)
                        Image(systemName:ImageConstants.SYSSquareAndArrow)
                    }
                }
                
            }
        }
        
    }
}

//#Preview {
//    AddUserView()
//}
