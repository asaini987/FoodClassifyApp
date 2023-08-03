import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationStack { //welcome screen to navigate to SignIn/SignUp views
            VStack {
                Image(systemName: "carrot.fill") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 450)
                    .foregroundColor(.green)
                goToSignIn
                    .padding(.bottom)
                goToSignUp
            }
        }
        .padding()
        .navigationTitle("Welcome To Recipe.AI")
    }
    
    var goToSignIn: some View {
        NavigationLink {
            SignUpView()
        } label: {
            Text("Sign Up for Free")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.blue)
                .cornerRadius(10)
        }
    }
    
    var goToSignUp: some View {
        NavigationLink {
            LoginView()
        } label: {
            Text("Already have an account? Sign in here")
        }
    }
    
}
