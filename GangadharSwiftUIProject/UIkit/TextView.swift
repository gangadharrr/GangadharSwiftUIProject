//
//  TextView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/18/23.
//

import Foundation
import UIKit
import SwiftUI
struct TextView:UIViewRepresentable{
    @Binding var text: String;
    @Binding var textStyle: UIFont.TextStyle;
    
    func makeUIView(context: Context) -> some UIView {
        let textView  = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        
        textView.delegate = context.coordinator
        return textView;
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        (uiView as! UITextView).text = text;
        (uiView as! UITextView).font  = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate{
        var text: Binding<String>
        init(text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text;
        }
    }
}
