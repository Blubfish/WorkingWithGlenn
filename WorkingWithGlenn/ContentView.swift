import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var name: String = ""
    @State var rating: String = ""
    
    var body: some View {
        VStack{
            List{
                ForEach(viewModel.list) { d in
                    HStack{
                        Text("\(d.name):")
                        Text("\(String(d.rating))/10")
                        Spacer()
                        
                        Button(action: {
                            if name != "" && rating != ""{
                                viewModel.updateData(FoodListUpdate: d, name: name, rating: Double(rating) ?? 0.0)
                                name = ""
                                rating = ""
                            }
                        }, label: {
                            Image(systemName: "pencil")
                        })
                        .buttonStyle(BorderlessButtonStyle())
                        
                        
                        Button(action: {
                            viewModel.deleteData(foodRatingDelete: d)
                        }, label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            TextField("name", text: $name)
            TextField("rating", text: $rating)
            HStack{
                VStack{
                    Button {
                        if name != "" && rating != ""{
                            viewModel.addData(name: name, rating: Double(rating) ?? 0.0)
                            name = ""
                            rating = ""
                        }
                        else{
                            return
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50, alignment: .center)
                            .background(.blue)
                            .cornerRadius(20)
                    }
                    .onAppear() {
                        self.viewModel.getData()
                        
                    }
                }
            }
        }
    }
}
