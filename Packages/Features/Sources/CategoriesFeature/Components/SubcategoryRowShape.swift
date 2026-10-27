import SwiftUI

public struct SubcategoryRowShape: Shape {
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        let sx = rect.width / 353.0
        let sy = rect.height / 60.0
        
        var path = Path()
        
        path.move(to: CGPoint(x: 0 * sx, y: 12.6882 * sy))
        
        // Top-left corner
        path.addCurve(
            to: CGPoint(x: 12.6186 * sx, y: 0.669555 * sy),
            control1: CGPoint(x: 0 * sx, y: 5.79807 * sy),
            control2: CGPoint(x: 5.73759 * sx, y: 0.315402 * sy)
        )
        
        // Top edge curving toward center
        path.addCurve(
            to: CGPoint(x: 176.5 * sx, y: 6 * sy),
            control1: CGPoint(x: 43.0245 * sx, y: 2.23448 * sy),
            control2: CGPoint(x: 121.864 * sx, y: 6 * sy)
        )
        
        // Center toward top-right
        path.addCurve(
            to: CGPoint(x: 340.381 * sx, y: 0.669555 * sy),
            control1: CGPoint(x: 231.136 * sx, y: 6 * sy),
            control2: CGPoint(x: 309.976 * sx, y: 2.23448 * sy)
        )
        
        // Top-right corner
        path.addCurve(
            to: CGPoint(x: 353 * sx, y: 12.6882 * sy),
            control1: CGPoint(x: 347.262 * sx, y: 0.315403 * sy),
            control2: CGPoint(x: 353 * sx, y: 5.79807 * sy)
        )
        
        // Right edge
        path.addLine(to: CGPoint(x: 353 * sx, y: 47.7748 * sy))
        
        // Bottom-right corner
        path.addCurve(
            to: CGPoint(x: 340.834 * sx, y: 59.7846 * sy),
            control1: CGPoint(x: 353 * sx, y: 54.4895 * sy),
            control2: CGPoint(x: 347.547 * sx, y: 59.9 * sy)
        )
        
        // Bottom edge curving toward center
        path.addCurve(
            to: CGPoint(x: 176.5 * sx, y: 58 * sy),
            control1: CGPoint(x: 310.759 * sx, y: 59.2679 * sy),
            control2: CGPoint(x: 231.383 * sx, y: 58 * sy)
        )
        
        // Center toward bottom-left
        path.addCurve(
            to: CGPoint(x: 12.1664 * sx, y: 59.7846 * sy),
            control1: CGPoint(x: 121.617 * sx, y: 58 * sy),
            control2: CGPoint(x: 42.2411 * sx, y: 59.2679 * sy)
        )
        
        // Bottom-left corner
        path.addCurve(
            to: CGPoint(x: 0 * sx, y: 47.7748 * sy),
            control1: CGPoint(x: 5.45265 * sx, y: 59.9 * sy),
            control2: CGPoint(x: 0 * sx, y: 54.4895 * sy)
        )
        
        // Left edge back to top
        path.addLine(to: CGPoint(x: 0 * sx, y: 12.6882 * sy))
        path.closeSubpath()
        
        return path
    }
}
