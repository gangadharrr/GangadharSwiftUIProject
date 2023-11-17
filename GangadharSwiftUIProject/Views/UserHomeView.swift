//
//  UserHomeView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct UserHomeView: View {
    @ObservedObject var usersData=UserDataLoader()
    @State var newUser:UserData?
    @State var isLoading:Bool=true
    @State var ShowAddUser:Bool=false
    var body: some View {
        if(isLoading){
            BusyView(message: Messages.FetchingUsers)
                .onAppear(){
                    Task{
                        try await usersData.getUsers()
                        isLoading=false
                    }
                }
        }
        else{
            NavigationView{
                ZStack {
                    VStack{
                        List{
                            ForEach(usersData.allUsers ,id:\.id){user in
                                NavigationLink{
                                    UserDetailsView(user:user)
                                }label: {
                                    UserRow(user: user)
                                }
                            }
                        }
                    }
                }.onAppear{
                    newUser=usersData.allUsers.last
                }.sheet(isPresented:$ShowAddUser){
                    
                    AddUserView(newUser: $usersData.allUsers)
                }
                .navigationTitle(LabelConstants.Users)
                    .toolbar{
                        Button{
                            ShowAddUser.toggle()
                        }label:{
                            Image(systemName: ImageConstants.SYSPersonFillBadgePlus)
                        }
                        
                        NavigationLink{
                            ProfileView()
                        }label: {
                            CircularImage(width:30.0, height: 30.0,Image:Image(ImageConstants.Test)).padding(.horizontal)
                        }
                        
                    }
                   
            } .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    UserHomeView()
}
