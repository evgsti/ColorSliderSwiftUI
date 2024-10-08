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
