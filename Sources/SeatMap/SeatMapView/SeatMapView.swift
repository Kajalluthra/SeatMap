import SwiftUI
import UIComponents

struct SeatMapView: View {
    let margin: CGFloat = 4.0
    let deck: Deck
    let travelDirection: TravelDirection
    @Binding var selectedSeatNumber: String
    
    var body: some View {
        VStack(spacing: defaultPadding / 2) {
            LegendView(direction: travelDirection)
            SeatMapGridView(deck: deck, selectedSeatNumber: $selectedSeatNumber)
                .frame(width: CGFloat(deck.floorPlanSize?.width ?? 0), height: CGFloat(deck.floorPlanSize?.height ?? 0))
                .padding(margin)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(ThemePalette.seatMaps.floor.coachStroke)
                        .background(ThemePalette.base.containerFill.primary)
                )
        }
    }
}

struct SeatMapView_Previews_: PreviewProvider {
    static var previews: some View {
        return Group {
            preview(coachNumber: 0)
            preview(coachNumber: 1)
            preview(coachNumber: 2)
            preview(coachNumber: 3)
            preview(coachNumber: 4)
        }
        .setupUIComponents()
    }
    
    static private func preview(coachNumber: Int) -> some View {
        let data = Utils.loadJSON(name: "SeatMapResponseExample")
        let seatMapResponse = try? JSONDecoder().decode(SeatMapResponse.self, from: data)
        let deck = seatMapResponse?.vehicle.coaches[coachNumber].decks.first ?? Deck.fixture()
        return ScrollView {
            SeatMapView(deck: deck, travelDirection: .left, selectedSeatNumber: .constant(""))
        }
    }
}
