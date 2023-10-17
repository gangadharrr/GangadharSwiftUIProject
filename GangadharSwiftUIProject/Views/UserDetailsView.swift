//
//  UserDetailsView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct UserDetailsView: View {
    var user:UserData
    var body: some View {
        NavigationStack{
            VStack{
                Text("User Details").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                AsyncImage(url: user.avatarURL,scale: 0.5).scaledToFit().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(user.fullName).font(.title2).bold()
                Text(user.email).font(.title3).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        
        
    }
}

#Preview {
    UserDetailsView(user:  UserData(id: 1, email: "email", firstName: "Michel", lastName: "Lawson", avatar: "https://reqres.in/img/faces/7-image.jpg"))
}
