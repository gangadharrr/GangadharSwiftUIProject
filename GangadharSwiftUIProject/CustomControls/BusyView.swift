//
//  BusyView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/17/23.
//

import SwiftUI

struct BusyView: View {
    var message:String
    var body: some View {
        ProgressView(message)
            .progressViewStyle(.circular)
            .tint(.accentColor)
            .scaleEffect(1.3)
    }
}

#Preview {
    BusyView(message: Messages.Authenticating)
}
