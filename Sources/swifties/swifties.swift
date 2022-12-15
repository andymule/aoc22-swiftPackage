import Foundation

@main
public enum swifties {
    public static func main() {
//        Day14().run()
        Day15().run()
    }
}

class Day {
    var input = day14.components(separatedBy: "\n")
    public func run() {}
}

class Day15: Day {
    override func run() {
        input = day14.components(separatedBy: "\n")
        print(input)
    }
}
