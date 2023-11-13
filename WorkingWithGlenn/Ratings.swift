import SwiftUI
import Firebase

struct Ratings: View {
    @ObservedObject var database = Database()
    @State var name: String = ""
    @State var rating: String = ""
    
    var body: some View {
        VStack {
            Text("Food Rater")
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
        HStack{
            Image("food1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Image("food2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Image("food3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Image("food4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
               
        }
        
        VStack{
            List{
                ForEach(database.list) { data in
                    HStack{
                        Text("\(data.name):")
                        Text("\(String(data.rating))/10")
                        Spacer()
                        
                        Button(action: {
                            if name != "" && rating != ""{
                                database.updateData(FoodListUpdate: data, name: name, rating: Double(rating) ?? 0.0)
                                name = ""
                                rating = ""
                            }
                        }, label: {
                            Image(systemName: "pencil")
                        })
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            database.deleteData(foodRatingDelete: data)
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
                            database.addData(name: name, rating: Double(rating) ?? 0.0)
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
                        self.database.getData()
                    }
                }
            }
        }
    }
}
