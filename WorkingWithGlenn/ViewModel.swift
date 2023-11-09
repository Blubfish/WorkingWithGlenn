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
    
    
    func addData(name: String, rating: Double) {
        
        let db = Firestore.firestore()
        db.collection("FoodList").addDocument(data: ["name":name, "rating":rating]) { error in
            if error == nil {
                self.getData()
            }
            else {
                print("Error")
                return
            }
        }
    }
    
    func updateData(FoodListUpdate: FoodRating, name: String, rating: Double) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to update
        db.collection("FoodList").document(FoodListUpdate.id).setData(["name":name], merge: true) { error in
            db.collection("FoodList").document(FoodListUpdate.id).setData(["rating":rating], merge: true) { error in
                if error == nil{
                    self.getData()
                }
            }
        }
    }
    
    
    func deleteData(foodRatingDelete: FoodRating){
        db.collection("FoodList").document(foodRatingDelete.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.getData()
            }
        }
    }
    
    func getData() {
        db.collection("FoodList").addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            self.list = documents.map { d -> FoodRating in
                let data = d.data()
                let id = d.documentID
                let rating = data["rating"] as? Double ?? 0.0
                print(rating)
                let name = data["name"] as? String ?? ""
                print(name)
                
                return FoodRating(id: id ,rating: rating, name: name)                 }
        }
    }
}
