import SwiftUI

struct SignIntoAcc: View {
    @State private var enteredName: String = ""
    @State private var enteredPassword: String = ""
    @State private var isAuthenticated: Bool = false

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
                    // text feilds
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
                        authenticateUser() // authenticates the user once pressed.
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
                        destination: AccountPage(userName: enteredName),
                        isActive: $isAuthenticated
                    ) {
                        EmptyView()
                    }
                }
                .padding()

            }
        }
    }
    
    
    
//checking to ensure the username and password is correct.
    private func authenticateUser() {
        let savedName = KeychainHelper.load(key: "name")
        let savedPassword = KeychainHelper.load(key: "password")

        if enteredName == savedName && enteredPassword == savedPassword {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
}

struct SignIntoAcc_Previews: PreviewProvider {
    static var previews: some View {
        SignIntoAcc()
            .previewDevice("iPhone 15")
    }
}
