import SwiftUI

struct AccountPage: View {
    var userName: String

    var body: some View {
        ZStack {

            Image("MainHome")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Welcome, \(userName)!") // takes the username from the keychain.
                    .font(Font.custom("Fraunces", size: 30))
                    .padding(.top, 50)
                
                Text("Your plant collection")
                    .font(Font.custom("Poppins", size: 15))

                Spacer()
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage(userName: "Test") // updates on physical iphone ! 
            .previewDevice("iPhone 15")
    }
}
