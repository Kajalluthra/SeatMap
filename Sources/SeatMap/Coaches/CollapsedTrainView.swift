import SwiftUI
import UIComponents

struct CollapsedTrainView: View {
    
    let vehicle: Vehicle
    @Binding var selectedDeckId: String
    @Binding var selectedCoachName: String
    
    var body: some View {
        let coaches: [Coach] = vehicle.coaches
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 32) {
                    ForEach(coaches, id: \.id) { coach in
                        let deck: Deck? = coach.decks.first
                        if deck?.function == .Passenger || deck?.function == .Unspecified {
                            CollapsedCoachView(coach: coach,
                                               isSelected: deck?.cacheId == selectedDeckId)
                            .onTapGesture {
                                guard let deck: Deck = deck, coach.seatSelectionAvailable else { return }
                                selectedDeckId = deck.cacheId
                                selectedCoachName = coach.id
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, alignment: .center)
                .frame(minHeight: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(ThemePalette.base.containerStroke.defaultStroke, lineWidth: 1)
                    .frame(width: geometry.size.width, height: 32)
                    .padding(.top, -20)
            }
        }
    }
}

struct CollapsedTrainView_Previews_: PreviewProvider {
    static var previews: some View {
        let coaches = [
            Coach(id: "A1", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id1", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "A2", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "id2", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "A3", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id3", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
        ]
        let vehicle = Vehicle(id: "", travelDirection: .left, coaches: coaches, changesDirectionOnRoute: false)
        CollapsedTrainView(vehicle: vehicle, selectedDeckId: .constant(""), selectedCoachName: .constant(""))
            .setupUIComponents()
    }
}
