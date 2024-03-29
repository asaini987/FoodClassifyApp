import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: DrawingConstants.symWidth, height: DrawingConstants.symHeight)
                    .foregroundColor(.blue)
                
                Text("Sign In")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                
                Group {
                    TextField("Email Address", text: $email)
                    SecureField("Password", text: $password)
                }
                .fontWeight(.medium)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .overlay(RoundedRectangle(cornerRadius: DrawingConstants.fieldCornerRadius).strokeBorder(lineWidth: DrawingConstants.fieldLineWidth))
                
                Spacer()
                
                logInButton
            }
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $authViewModel.validAuth) {
            Text("You have successfully signed in")
        }
    }
    
    var logInButton: some View {
        Button {
            guard !email.isEmpty && !password.isEmpty else {
                return
            }
            Task {
                await authViewModel.signIn(email: email, password: password)
            }
            guard authViewModel.validAuth else {
                return
            }
        } label: {
            Text("Login")
                .foregroundColor(.white)
                .font(.system(size: DrawingConstants.buttonFont))
                .fontWeight(.medium)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: DrawingConstants.buttonHeight)
                .background(.blue)
                .clipShape(Capsule())
        }
    }
    
    private struct DrawingConstants {
        static let symWidth: CGFloat = 150
        static let symHeight: CGFloat = 200
        static let fieldCornerRadius: CGFloat = 10
        static let fieldLineWidth: CGFloat = 1
        static let buttonFont: CGFloat = 20
        static let buttonHeight: CGFloat = 55
    }
}
