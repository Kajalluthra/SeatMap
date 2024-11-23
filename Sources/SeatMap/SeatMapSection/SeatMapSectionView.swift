import SwiftUI
import UIComponents
import UIComponentsFactory

public struct SeatMapSectionView: View {
    
    @State var showSeatSelector: Bool = false
    @State private var savedDeckId: String = ""
    private let vehicle: Vehicle
    private let originStationName: String
    private let destinationStationName: String
    @Binding var seatReservationSelected: Bool
    @Binding var savedCoachName: String
    @Binding var savedSeatNumber: String
    
    public init(vehicle: Vehicle,
                originStationName: String,
                destinationStationName: String,
                seatReservationSelected: Binding<Bool>,
                savedCoachName: Binding<String>,
                savedSeatNumber: Binding<String>) {
        self.vehicle = vehicle
        self.originStationName = originStationName
        self.destinationStationName = destinationStationName
        self._seatReservationSelected = seatReservationSelected
        self._savedCoachName = savedCoachName
        self._savedSeatNumber = savedSeatNumber
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            ViewFactory.originAndDestinationView(originStationName: originStationName, destinationStationName: destinationStationName, font: .display9)
                .padding(.horizontal, -defaultPadding)
            HStack {
                Text("seat.selection.reserve.seats.text".localized)
                    .foregroundStyle(ThemePalette.text.primary.one)
                    .font(.header4Light)
                Spacer()
                Toggle(isOn: $seatReservationSelected) {}
                    .toggleStyle(CheckboxStyle(strokeColor: ThemePalette.icons.universal.mid, backgroundColor: ThemePalette.icons.universal.mid))
            }
            HStack {
                Image("Reservation", bundle: Bundle.module)
                    .resizable()
                    .frame(width: 56, height: 56)
                if !savedSeatNumber.isEmpty {
                    VStack(alignment: .leading) {
                        Text(String.localizedStringWithFormat("coach.text".localized, savedCoachName))
                        Text(String.localizedStringWithFormat("seat.text".localized, savedSeatNumber))
                    }
                    .foregroundStyle(ThemePalette.text.primary.one)
                    .font(.tableContent2M)
                }
            }
            
            Text("choose.seats.text".localized)
                .foregroundStyle(ThemePalette.text.primary.one)
                .font(.header4Light)
            Button {
                showSeatSelector.toggle()
            } label: {
                Text("view.seat.selector.text".localized)
                    .font(.label2S)
                    .foregroundStyle(ThemePalette.text.primary.three)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding([.top, .bottom], defaultPadding)
            .padding([.trailing], defaultPadding / 2)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(ThemePalette.base.theme.primaryBackground)
                    .cornerRadius(4)
            )
        }
        .padding(defaultPadding)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .stroke(ThemePalette.base.containerStroke.defaultStroke, lineWidth: 1)
                .background(ThemePalette.base.containerFill.primary)
        )
        .padding([.leading, .trailing], defaultPadding)
        .sheet(isPresented: $showSeatSelector, content: {
            SeatMapScreen(vehicle: vehicle,
                          savedDeckId: $savedDeckId,
                          savedCoachName: $savedCoachName,
                          savedSeatNumber: $savedSeatNumber)
        })
    }
}

struct SeatMapSectionView_Previews_: PreviewProvider {
    static var previews: some View {
        SeatMapSectionView(vehicle: Vehicle(id: "", travelDirection: .left, coaches: [], changesDirectionOnRoute: false),
                                  originStationName: "London Bridge",
                                  destinationStationName: "Edinburgh",
                                  seatReservationSelected: .constant(false),
                                  savedCoachName: .constant(""),
                                  savedSeatNumber: .constant(""))
        .setupUIComponents()
    }
}
