
import SwiftUI

public struct BrandCardShape: Shape {
    public init() {}
    
    public func path(in rect: CGRect) -> Path {
        let sx = rect.width / 168.0
        let sy = rect.height / 180.0
        
        var path = Path()
        
        path.move(to: CGPoint(x: 0 * sx, y: 18.0432 * sy))
        
        // Top-left corner
        path.addCurve(
            to: CGPoint(x: 17.935 * sx, y: 1.94804 * sy),
            control1: CGPoint(x: 0 * sx, y: 8.44789 * sy),
            control2: CGPoint(x: 8.38788 * sx, y: 0.986874 * sy)
        )
        
        // Top inward curved edge to center
        path.addCurve(
            to: CGPoint(x: 84 * sx, y: 6.125 * sy),
            control1: CGPoint(x: 35.7476 * sx, y: 3.74134 * sy),
            control2: CGPoint(x: 63.3147 * sx, y: 6.125 * sy)
        )
        
        // Center to top-right corner
        path.addCurve(
            to: CGPoint(x: 150.065 * sx, y: 1.94804 * sy),
            control1: CGPoint(x: 104.685 * sx, y: 6.125 * sy),
            control2: CGPoint(x: 132.252 * sx, y: 3.74134 * sy)
        )
        
        // Top-right corner
        path.addCurve(
            to: CGPoint(x: 168 * sx, y: 18.0432 * sy),
            control1: CGPoint(x: 159.612 * sx, y: 0.986875 * sy),
            control2: CGPoint(x: 168 * sx, y: 8.44789 * sy)
        )
        
        // Right edge
        path.addLine(to: CGPoint(x: 168 * sx, y: 90 * sy))
        path.addLine(to: CGPoint(x: 168 * sx, y: 162.784 * sy))
        
        // Bottom-right corner
        path.addCurve(
            to: CGPoint(x: 150.838 * sx, y: 178.86 * sy),
            control1: CGPoint(x: 168 * sx, y: 172.082 * sy),
            control2: CGPoint(x: 160.117 * sx, y: 179.434 * sy)
        )
        
        // Bottom inward curved edge to center
        path.addCurve(
            to: CGPoint(x: 84 * sx, y: 176.25 * sy),
            control1: CGPoint(x: 132.994 * sx, y: 177.757 * sy),
            control2: CGPoint(x: 104.813 * sx, y: 176.25 * sy)
        )
        
        // Center to bottom-left corner
        path.addCurve(
            to: CGPoint(x: 17.1621 * sx, y: 178.86 * sy),
            control1: CGPoint(x: 63.1866 * sx, y: 176.25 * sy),
            control2: CGPoint(x: 35.0059 * sx, y: 177.757 * sy)
        )
        
        // Bottom-left corner
        path.addCurve(
            to: CGPoint(x: 0 * sx, y: 162.784 * sy),
            control1: CGPoint(x: 7.8826 * sx, y: 179.434 * sy),
            control2: CGPoint(x: 0 * sx, y: 172.082 * sy)
        )
        
        // Left edge back to start
        path.addLine(to: CGPoint(x: 0 * sx, y: 90 * sy))
        path.closeSubpath()
        
        return path
    }
}
