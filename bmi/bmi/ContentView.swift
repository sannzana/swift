//
//  ContentView.swift
//  bmi
//
//  Created by Gaming Lab on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    
    // State variables for user input
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var bmiResult: Double?
    @State private var bmiCategory: String = ""
    @State private var suggestion: String = ""
    
    // Function to calculate BMI
    func calculateBMI() {
        // Convert input to doubles, and validate inputs
        if let weightValue = Double(weight), let heightValue = Double(height), weightValue > 0, heightValue > 0 {
            let heightInMeters = heightValue / 100.0 //to meters
            
        
            let bmi = weightValue / (heightInMeters * heightInMeters)
            bmiResult = bmi
            
            // Classify BMI and provide suggestions
            if bmi < 18.5 {
                bmiCategory = "Underweight"
                suggestion = "Consider a balanced diet with calorie-rich foods and strength training exercises."
            } else if bmi >= 18.5 && bmi < 24.9 {
                bmiCategory = "Normal weight"
                suggestion = "Maintain a healthy diet and regular physical activity to stay fit."
            } else if bmi >= 25 && bmi < 29.9 {
                bmiCategory = "Overweight"
                suggestion = "Consider a balanced diet, portion control, and regular exercise to reduce weight."
            } else {
                bmiCategory = "Obesity"
                suggestion = "Consult a healthcare provider for personalized guidance and support for weight loss."
            }
        } else {
            bmiResult = nil
            bmiCategory = "Invalid input"
            suggestion = ""
        }
    }
    
    // Function to reset the inputs and results
    func reset() {
        weight = ""
        height = ""
        bmiResult = nil
        bmiCategory = ""
        suggestion = ""
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color.blue.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Title at the top
                    Text("BMI Calculator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                        .foregroundColor(.blue)
                    
                    // Main form containing weight and height fields
                    VStack(spacing: 20) {
                        HStack {
                            Text("Weight (kg):")
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            TextField("Enter weight", text: $weight)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                                .frame(width: 150)
                        }
                        
                        HStack {
                            Text("Height (cm):")
                                .font(.headline)
                                .foregroundColor(.blue)
                            
                            TextField("Enter height", text: $height)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                                .frame(width: 150)
                        }
                    }
                    .padding()
                    
                    // Calculate button
                    Button(action: {
                        calculateBMI()
                    }) {
                        Text("Calculate BMI")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(radius: 10)
                    }
                    
                    Spacer()
                    
                    // Displaying BMI result, category, and suggestion
                    if let bmi = bmiResult {
                        VStack {
                            Text("Your BMI: \(String(format: "%.1f", bmi))")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding()
                            
                            Text("Category: \(bmiCategory)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text(suggestion)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding()
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 20)
                    } else {
                        Text(bmiCategory)
                            .font(.title2)
                            .foregroundColor(.red)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    // Reset button
                    Button(action: {
                        reset()
                    }) {
                        Text("Reset")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .shadow(radius: 10)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("BMI Calculator", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
