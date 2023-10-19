//
//  WebViewDisplay.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/18/23.
//

import SwiftUI

struct WebViewDisplay: View {
    var body: some View {
        WebView(url: URL(string: "https://www.github.com")!).ignoresSafeArea(.all)
    }
}

#Preview {
    WebViewDisplay()
}
