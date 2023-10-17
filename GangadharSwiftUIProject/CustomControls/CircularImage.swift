//
//  CircularImage.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct CircularImage: View {
    var width:Float
    var height:Float
    var Image:Image
    var body: some View {
        Image
            .resizable()
            .frame(width: CGFloat(width),height: CGFloat(height))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .scaledToFit()
            
    }
}

#Preview {
    CircularImage(width: 80.0, height: 80.0,Image:Image("Test") )
}
