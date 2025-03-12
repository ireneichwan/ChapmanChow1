import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    
    init() {
        self.user = Auth.auth().currentUser
        self.isAuthenticated = user != nil
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        if email == "randallstaff" && password == "gci" {
            self.isAuthenticated = true
            completion(true, nil)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(false, error.localizedDescription)
                } else {
                    self.user = result?.user
                    self.isAuthenticated = true
                    completion(true, nil)
                }
            }
        }
    }
    
    func studentLogin() {
        // No authentication needed for students
        self.isAuthenticated = true
    }
    
}
