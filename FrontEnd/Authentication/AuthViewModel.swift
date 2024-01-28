import SwiftUI
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    
    init() {
        registerAuthStateHandler()
    }
    
    let currentUser = Auth.auth().currentUser
    @Published var user: User?
    @Published var validAuth = false
    
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    func registerAuthStateHandler() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            Task {
                await self.addUser(userId: user!.uid)
            }
        }
    }
    
    func addUser(userId: String) async {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: ["userId" : userId]) else {
            return
        }
        
        guard let url = URL(string: "http://example_API/insert_user") else {
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Sending request and decoding response
        do {
            let _ = try await URLSession.shared.upload(for: request, from: jsonData)
        } catch {
            print(error.localizedDescription)
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
