import SwiftUI
import FirebaseCore

@main
struct ChapmanChowApp: App {
    @StateObject var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                NavigationView {  // Ensure NavigationView is here
                    HomeView()
                }
                .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
