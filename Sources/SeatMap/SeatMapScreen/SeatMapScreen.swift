import SwiftUI
import UIComponents
import UIComponentsFactory

public struct SeatMapScreen: View {
    @Environment(\.presentationMode) var presentation
    let vehicle: Vehicle
    @State var selectedDeckId: String = ""
    @State var selectedCoachName: String = ""
    @State var selectedSeatNumber: String = ""
    @Binding var savedDeckId: String
    @Binding var savedCoachName: String
    @Binding var savedSeatNumber: String
    @State private var collapsedTrainViewHidden = true
    @State var passengerCoaches: [Coach] = []
    @State var bottomHeight: CGFloat = 0.0
    
    public init(vehicle: Vehicle, 
                savedDeckId: Binding<String>,
                savedCoachName: Binding<String>,
                savedSeatNumber: Binding<String>) {
        self.vehicle = vehicle
        self._savedDeckId = savedDeckId
        self._savedCoachName = savedCoachName
        self._savedSeatNumber = savedSeatNumber
    }
    
    public var body: some View {
        ThemePalette.base.containerFill.primary
            .ignoresSafeArea()
            .overlay(
                ZStack(alignment: .bottom) {
                    VStack {
                        VStack(alignment: .leading) {
                            ViewFactory.cancelButton {
                                self.presentation.wrappedValue.dismiss()
                            }
                            .padding(.bottom, defaultPadding)
                            Text("seat.selection.title".localized)
                                .font(.header4SemiBold)
                                .foregroundStyle(ThemePalette.text.primary.two)
                        }
                        ZStack(alignment: .top) {
                            ScrollView {
                                VStack(alignment: .center, spacing: defaultPadding) {
                                    HStack {
                                        Text("select.coach.explanation.text".localized)
                                            .font(.paragraphP3Light)
                                            .foregroundStyle(ThemePalette.text.primary.one)
                                        Spacer()
                                    }
                                    TrainView(vehicle: vehicle,
                                              selectedDeckId: $selectedDeckId,
                                              selectedCoachName: $selectedCoachName)
                                    HStack {
                                        Text("select.seat.explanation.text".localized)
                                            .font(.paragraphP3Light)
                                            .foregroundStyle(ThemePalette.text.primary.one)
                                        Spacer()
                                    }
                                    SeatMapPagerView(travelDirection: vehicle.travelDirection,
                                                     passengerCoaches: passengerCoaches,
                                                     selectedSeatNumber: $selectedSeatNumber,
                                                     selectedDeckId: $selectedDeckId,
                                                     selectedCoachName: $selectedCoachName)
                                }
                                .coordinateSpace(name: "scroll")
                                .background(GeometryReader {
                                    Color.clear.preference(key: ViewOffsetKey.self,
                                                           value: -$0.frame(in: .named("scroll")).origin.y)
                                })
                                .onPreferenceChange(ViewOffsetKey.self) {
                                    if !collapsedTrainViewHidden && $0 < 25 {
                                        withAnimation() {
                                            collapsedTrainViewHidden = true
                                        }
                                    } else if collapsedTrainViewHidden && $0 > 25 {
                                        withAnimation() {
                                            collapsedTrainViewHidden = false
                                        }
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            .padding(.bottom, selectedSeatNumber.isEmpty ? bottomHeight : bottomHeight * 2)
                            .onAppear(perform: {
                                selectedDeckId = savedDeckId.isEmpty ? vehicle.coaches.first?.decks.first?.cacheId ?? "" : savedDeckId
                                selectedCoachName = savedCoachName.isEmpty ? vehicle.coaches.first?.id ?? "" : savedCoachName
                                selectedSeatNumber = savedSeatNumber.isEmpty ? "" : savedSeatNumber
                                passengerCoaches = vehicle.coaches.filter({
                                    $0.decks.first?.function == .Passenger || $0.decks.first?.function == .Unspecified
                                })
                            })
                            if !collapsedTrainViewHidden {
                                VStack {
                                    CollapsedTrainView(vehicle: vehicle, selectedDeckId: $selectedDeckId, selectedCoachName: $selectedCoachName)
                                        .frame(height: 54)
                                    ViewFactory.customHorizontalDivider(color: ThemePalette.base.containerStroke.divider)
                                        .shadow(color: ThemePalette.base.containerStroke.divider, radius: 4, x: 0, y: 0)
                                        .padding(.horizontal, -defaultPadding)
                                }
                                .background(ThemePalette.base.containerFill.primary)
                            }
                        }
                        
                    }
                    .padding(defaultPadding)
                    ZStack(alignment: .bottom) {
                        if !selectedSeatNumber.isEmpty {
                            BottomSheetView(coachName: $selectedCoachName, seatNumber: $selectedSeatNumber)
                        }
                        VStack {
                            ViewFactory.customHorizontalDivider(color: ThemePalette.base.containerStroke.divider)
                                .shadow(color: ThemePalette.base.containerStroke.divider, radius: 4, x: 0, y: 0)
                            Button(action: {
                                savedCoachName = selectedCoachName
                                savedSeatNumber = selectedSeatNumber
                                savedDeckId = selectedDeckId
                                self.presentation.wrappedValue.dismiss()
                            }, label: {
                                Text("save.seat.button".localized)
                            })
                            .buttonStyle(SecondaryDarkButtonStyle())
                        }
                        .edgesIgnoringSafeArea(.all)
                        .background(
                            GeometryReader { proxy in
                                ThemePalette.base.containerFill.primary
                                    .ignoresSafeArea()
                                    .preference(key: BottomViewHeightKey.self, value: proxy.size.height)
                            }
                        )
                    }
                    .onPreferenceChange(BottomViewHeightKey.self) { height in
                        bottomHeight = height
                    }
                }
            )
            .trackScreen("SeatMapScreen")
    }
    
    private func getSelectedDeck() -> Deck? {
        let decksPerCoach = vehicle.coaches.map { $0.decks }
        let decksJoined = decksPerCoach.joined()
        let deck = decksJoined.first { $0.cacheId == selectedDeckId }
        return deck
    }
}

struct SeatMapScreen_Previews_: PreviewProvider {
    static var previews: some View {
        SeatMapScreen(vehicle: Vehicle(id: "", travelDirection: .left, coaches: [], changesDirectionOnRoute: false), 
                      savedDeckId: .constant(""),
                      savedCoachName: .constant(""),
                      savedSeatNumber: .constant(""))
        .setupUIComponents()
    }
}
