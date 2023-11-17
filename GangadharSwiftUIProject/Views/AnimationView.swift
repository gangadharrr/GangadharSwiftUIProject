//
//  AnimationView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/20/23.
//

import SwiftUI

struct AnimationView: View {
    @State var angle = 0.0
    @State var scale1: CGFloat = 0
    @State var scale3: CGFloat = 0
    var foreverAnimation =
    Animation.linear.speed(0.2)
        .repeatForever(autoreverses: false)
    var body: some View {
        //        Button("Rotated by \(angle)"){
        //            angle = angle+15
        //        }.rotationEffect(.degrees(angle))
        //            .animation(.interpolatingSpring(stiffness: 1, damping: 1,initialVelocity: 10))
        
        ZStack {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.red)
                .opacity(1-scale1)
                .scaleEffect(1 + (scale1 * 2))
                .onAppear {
                    withAnimation(foreverAnimation) {
                        scale1 = 1
                    }
                }
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.red)
                .opacity(1 - scale3)
                            .scaleEffect(1 + (scale3 * 2))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation(foreverAnimation) {
                                        scale3 = 1
                                    }
                                }
                            }
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(Color.red)
        }
        
        
    }
    
}


#Preview {
    AnimationView()
}
