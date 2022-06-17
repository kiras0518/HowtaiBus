//
//  Loader.swift
//  HowtaiBus
//
//  Created by yukun on 2022/6/16.
//

import SwiftUI

struct Loader: View {
    
    @State var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Loading..."){
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(Color.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false), value: animationAmount)
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
