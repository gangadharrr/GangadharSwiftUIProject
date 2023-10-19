//
//  UserRow.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct UserRow: View {
    var user:UserData
    var body: some View {
        HStack{
            AsyncImage(url: user.avatarURL,scale: 1.5){image in image.resizable().scaledToFit().frame(width:80,height: 80)
                    .clipShape(Circle())
                
            }placeholder: {
                ProgressView().frame(width:20,height: 20).padding()
            }

            Spacer()
            VStack{
                Spacer()
                Text(user.fullName).font(.system(size: 23)).fontWeight(.medium)
                Spacer()
                Text(user.email).font(.system(size: 15)).foregroundColor(.gray).italic()
                Spacer()
            }
            Spacer()
        }.padding(5)
    }
}

#Preview {
    UserRow(user: UserData(id: 1, email: "email", firstName: "Michel", lastName: "Lawson", avatar: "https://reqres.in/img/faces/7-image.jpg"))
}
