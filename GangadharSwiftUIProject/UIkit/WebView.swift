//
//  WebView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/18/23.
//

import Foundation
import WebKit
import SwiftUI

struct WebView : UIViewRepresentable{
    var url : URL
    func makeUIView(context: Context) -> some UIView {
        return WKWebView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let webRequest = URLRequest(url:url)
        (uiView as! WKWebView).load(webRequest)
    }
}
