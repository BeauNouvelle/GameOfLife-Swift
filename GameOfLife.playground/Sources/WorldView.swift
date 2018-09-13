import Foundation
import UIKit

public class WorldView: UIView {

    var world: World = World(size: 100)
    var cellSize: Int = 10

    public convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        self.init(frame: frame)
    }

    public convenience init(worldSize: Int, cellSize: Int) {
        let frame = CGRect(x: 0, y: 0, width: worldSize * cellSize, height: worldSize * cellSize)
        self.init(frame: frame)
        self.world = World(size: worldSize)
        self.cellSize = cellSize
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()

        for cell in world.cells {
            let rect = CGRect(x: cell.x * cellSize, y: cell.y * cellSize, width: cellSize, height: cellSize)
            let color = cell.state == .alive ? UIColor.green.cgColor : UIColor.white.cgColor
            context?.addRect(rect)
            context?.setFillColor(color)
            context?.fill(rect)
        }

        context?.restoreGState()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        world.updateCells()
        setNeedsDisplay()
    }

    public func autoRun() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.world.updateCells()
            self.setNeedsDisplay()
            self.autoRun()
        }
    }

}
