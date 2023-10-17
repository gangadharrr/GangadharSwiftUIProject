//
//  UserHomeView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct UserHomeView: View {
    @ObservedObject var usersData=UserDataLoader()
    var users:[UserData]{
        usersData.allUsers
    }
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    List{
                        ForEach(users ,id:\.id){user in
                        NavigationLink{
                            UserDetailsView(user:user)
                        }label: {
                            UserRow(user: user)
                        }                            
                        }
                    }
                }
            }.navigationTitle("Users")
                .toolbar{
                    NavigationLink{
                        ProfileView()
                    }label: {
                        CircularImage(width:30.0, height: 30.0,Image:Image("Test")).padding(.horizontal)
                    }
                    
                }
                .navigationBarBackButtonHidden()
        }.onAppear(){
            Task{
                try await usersData.getUsers()
            }
        }
        
    }
}

#Preview {
    UserHomeView()
}
