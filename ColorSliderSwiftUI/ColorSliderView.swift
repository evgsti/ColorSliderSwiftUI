//
//  Untitled.swift
//  ColorSliderSwiftUI
//
//  Created by Евгений on 09.10.2024.
//

import SwiftUI

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    @Binding var textFieldValue: String
    
    var body: some View {
        HStack {
            Text(lround(sliderValue).formatted())
                .frame(maxWidth: 31, alignment: .leading)
                .foregroundStyle(.white)
            
            Slider(value: $sliderValue, in: 0...255, step: 1)
            
            TextField("", text: $textFieldValue)
                .tint(.blue)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: 31)
                .keyboardType(.numberPad)
                .padding(5)
                .background(.white)
                .foregroundStyle(.black)
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1))
                .onAppear {
                    textFieldValue = String(format: "%.0f", sliderValue)
                }
                .onChange(of: sliderValue) {
                    textFieldValue = String(format: "%.0f", sliderValue)
                }
        }
    }
}

#Preview {
    @Previewable @State var sliderValue: Double = 128.0
    @Previewable @State var textFieldValue: String = "128"
    
    ColorSliderView(sliderValue: $sliderValue, textFieldValue: $textFieldValue)
}
