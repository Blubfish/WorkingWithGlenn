//
//  getdata.swift
//  WorkingWithGlenn
//
//  Created by Gia Bao Ta on 10/26/23.
//
import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    @Published var list = [FoodRating]()
    private var db = Firestore.firestore()

    func getdata() {
        print("Here")
        db.collection("FoodList").addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
              print("No documents")
              return
            }
            self.list = documents.map { d -> FoodRating in
                let data = d.data()
                let rating = data["rating"] as? Int ?? 0
                print(rating)
                let name = data["name"] as? String ?? ""
                print(name)

                return FoodRating(id: .init(),rating: rating, name: name)                 }
        }
    }
}
