//
//  ContentView.swift
//  WorkingWithGlenn
//
//  Created by Gia Bao Ta on 10/24/23.
//



import SwiftUI
import Firebase


struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.list) { d in
                HStack{
                    Text(d.name)
                    Spacer()
                    Text(String(d.rating))
                }
                }
                .onAppear() {
                    viewModel.getdata()
            }
        }
    }

    
    struct Content_perview: View{
        @State private var foodName: String = ""
        @State private var rating: Double = 5
        var body: some View {
            
            NavigationView {
                
                Form{
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
                    
                    
                }
                
                .navigationBarTitle("Food Rating")
                
            }
        }
        
    }
}
