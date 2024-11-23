import SwiftUI
import UIComponents

struct LayoutItemView: View {
    
    let layoutItem: LayoutItem
    let defaultSeatSize: Size
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            switch layoutItem.type {
            case .luggageRoom, .luggageRack, .bathroom, .babyChangeBathroom, .accessibleBabyChangeBathroom, .accessibleBathroom, .wall:
                Image(layoutItem.type.imageName, bundle: Bundle.module)
                    .foregroundStyle(ThemePalette.seatMaps.amenities.one)
                    .background(
                        Image("EmptyTile", bundle: Bundle.module)
                            .resizable()
                            .frame(width: CGFloat(layoutItem.position.width ?? 0), height: CGFloat(layoutItem.position.height ?? 0), alignment: .center)
                            .foregroundStyle(ThemePalette.seatMaps.floor.content)
                    )
            case .table:
                Image(layoutItem.type.imageName, bundle: Bundle.module)
                    .resizable()
                    .frame(width: CGFloat(defaultSeatSize.width), height: CGFloat(defaultSeatSize.height))
                    .foregroundStyle(ThemePalette.seatMaps.optionItems.primaryIconDefault)
            case .exit, .exitRight:
                let colorSchemeText = colorScheme == .dark ? "Dark" : "Light"
                Image(layoutItem.type.imageName + colorSchemeText, bundle: Bundle.module)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(ThemePalette.seatMaps.amenities.one)
            case .stairs:
                Image(layoutItem.type.imageName, bundle: Bundle.module)
                    .resizable()
                    .scaledToFit()
            case .unknown, .other:
                Image(layoutItem.type.imageName, bundle: Bundle.module)
                    .resizable()
                    .padding(1)
                    .foregroundStyle(ThemePalette.seatMaps.floor.content)
            default:
                EmptyView()
            }
        }
        .frame(width: CGFloat(layoutItem.position.width ?? 0), height: CGFloat(layoutItem.position.height ?? 0), alignment: .center)
    }
}

struct LayoutItemView_Previews_: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                LayoutItemView(layoutItem: LayoutItem(type: .table,
                                                      position: Position(x: 0, y: 0, width: 80, height: 60)),
                               defaultSeatSize: Size(width: 40, height: 40))
                LayoutItemView(layoutItem: LayoutItem(type: .unknown,
                                                      position: Position(x: 0, y: 0, width: 200, height: 200)),
                               defaultSeatSize: Size(width: 40, height: 40))
            }
            HStack {
                LayoutItemView(layoutItem: LayoutItem(type: .luggageRack,
                                                      position: Position(x: 0, y: 0, width: 80, height: 60)),
                               defaultSeatSize: Size(width: 40, height: 40))
                LayoutItemView(layoutItem: LayoutItem(type: .luggageRoom,
                                                      position: Position(x: 0, y: 0, width: 200, height: 200)),
                               defaultSeatSize: Size(width: 40, height: 40))
            }
            HStack {
                LayoutItemView(layoutItem: LayoutItem(type: .bathroom,
                                                      position: Position(x: 0, y: 0, width: 60, height: 60)),
                               defaultSeatSize: Size(width: 40, height: 40))
                LayoutItemView(layoutItem: LayoutItem(type: .accessibleBabyChangeBathroom,
                                                      position: Position(x: 0, y: 0, width: 80, height: 60)),
                               defaultSeatSize: Size(width: 40, height: 40))
            }
            HStack {
                LayoutItemView(layoutItem: LayoutItem(type: .exit,
                                                      position: Position(x: 0, y: 0, width: 80, height: 60)),
                               defaultSeatSize: Size(width: 40, height: 40))
                LayoutItemView(layoutItem: LayoutItem(type: .exitRight,
                                                      position: Position(x: 0, y: 0, width: 80, height: 60)),
                               defaultSeatSize: Size(width: 40, height: 40))
            }
            LayoutItemView(layoutItem: LayoutItem(type: .stairs,
                                                  position: Position(x: 0, y: 0, width: 80, height: 60)),
                           defaultSeatSize: Size(width: 40, height: 40))
        }
        .setupUIComponents()
    }
}
