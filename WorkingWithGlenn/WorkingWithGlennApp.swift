import SwiftUI
import Firebase
@main

struct WorkingWithGlennApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
