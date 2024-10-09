//
//  ContentView.swift
//  ColorSliderSwiftUI
//
//  Created by Евгений on 08.10.2024.
//


import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var textFieldValues: [String] = ["", "", ""]
    
    var body: some View {
        ZStack {
            Color(.cyan)
                .ignoresSafeArea()
                .onTapGesture {
                    updateAllSliderValues()
                    hideKeyboard()
                }
            
            VStack {
                ColorView(redSliderValue: $redSliderValue,
                          greenSliderValue: $greenSliderValue,
                          blueSliderValue: $blueSliderValue)
                
                ColorSliderView(sliderValue: $redSliderValue,
                                textFieldValue: $textFieldValues[0])
                .tint(.red)
                ColorSliderView(sliderValue: $greenSliderValue,
                                textFieldValue: $textFieldValues[1])
                .tint(.green)
                ColorSliderView(sliderValue: $blueSliderValue,
                                textFieldValue: $textFieldValues[2])
                .tint(.blue)
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        updateAllSliderValues()
                        hideKeyboard()
                    }
                }
            }
            .padding(16)
        }
    }
    
    private func updateAllSliderValues() {
        withAnimation {
            for (index, value) in textFieldValues.enumerated() {
                if let doubleValue = Double(value), (0...255).contains(doubleValue) {
                    switch index {
                    case 0:
                        redSliderValue = doubleValue
                    case 1:
                        greenSliderValue = doubleValue
                    default:
                        blueSliderValue = doubleValue
                    }
                } else {
                    textFieldValues[index] = String(
                        format: "%.0f",
                        index == 0 ? redSliderValue : index == 1 ? greenSliderValue : blueSliderValue
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
