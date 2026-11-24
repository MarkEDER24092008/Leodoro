

import SwiftUI

struct RectCorner: OptionSet {
    let rawValue: Int

    static let topLeft = RectCorner(rawValue: 1 << 0)
    static let topRight = RectCorner(rawValue: 1 << 1)
    static let bottomLeft = RectCorner(rawValue: 1 << 2)
    static let bottomRight = RectCorner(rawValue: 1 << 3)
    static let allCorners: RectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}

struct Corners: Shape {

    var corner: RectCorner
    var size: CGSize

    func path(in rect: CGRect) -> Path {
        let tl = corner.contains(.topLeft) ? size : .zero
        let tr = corner.contains(.topRight) ? size : .zero
        let bl = corner.contains(.bottomLeft) ? size : .zero
        let br = corner.contains(.bottomRight) ? size : .zero

        var path = Path()
        path.move(to: CGPoint(x: rect.minX + tl.width, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - tr.width, y: rect.minY))
        if tr != .zero {
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + tr.height),
                              control: CGPoint(x: rect.maxX, y: rect.minY))
        }
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br.height))
        if br != .zero {
            path.addQuadCurve(to: CGPoint(x: rect.maxX - br.width, y: rect.maxY),
                              control: CGPoint(x: rect.maxX, y: rect.maxY))
        }
        path.addLine(to: CGPoint(x: rect.minX + bl.width, y: rect.maxY))
        if bl != .zero {
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - bl.height),
                              control: CGPoint(x: rect.minX, y: rect.maxY))
        }
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + tl.height))
        if tl != .zero {
            path.addQuadCurve(to: CGPoint(x: rect.minX + tl.width, y: rect.minY),
                              control: CGPoint(x: rect.minX, y: rect.minY))
        }
        path.closeSubpath()
        return path
    }
}

struct CardView: View {
    let description: String
    let image: String
    let type: CardViewType

    var body: some View {
        HStack {
            if type == .imageLeft {
                Text(description).padding(10).padding(.leading, 15)
                Spacer()
                Image(image).resizable().frame(width: 80, height: 80).padding(5)
            } else {
                Image(image).resizable().frame(width: 80, height: 80).padding(5)
                Spacer()
                Text(description).padding(10).padding(.trailing, 15)
            }

        }.background(.pomodoroGreen.opacity(0.2)).cornerRadius(15)
            .padding(.leading, type == .imageLeft ? 30 : 20)
            .padding(.trailing, type == .imageLeft ? 20: 30)
            .padding([.top, .bottom], 5)
    }
}

enum CardViewType {
    case imageLeft
    case imageRight
}
