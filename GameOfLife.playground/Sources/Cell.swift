import Foundation

public enum State {
    case alive
    case dead
}

public struct Cell {
    public let x: Int
    public let y: Int
    public var state: State

    public init(x: Int, y: Int, state: State) {
        self.x = x
        self.y = y
        self.state = state
    }

    public func isNeighbor(to cell: Cell) -> Bool {

        let xDelta = abs(self.x - cell.x)
        let yDelta = abs(self.y - cell.y)

        switch (xDelta, yDelta) {
        case (1, 1), (0, 1), (1, 0):
            return true
        default:
            return false
        }

    }

}
