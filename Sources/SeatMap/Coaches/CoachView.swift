import SwiftUI
import UIComponents

struct CoachView: View {
    let coach: Coach
    var isSelected: Bool = false
    let margin: CGFloat = 3
    
    var body: some View {
        VStack(spacing: defaultPadding) {
            let deck = coach.decks.first
            let isAvailable = coach.seatSelectionAvailable
            let imageName = deck?.function.rawValue ?? ""
            ZStack {
                Image("SingleCoachBackground", bundle: Bundle.module)
                    .foregroundStyle(getIconColor(isSelected: isSelected, isAvailable: isAvailable))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(
                                isSelected ? ThemePalette.seatMaps.optionItems.strokeSelected : Color.clear,
                                lineWidth: 1
                            )
                            .shadow(color: isSelected ? ThemePalette.seatMaps.optionItems.strokeSelected : Color.clear, radius: 2, x: 0, y: 0)
                            .padding(-margin)
                    )
                Image(imageName, bundle: Bundle.module)
                    .foregroundStyle(ThemePalette.seatMaps.optionItems.secondaryIconOrText)
                    .offset(y: deck?.function == .Passenger ? -(margin + 2) : 0)
            }
            .offset(y: margin + 2)
            Text(coach.id)
                .foregroundStyle(ThemePalette.text.primary.one)
                .font(.label1XS)
        }
    }
    
    private func getIconColor(isSelected: Bool, isAvailable: Bool) -> Color {
        guard isAvailable else {
            return ThemePalette.seatMaps.optionItems.primaryIconUnavailable
        }
        guard isSelected else {
            return ThemePalette.seatMaps.optionItems.primaryIconDefault
        }
        return ThemePalette.seatMaps.optionItems.primaryIconSelected
    }
}

struct CoachView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            CoachView(coach: Coach(id: "A1", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]))
            CoachView(coach: Coach(id: "A2", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]))
            CoachView(coach: Coach(id: "A3", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]), isSelected: true)
            CoachView(coach: Coach(id: "Drinks", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Bar, seats: [], layoutItems: [])]))
            CoachView(coach: Coach(id: "Dining", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Dining, seats: [], layoutItems: [])]))
        }
        .setupUIComponents()
    }
}
