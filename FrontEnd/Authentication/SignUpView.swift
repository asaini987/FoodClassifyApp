import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Create an Account")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: DrawingConstants.symWidth, height: DrawingConstants.symHeight)
                    .foregroundColor(.blue)
                
                Group {
                    TextField("Email Address", text: $email)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmedPassword)
                }
                .padding(.horizontal)
                .frame(height: DrawingConstants.fieldHeight)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(.black))
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                Spacer()
                
                signUpButton
            }
            .padding()
        }
        .navigationDestination(isPresented: $authViewModel.validAuth) {
            HomeView()
        }
        
    }
    
    var signUpButton: some View { //sign up button that validates user information
        Button {
            guard !email.isEmpty, !password.isEmpty, password == confirmedPassword else {
                return
            }
            Task {
                await authViewModel.signUp(email: self.email, password: self.password)
            }
            guard authViewModel.validAuth else {
                return
            }
        } label: {
            Text("Sign Up")
                .foregroundColor(.white)
                .font(.system(size: 20))
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
        static let fieldHeight: CGFloat = 55
        static let buttonHeight: CGFloat = 55
    }
}
