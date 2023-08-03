import SwiftUI
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    
    init() {
        registerAuthStateHandler()
    }
    
    @Published var user: User?
    @Published var validAuth = false
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    func registerAuthStateHandler() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
        }
    }
    
    //MARK: Intents
    
    func signIn(email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            validAuth = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            validAuth = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() async {
        do {
            try await user?.delete()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
