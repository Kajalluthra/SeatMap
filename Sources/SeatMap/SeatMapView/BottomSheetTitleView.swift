import SwiftUI
import UIComponents

struct BottomSheetTitleView: View {
    var body: some View {
        HStack {
            Text("selected.seat.details.title".localized)
                .font(.header4SemiBold)
                .foregroundStyle(ThemePalette.text.primary.two)
            Spacer()
            Image("Reservation", bundle: Bundle.module)
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

struct BottomSheetTitleView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetTitleView()
            .setupUIComponents()
    }
}
