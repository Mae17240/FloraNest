import SwiftUI

struct PlantFeedback: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("FNbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}



struct PlantFeedback_Previews: PreviewProvider {
    static var previews: some View {
        PlantFeedback()
            .previewDevice("iPhone 15")
    }
}


