import SwiftUI

struct SeatMapPagerView: View {
    @State var tabSelection: Int = 0
    let travelDirection: TravelDirection
    let passengerCoaches: [Coach]
    @Binding var selectedSeatNumber: String
    @Binding var selectedDeckId: String
    @Binding var selectedCoachName: String
    
    private var allCoaches: some View {
        ForEach(Array(passengerCoaches.enumerated()), id: \.offset) { index, coach in
            if let deck = coach.decks.first {
                SeatMapView(deck: deck,
                            travelDirection: travelDirection,
                            selectedSeatNumber: $selectedSeatNumber)
                
                .tag(index)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) { //This is used to allow the tab view to get the proper frame. Without this it would need an explicit frame but each seat map view has a different one
            allCoaches
                .onAppear {
                    updateTabSelection()
                }
        }
        .frame(maxWidth: .infinity)
        .hidden()
        .overlay {
            TabView(selection: $tabSelection) {
                allCoaches
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .onChange(of: tabSelection, perform: { _ in
                let selectedCoach = passengerCoaches[tabSelection]
                selectedDeckId = selectedCoach.decks.first?.cacheId ?? ""
                selectedCoachName = selectedCoach.id
            })
            .onChange(of: selectedCoachName, perform: { _ in
                updateTabSelection()
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    private func updateTabSelection() {
        tabSelection = passengerCoaches.firstIndex(where: { $0.id == selectedCoachName }) ?? 0
    }
}

struct SeatMapPagerView_Previews_: PreviewProvider {
    static var previews: some View {
        let data = Utils.loadJSON(name: "SeatMapResponseExample")
        let seatMapResponse = try? JSONDecoder().decode(SeatMapResponse.self, from: data)
        let coaches = seatMapResponse?.vehicle.coaches
        let passengerCoaches = coaches?.filter { $0.decks.first?.function == .Passenger || $0.decks.first?.function == .Unspecified } ?? []
        SeatMapPagerView(travelDirection: .left,
                         passengerCoaches: passengerCoaches,
                         selectedSeatNumber: .constant(""),
                         selectedDeckId: .constant(""),
                         selectedCoachName: .constant(""))
        .setupUIComponents()
    }
}
