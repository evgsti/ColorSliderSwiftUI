//
//  Untitled.swift
//  ColorSliderSwiftUI
//
//  Created by Евгений on 09.10.2024.
//

import SwiftUI

struct ColorView: View {
    @Binding var redSliderValue: Double
    @Binding var greenSliderValue: Double
    @Binding var blueSliderValue: Double
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Color(red: redSliderValue / 255,
                                   green: greenSliderValue / 255,
                                   blue: blueSliderValue / 255))
            .frame(height: 128)
            .clipShape(.rect(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 4)
            )
            .padding(.bottom, 53)
    }
}
