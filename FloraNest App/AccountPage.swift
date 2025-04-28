import SwiftUI

struct AccountPage: View {
    var userName: String
    var lastScannedPlant: String
    @State private var showRectangle = false // set to false.

    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Text("Welcome \(userName)")
                        .font(Font.custom("Fraunces", size: 30))
                        .padding(.top, 50)

                    Text(" To your plant collection.")
                        .font(Font.custom("Poppins", size: 15))

                    if showRectangle {
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 180)
                                .foregroundStyle(Color.black)
                                .cornerRadius(20)
                                .opacity(0.9)
                                .padding(.top, 50)
                                .transition(.slide)

                            Text("\(lastScannedPlant).")
                            // displays the last scanned plant
                                .font(Font.custom("Fraunces", size: 30))
                                .foregroundStyle(Color.white)
                                .frame(width: 250, height: 100)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .padding(.top, -30)

                            Text("Congratulations on collecting your first plant!")
                                .font(Font.custom("Fraunces", size: 20))
                                .frame(width: 250, height: 60)
                                .padding(.top, 150)
                                .padding(.leading, -50)
                                .foregroundStyle(Color.white)
                        }
                    }

                    Spacer()

                    HStack {
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                            Image("HomeBtn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal, 80)

                        NavigationLink(destination: MapData().navigationBarBackButtonHidden(true)) {
                            Image("MapIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal, 80)
                    }
                }
            }
            .onAppear {
                withAnimation {
                    showRectangle = true // Automatically show the rectangle on page load
                }
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage(userName: "test", lastScannedPlant: "Your first plant")
            .previewDevice("iPhone 15")
    }
}
