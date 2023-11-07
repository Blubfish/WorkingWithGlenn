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
                        Button {
                            viewModel.deleteData(foodRatingDelete: d)
                        } label: {
                            Text("Delete")
                                .frame(width: .infinity, height: 30, alignment: .center)
                                .foregroundColor(.white)
                                .background(.red)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            TextField("name", text: $name)
            TextField("rating", text: $rating)
            HStack{
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
