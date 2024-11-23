import SwiftUI
import UIComponents

struct CollapsedCoachView: View {
    let coach: Coach
    var isSelected: Bool = false
    let margin: CGFloat = 1
    
    var body: some View {
        VStack(spacing: defaultPadding) {
            let deck = coach.decks.first
            if deck?.function == .Passenger {
                let isAvailable = coach.seatSelectionAvailable
                let imageName = isSelected ? "SelectedCoachCollapsed" : "CoachCollapsed"
                if isSelected {
                    Image(imageName, bundle: Bundle.module)
                        .background(
                            Circle()
                                .stroke(
                                    isSelected ? ThemePalette.base.containerStroke.focus : Color.clear,
                                    lineWidth: 1
                                )
                                .shadow(color: isSelected ? ThemePalette.base.containerStroke.focus : Color.clear, radius: 2, x: 0, y: 0)
                                .padding(-1)
                        )
                        .offset(y: margin + 2)
                } else {
                    Image(imageName, bundle: Bundle.module)
                        .foregroundStyle(isAvailable ? ThemePalette.seatMaps.optionItems.primaryIconDefault : ThemePalette.seatMaps.optionItems.primaryIconUnavailable)
                        .offset(y: margin + 2)
                }
                
                Text(coach.id)
                    .foregroundStyle(ThemePalette.text.primary.one)
                    .font(.label1XS)
            }
        }
    }
}

struct CollapsedCoachView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            CollapsedCoachView(coach: Coach(id: "A1", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]))
            CollapsedCoachView(coach: Coach(id: "A2", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]))
            CollapsedCoachView(coach: Coach(id: "A3", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]), isSelected: true)
            CollapsedCoachView(coach: Coach(id: "Drinks", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Bar, seats: [], layoutItems: [])]))
            CollapsedCoachView(coach: Coach(id: "Dining", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Dining, seats: [], layoutItems: [])]))
        }
        .setupUIComponents()
    }
}
