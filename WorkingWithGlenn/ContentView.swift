//
//  ContentView.swift
//  WorkingWithGlenn
//
//  Created by Gia Bao Ta on 10/24/23.
//

import Foundation
import SwiftUI


struct ContentView: View {
    @State private var foodName: String = ""
    @State private var rating: Double = 5
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Food Name", text: $foodName)
                }
                Section {
                    HStack {
                        Text("Rating:")
                        Spacer()
                        Stepper(value: $rating, in: 1...10, step: 1) {
                            Text("\(Int(rating))")
                        }
                    }
                }
                Section {
                    Button(action: {
                        print("Food Name: \(foodName)")
                        print("Rating: \(rating)")
                    }) {
                        Text("Submit")
                    }
                }
            }
            .navigationBarTitle("Food Rating")
        }
    }
}
