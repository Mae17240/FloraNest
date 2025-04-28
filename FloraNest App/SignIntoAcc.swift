import SwiftUI

struct SignIntoAcc: View {
    @State private var enteredName: String = ""
    @State private var enteredPassword: String = ""
    @State private var isAuthenticated: Bool = false
    @State private var plantImage: UIImage? = nil
    @State private var lastScannedPlant: String = "No plant scanned yet" // Add this state variable

    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: -15) {
                    Text("Login to your account.")
                        .font(Font.custom("Fraunces", size: 30))
                        .padding(.bottom, 70)
                        .padding(.top, 50)
                    
                    Spacer()
                    // Text fields
                    TextField("Enter your name", text: $enteredName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                        .frame(height: 60)
                    
                    SecureField("Enter your password", text: $enteredPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                        .frame(height: 60)
                        .padding()
                    
                    Button(action: {
                        authenticateUser() // Authenticate the user
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .frame(width: 100)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(60)
                    }
                    .padding()
                    
                    NavigationLink(
                        destination: AccountPage(userName: enteredName, lastScannedPlant: lastScannedPlant), // Pass plant name
                        isActive: $isAuthenticated
                    ) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }
    
    // Authenticate user and retrieve plant name
    private func authenticateUser() {
        let savedName = KeychainHelper.load(key: "name")
        let savedPassword = KeychainHelper.load(key: "password")
        
        if enteredName == savedName && enteredPassword == savedPassword {
            isAuthenticated = true
            lastScannedPlant = KeychainHelper.load(key: "lastScannedPlant") ?? "No plant scanned yet" // Retrieve plant name
        } else {
            isAuthenticated = false
            print("Authentication failed.")
        }
    }
}


struct SignIntoAcc_Previews: PreviewProvider {
    static var previews: some View {
        SignIntoAcc()
            .previewDevice("iPhone 15")
    }
}
