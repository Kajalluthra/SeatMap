import SwiftUI
import UIComponents

struct SeatMapGridView: View {
    let deck: Deck
    @Binding var selectedSeatNumber: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ThemePalette.seatMaps.floor.neutral
            getSeats()
            getLayoutItems()
        }
        .frame(maxWidth: .infinity)
    }
    
    private func getSeats() -> some View {
        return Group {
            ForEach(deck.seats, id: \.id) { seat in
                SeatIconView(seat: seat, defaultSeatSize: deck.defaultSeatSize ?? Size(width: 0, height: 0), isSelected: selectedSeatNumber == seat.id)
                    .offset(x: CGFloat(seat.position.x), y: CGFloat(seat.position.y))
                    .onTapGesture {
                        guard seat.status != .restricted else { return }
                        guard selectedSeatNumber != seat.id else {
                            selectedSeatNumber = ""
                            return
                        }
                        selectedSeatNumber = seat.id
                    }
            }
        }
    }
    
    
    private func getLayoutItems() -> some View {
        return Group {
            ForEach(deck.layoutItems, id: \.self) { layoutItem in
                if layoutItem.type == .exit {
                    getExitsView(layoutItem)
                } else {
                    LayoutItemView(layoutItem: layoutItem, defaultSeatSize: deck.defaultSeatSize ?? Size(width: 0, height: 0))
                        .offset(x: CGFloat(layoutItem.position.x), y: CGFloat(layoutItem.position.y))
                }
            }
        }
    }
    
    private func getExitsView(_ layoutItem: LayoutItem) -> some View {
        let layoutItemType: LayoutItemType = layoutItem.position.x < ((deck.floorPlanSize?.width ?? 0) / 2) ? .exit : .exitRight
        let updatedLayoutItem = LayoutItem(type: layoutItemType, position: layoutItem.position)
        return LayoutItemView(layoutItem: updatedLayoutItem, defaultSeatSize: deck.defaultSeatSize ?? Size(width: 0, height: 0))
            .offset(x: CGFloat(layoutItem.position.x), y: CGFloat(layoutItem.position.y))
    }
}


struct SeatMapGridView_Previews_: PreviewProvider {
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
            SeatMapGridView(deck: deck, selectedSeatNumber: .constant(""))
        }
    }
}
