import SwiftUI
import UIComponents

struct LegendView: View {
    
    let direction: TravelDirection
    
    var body: some View {
        VStack(alignment: .center, spacing: defaultPadding / 2) {
            HStack(spacing: defaultPadding / 4) {
                Text("direction.of.travel.text".localized)
                    .font(.label1XS)
                    .foregroundStyle(ThemePalette.text.primary.one)
                Image("Arrow", bundle: Bundle.module)
                    .resizable()
                    .rotationEffect(direction == .left ? .degrees(-90) : .degrees(90))
                    .frame(width: 12, height: 12)
                    .foregroundStyle(ThemePalette.icons.universal.strong)
            }
            HStack {
                LegendItem(status: .selected)
                LegendItem(status: .free)
                LegendItem(status: .restricted)
            }
        }
    }
}

struct LegendView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            LegendView(direction: .left)
            LegendView(direction: .right)
        }
        .setupUIComponents()
    }
}
