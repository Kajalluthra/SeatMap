import SwiftUI
import UIComponents

struct BottomSheetView: View {
    
    @State private var startingOffset: CGFloat = UIScreen.main.bounds.height * 0.7
    @State private var currentOffset:CGFloat = 0
    @State private var endOffset:CGFloat = 0
    @Binding var coachName: String
    @Binding var seatNumber: String
    private let defaultOffset: CGFloat = 56
    
    var body: some View {
        ZStack {
            let color = endOffset == 0 ? Color.clear : Color.black.opacity(0.3)
            color
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        endOffset = 0
                    }
                }
            VStack {
                BottomSheetContentView(coachName: $coachName, seatNumber: $seatNumber)
                    .offset(y:startingOffset)
                    .offset(y:currentOffset)
                    .offset(y:endOffset)
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.spring()){
                                    currentOffset = value.translation.height
                                }
                            }
                        
                            .onEnded{ value in
                                withAnimation(.spring()){
                                    if currentOffset < -defaultOffset{
                                        endOffset = -defaultOffset
                                    } else if endOffset != 0 && currentOffset > defaultOffset {
                                        endOffset = .zero
                                    }
                                    currentOffset = 0
                                }
                            }
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            endOffset = -defaultOffset                            
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(coachName: .constant("A"), seatNumber: .constant("21"))
            .setupUIComponents()
    }
}

