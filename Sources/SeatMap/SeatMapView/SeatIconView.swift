import SwiftUI
import UIComponents

struct SeatIconView: View {
    let seat: Seat
    let defaultSeatSize: Size
    let isSelected: Bool
    
    var body: some View {
        let isWheelchairSeat = seat.type == .wheelchair
        let imageName = isWheelchairSeat ? "Wheelchair" : "Seat\(seat.direction.portraitValue)"
        let seatStatus = isSelected ? SeatStatus.selected : seat.status
        ZStack() {
            Image(imageName, bundle: Bundle.module)
                .resizable()
                .frame(width: CGFloat(defaultSeatSize.width), height: CGFloat(defaultSeatSize.height))
                .foregroundStyle(seatStatus.foregroundColor)
                .background(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(seatStatus.strokeColor, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        .background(seatStatus.backgroundColor)
                )
            let textColor = isWheelchairSeat ? getTextColor(for: seat.status) : ThemePalette.seatMaps.optionItems.secondaryIconOrText
            Text(seat.id)
                .foregroundStyle(textColor)
                .font(.label3S)
                .offset(x: isWheelchairSeat ? -defaultPadding / 2 : 0, y: isWheelchairSeat ? -defaultPadding / 2 : 0)
        }
    }
    
    private func getTextColor(for status: SeatStatus) -> Color {
        switch status {
        case .free, .selected:
            return ThemePalette.seatMaps.optionItems.primaryIconDefault
        case .restricted:
            return .clear
        }
    }
}

struct SeatIconView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            SeatIconView(seat: Seat(id: "1",
                                    status: .restricted,
                                    inventoryCode: "",
                                    direction: .left,
                                    type: .seat,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: true)
            SeatIconView(seat: Seat(id: "2",
                                    status: .free,
                                    inventoryCode: "",
                                    direction: .left,
                                    type: .seat,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
            SeatIconView(seat: Seat(id: "3",
                                    status: .restricted,
                                    inventoryCode: "",
                                    direction: .right,
                                    type: .seat,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
            SeatIconView(seat: Seat(id: "4",
                                    status: .free,
                                    inventoryCode: "",
                                    direction: .right,
                                    type: .seat,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
            SeatIconView(seat: Seat(id: "5",
                                    status: .free,
                                    inventoryCode: "",
                                    direction: .right,
                                    type: .wheelchair,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
            SeatIconView(seat: Seat(id: "6",
                                    status: .restricted,
                                    inventoryCode: "",
                                    direction: .right,
                                    type: .wheelchair,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
            SeatIconView(seat: Seat(id: "7",
                                    status: .free,
                                    inventoryCode: "",
                                    direction: .left,
                                    type: .wheelchair,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
            SeatIconView(seat: Seat(id: "8",
                                    status: .restricted,
                                    inventoryCode: "",
                                    direction: .left,
                                    type: .wheelchair,
                                    position: Position(x: 0, y: 0, width: nil, height: nil)),
                         defaultSeatSize: Size(width: 40, height: 40), isSelected: false)
        }
        .setupUIComponents()
    }
}
