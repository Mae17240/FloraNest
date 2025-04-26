import SwiftUI
import Foundation
import Security

// MARK: - Keychain and keychain saving
struct KeychainHelper {
    static func save(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary
            SecItemDelete(query)
            SecItemAdd(query, nil)
        }
    }
    
    static func load(key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

// MARK: - ViewModel
class UserViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registrationSuccess = false
    
    func registerUser() async {
        guard validateInputs() else { return }
        
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        try? await Task.sleep(nanoseconds: 500_000_000) // Time delay.
        
        // Saving values to the keychain.
        KeychainHelper.save(key: "name", value: name)
        KeychainHelper.save(key: "email", value: email)
        KeychainHelper.save(key: "password", value: password)
        
        if let savedName = KeychainHelper.load(key: "name"),
           let savedEmail = KeychainHelper.load(key: "email"),
           let savedPassword = KeychainHelper.load(key: "password") {
            // output test
            print("Name: \(savedName)")
            print("Email: \(savedEmail)")
            print("Password: \(savedPassword)")
        }
        
        await MainActor.run {
            registrationSuccess = true
            isLoading = false
        }
    }
    
    //error messages.
    private func validateInputs() -> Bool {
        if name.isEmpty || email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        if !email.isValidEmail {
            errorMessage = "Please enter a valid email address"
            return false
        }
        
        if password.count < 8 {
            errorMessage = "Password must be at least 8 characters"
            return false
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords don't match"
            return false
        }
        
        return true
    }
}

// MARK: - SignUp (Main Page)
struct SignUpPage: View {
    @StateObject private var viewModel = UserViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.3))
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Create Account.")
                        .font(Font.custom("Fraunces", size: 30))
                        .foregroundColor(.white)
                    //placeholders.
                    Group {
                        CustomTextField(placeholder: "Full Name", text: $viewModel.name)
                        CustomTextField(placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                        CustomSecureField(placeholder: "Password", text: $viewModel.password)
                        CustomSecureField(placeholder: "Confirm Password", text: $viewModel.confirmPassword)
                    }
                    .frame(maxWidth: 300)
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 300)
                    }
                    
                    Spacer()
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                    } else {
                        Button(action: {
                            Task {
                                await viewModel.registerUser()
                            }
                        }) {
                            Text("Sign Up")
                                .font(Font.custom("Poppins-regular", size: 18))
                                .frame(width: 200, height: 50)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                NavigationLink(
                    destination: AccountPage(userName: viewModel.name),
                    isActive: $viewModel.registrationSuccess
                ) {
                    EmptyView()
                }
                .hidden()
            } //pop up window
            .alert("Registration Successful", isPresented: $viewModel.registrationSuccess) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your account has been created successfully!")
            }
        }
    }
}

// MARK: - Views
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    
    //placeholder mods.
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
    }
}


// fix textspace, is white on white when ran on iphone.
//separaed for passwords
struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
            .previewDevice("iPhone 15")
    }
}
