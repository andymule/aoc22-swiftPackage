import Foundation

class Day14 {
    public func run() {
        parseGrid()
//        printGrid()
        sandCount = 0
        while dropSand(500, 0) {
            sandCount += 1
        }
//        printGrid()
        // 24588 too low, i just guessed and was correct that i was "off by one, my answer was 24589
        print(sandCount + 1)
    }

    // function that drops sand at a given x coordinate
    func dropSand(_ xIn: Int, _ yIn: Int) -> Bool {
        var y: Int = yIn
        let x: Int = xIn
        while y <= maxY + 4 {
            let thisPoint: [Int] = [x, y]
            let nextPoint: [Int] = [x, y + 1]
            if grid[nextPoint] == "#" || grid[nextPoint] == "o" || nextPoint[1] == maxY + 2 {
                if grid[[x - 1, y + 1]] == nil && y + 1 != maxY + 2 {
                    return dropSand(x - 1, y + 1)
                } else if grid[[x + 1, y + 1]] == nil && y + 1 != maxY + 2 {
                    return dropSand(x + 1, y)
                } else {
                    grid[thisPoint] = "o"
                    if thisPoint == [500, 0] {
                        return false
                    }
                    return true
                }
            } else {
                y += 1
            }
        }
        return false
    }

    var input: [String] = day14.components(separatedBy: "\n")
    var grid: [[Int]: String] = .init()
    // tracks the bounding edges of the grid
    var minX: Int = 99_999_999_999
    var maxX: Int = 0
    var maxY: Int = 0
    var sandCount = 0

    // prits the grid
    public func printGrid() {
        print()
        for y: Int in 0 ... maxY + 3 {
            var line: String = ""
            for x: Int in minX - 10 ..< maxX + 10 {
                let key: [Int] = [x, y]
                if y == maxY + 2 {
                    line += "#"
                } else if grid[key] == nil {
                    line += "."
                } else {
                    line += grid[key]!
                }
            }
            print(line)
        }
    }

    // parse input into grid
    func parseGrid() {
        for line: String in input {
            let points: [String] = line.components(separatedBy: " -> ")
            for i in 1 ... points.count - 1 {
                let from: [String] = points[i - 1].components(separatedBy: ",")
                let to: [String] = points[i].components(separatedBy: ",")
                let fromX = Int(from[0])!
                let fromY = Int(from[1])!
                let toX = Int(to[0])!
                let toY = Int(to[1])!

                maxY = max(fromY, toY, maxY)
                maxX = max(fromX, toX, maxX)
                minX = min(fromX, toX, minX)

                if fromX == toX {
                    for y: Int in min(fromY, toY) ... max(fromY, toY) {
                        let key: [Int] = [fromX, y]
                        if grid[key] == nil {
                            grid[key] = "#"
                        } else {
//                            print("overlap", key)
                        }
                    }
                }
                if fromY == toY {
                    for x: Int in min(fromX, toX) ... max(fromX, toX) {
                        let key: [Int] = [x, fromY]
                        if grid[key] == nil {
                            grid[key] = "#"
                        } else {
//                            print("overlap", key)
                        }
                    }
                }
            }
        }
    }
}
