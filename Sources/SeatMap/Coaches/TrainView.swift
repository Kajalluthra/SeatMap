import SwiftUI
import UIComponents

public struct TrainView: View {
    
    let vehicle: Vehicle
    @Binding var selectedDeckId: String
    @Binding var selectedCoachName: String
    let defaultOffset: CGFloat = 5
    
    public var body: some View {
        let coaches = vehicle.coaches
        let isDoubleTrain = vehicle.isDouble
        let singleOrDoublePrefix = isDoubleTrain ? "Double" : "Single"
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    VStack(spacing: isDoubleTrain ? 3 : defaultPadding) {
                        Image("\(singleOrDoublePrefix)DeckRear", bundle: Bundle.module)
                            .offset(y: defaultOffset)
                            .foregroundStyle(ThemePalette.seatMaps.optionItems.primaryIconDefault)
                        Text("rear.text".localized)
                            .foregroundStyle(ThemePalette.text.primary.one)
                            .font(.label1XS)
                    }
                    
                    ForEach(coaches, id: \.id) { coach in
                        if isDoubleTrain {
                            DoubleCoachView(coach: coach, selectedDeckId: $selectedDeckId, selectedCoachName: $selectedCoachName)
                                .id(coach.id)
                        } else {
                            let deck = coach.decks.first
                            CoachView(coach: coach,
                                      isSelected: deck?.cacheId == selectedDeckId)
                            .id(coach.id)
                            .onTapGesture {
                                guard let deck = deck, deck.function == .Passenger || deck.function == .Unspecified, coach.seatSelectionAvailable else { return }
                                selectedDeckId = deck.cacheId
                                selectedCoachName = coach.id
                            }
                        }
                    }
                    
                    VStack(spacing: isDoubleTrain ? 3 : defaultPadding) {
                        Image("\(singleOrDoublePrefix)DeckFront", bundle: Bundle.module)
                            .offset(y: defaultOffset)
                            .foregroundStyle(ThemePalette.seatMaps.optionItems.primaryIconDefault)
                        Text("front.text".localized)
                            .foregroundStyle(ThemePalette.text.primary.one)
                            .font(.label1XS)
                    }
                }
            }
            .onChange(of: selectedCoachName) { _ in
                value.scrollTo(selectedCoachName)
            }
        }
    }
}

struct TrainView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            getSingleTrainView()
            getDoubleTrainView()
        }
        .setupUIComponents()
    }
    
    private static func getSingleTrainView() -> some View {
        let coaches = [
            Coach(id: "A1", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id1", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "A2", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "id2", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "A3", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id3", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "Drinks", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id4", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Bar, seats: [], layoutItems: [])]),
            Coach(id: "Dining", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id5", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Dining, seats: [], layoutItems: [])])
        ]
        let vehicle = Vehicle(id: "", travelDirection: .left, coaches: coaches, changesDirectionOnRoute: false)
        return TrainView(vehicle: vehicle, selectedDeckId: .constant(""), selectedCoachName: .constant(""))
    }
    
    private static func getDoubleTrainView() -> some View {
        let coaches = [
            Coach(id: "A1", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "Up1", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: []), Deck(numAvailableSeats: 30, cacheId: "Up2", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "A2", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "id3", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: []), Deck(numAvailableSeats: 30, cacheId: "id4", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "A3", seatSelectionAvailable: true, decks: [Deck(numAvailableSeats: 30, cacheId: "id5", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: []), Deck(numAvailableSeats: 30, cacheId: "id6", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Passenger, seats: [], layoutItems: [])]),
            Coach(id: "Drinks", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "id7", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Bar, seats: [], layoutItems: [])]),
            Coach(id: "Dining", seatSelectionAvailable: false, decks: [Deck(numAvailableSeats: 30, cacheId: "id8", floorPlanSize: Size(width: 50, height: 50), defaultSeatSize: Size(width: 50, height: 50), function: .Dining, seats: [], layoutItems: [])])
        ]
        let vehicle = Vehicle(id: "", travelDirection: .left, coaches: coaches, changesDirectionOnRoute: false)
        return TrainView(vehicle: vehicle, selectedDeckId: .constant(""), selectedCoachName: .constant(""))
    }
}
