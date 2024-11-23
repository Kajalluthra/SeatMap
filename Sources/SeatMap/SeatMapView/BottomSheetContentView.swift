import SwiftUI
import UIComponents
import UIComponentsFactory

struct BottomSheetContentView: View {
    @Binding var coachName: String
    @Binding var seatNumber: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image("Notch", bundle: Bundle.module)
            VStack(alignment: .leading) {
                BottomSheetTitleView()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(String.localizedStringWithFormat("coach.text".localized, coachName))
                            .font(.tableContent1L)
                            .foregroundStyle(ThemePalette.text.primary.one)
                        HStack(alignment: .bottom) {
                            Text(String.localizedStringWithFormat("seat.text".localized, seatNumber))
                                .font(.tableContent1L)
                                .foregroundStyle(ThemePalette.text.primary.one)
                            Text("")
                                .font(.tableContent4S)
                                .foregroundStyle(ThemePalette.text.primary.three)
                        }
                    }
                }
            }
        }
        .padding(defaultPadding)
        .background(
            ThemePalette.base.containerFill.primary
                .overlay(
                    ViewFactory.roundedCorner(radius: 30, corners: [.topLeft, .topRight])
                        .stroke(ThemePalette.base.containerStroke.defaultStroke, lineWidth: 1)
                )
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .shadow(color: ThemePalette.base.containerFill.dominant, radius: 2, x: 0, y: 2)
        )
    }
}

struct BottomSheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContentView(coachName: .constant("A"), seatNumber: .constant("44"))
            .setupUIComponents()
    }
}
