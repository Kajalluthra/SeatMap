import SwiftUI
import UIComponents

struct LegendItem: View {
    
    let status: SeatStatus
    
    var body: some View {
        HStack(spacing: defaultPadding / 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .stroke(status.strokeColor, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .background(status.backgroundColor)
                    .frame(width: 12, height: 12)
                RoundedRectangle(cornerRadius: 2)
                    .foregroundStyle(status.foregroundColor)
                    .frame(width: 8, height: 8)
            }
            Text(status.legendText)
                .font(.label1XS)
                .foregroundStyle(ThemePalette.text.primary.one)
        }
    }
}

struct LegendItem_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            LegendItem(status: .selected)
            LegendItem(status: .free)
            LegendItem(status: .restricted)
        }
        .setupUIComponents()
    }
}
