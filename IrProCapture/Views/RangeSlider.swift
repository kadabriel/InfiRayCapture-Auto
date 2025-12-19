import SwiftUI

struct RangeSlider: View {
    @Binding var lowValue: Float
    @Binding var highValue: Float
    let range: ClosedRange<Float>
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background Track
                Capsule()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(height: 4)
                
                // Highlighted Track
                Capsule()
                    .fill(Color.blue)
                    .frame(width: CGFloat(xForValue(highValue, in: geometry.size.width) - xForValue(lowValue, in: geometry.size.width)), height: 4)
                    .offset(x: CGFloat(xForValue(lowValue, in: geometry.size.width)))
                
                // Low Handle
                HandleView(isFocused: focusedHandle == .low, side: .left)
                    .offset(x: CGFloat(xForValue(lowValue, in: geometry.size.width)) - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                focusedHandle = .low
                                let newValue = valueForX(Float(value.location.x), in: geometry.size.width)
                                lowValue = min(max(range.lowerBound, newValue), highValue - 0.1)
                            }
                    )
                    .focusable()
                    .onMoveCommand { direction in
                        focusedHandle = .low
                        switch direction {
                        case .left: lowValue = max(range.lowerBound, lowValue - 0.5)
                        case .right: lowValue = min(highValue - 0.1, lowValue + 0.5)
                        default: break
                        }
                    }
                
                // High Handle
                HandleView(isFocused: focusedHandle == .high, side: .right)
                    .offset(x: CGFloat(xForValue(highValue, in: geometry.size.width)))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                focusedHandle = .high
                                let newValue = valueForX(Float(value.location.x), in: geometry.size.width)
                                highValue = max(min(range.upperBound, newValue), lowValue + 0.1)
                            }
                    )
                    .focusable()
                    .onMoveCommand { direction in
                        focusedHandle = .high
                        switch direction {
                        case .left: highValue = max(lowValue + 0.1, highValue - 0.5)
                        case .right: highValue = min(range.upperBound, highValue + 0.5)
                        default: break
                        }
                    }
            }
        }
        .frame(height: 20)
    }
    
    enum FocusedHandle {
        case low, high
    }
    @State private var focusedHandle: FocusedHandle? = nil
    
    private func xForValue(_ value: Float, in width: CGFloat) -> Float {
        let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return Float(width) * percentage
    }
    
    private func valueForX(_ x: Float, in width: CGFloat) -> Float {
        let percentage = x / Float(width)
        return range.lowerBound + percentage * (range.upperBound - range.lowerBound)
    }
}

enum HandleSide {
    case left, right
}

struct HandleView: View {
    var isFocused: Bool
    var side: HandleSide
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: side == .left ? 10 : 0,
                bottomLeadingRadius: side == .left ? 10 : 0,
                bottomTrailingRadius: side == .right ? 10 : 0,
                topTrailingRadius: side == .right ? 10 : 0,
                style: .circular
            )
            .fill(Color.white)
            .frame(width: 10, height: 20)
            .shadow(radius: 2)
            .overlay(
                UnevenRoundedRectangle(
                    topLeadingRadius: side == .left ? 10 : 0,
                    bottomLeadingRadius: side == .left ? 10 : 0,
                    bottomTrailingRadius: side == .right ? 10 : 0,
                    topTrailingRadius: side == .right ? 10 : 0,
                    style: .circular
                )
                .stroke(isFocused ? Color.blue : Color.gray.opacity(0.2), lineWidth: isFocused ? 2 : 0.5)
            )
        }
    }
}
