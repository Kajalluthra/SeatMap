import SwiftUI
import UIComponents

struct DoubleCoachView: View {
    let coach: Coach
    @Binding var selectedDeckId: String
    @Binding var selectedCoachName: String
    @State private var deckPrefixText: String = ""
    
    var body: some View {
        VStack(spacing: 3) {
            let isAvailable: Bool = coach.seatSelectionAvailable
            let decks: [Deck] = coach.decks
            
            ForEach(decks, id: \.cacheId) { deck in
                let isSelected: Bool = selectedDeckId == deck.cacheId
                let imageName: String = deck.function.getImageName(isSingleCoach: false)
                Image(imageName, bundle: Bundle.module)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(
                                isSelected ? ThemePalette.base.containerStroke.focus : Color.clear,
                                lineWidth: 1
                            )
                            .shadow(color: isSelected ? ThemePalette.base.containerStroke.focus : Color.clear, radius: 2, x: 0, y: 0)
                            .padding(-1)
                    )
                    .onTapGesture {
                        guard deck.function == DeckFunction.Passenger || deck.function == DeckFunction.Unspecified, coach.seatSelectionAvailable else { return }
                        selectedDeckId = deck.cacheId
                        deckPrefixText = decks.first?.cacheId ?? "" == deck.cacheId ? "upper.text".localized : "lower.text".localized
                        selectedCoachName = deckPrefixText + " " + coach.id
                    }
            }
            Text(selectedCoachName)
                .foregroundStyle(ThemePalette.text.primary.one)
                .font(.label1XS)
        }
        .onChange(of: selectedDeckId) { newValue in
            guard !coach.decks.contains(where: { deck in
                deck.cacheId == newValue
            }) else { return }
            deckPrefixText = ""
        }
    }
}

struct DoubleCoachView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            DoubleCoachView(coach: Coach(id: "A1", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "Up1", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: []), Deck(numAvailableSeats: 30, cacheId: "Up2", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]), selectedDeckId: .constant(""), selectedCoachName: .constant(""))
            DoubleCoachView(coach: Coach(id: "A2", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "id3", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: []), Deck(numAvailableSeats: 30, cacheId: "id4", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]), selectedDeckId: .constant(""), selectedCoachName: .constant(""))
            DoubleCoachView(coach: Coach(id: "A3", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id5", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: []), Deck(numAvailableSeats: 30, cacheId: "id6", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]), selectedDeckId: .constant("id5"), selectedCoachName: .constant(""))
            DoubleCoachView(coach: Coach(id: "Drinks", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id7", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Bar, seats: [], layoutItems: [])]), selectedDeckId: .constant(""), selectedCoachName: .constant(""))
            DoubleCoachView(coach: Coach(id: "Dining", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id8", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Dining, seats: [], layoutItems: [])]), selectedDeckId: .constant(""), selectedCoachName: .constant(""))
        }
        .setupUIComponents()
    }
}
