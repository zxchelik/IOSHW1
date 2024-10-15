//
//  ViewController.swift
//  msnemykinPW1
//
//  Created by Михаил Немыкин on 11.10.2024.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Constants
    struct Constants {
        static let minCornerRadius: CGFloat = 0
        static let maxCornerRadius: CGFloat = 10
        static let animationDuration: TimeInterval = 3
    }
    // MARK: - Outlets
    @IBOutlet var legs: [UIView]!
    
    @IBOutlet var body: [UIView]!
    
    @IBOutlet var face: [UIView]!
    
    var colections: [[UIView]] = []
    
    // MARK: - Actions
    @IBAction func buttonWasPressed(
        _ sender: Any
    ) {
        var colorsSet = getRandomHexColors()
        let button = sender as! UIButton
        
        button.isEnabled = false
        colections.forEach { views in
            let color = colorsSet.popFirst()
            let cornerRadius: CGFloat = .random(in: Constants.minCornerRadius...Constants.maxCornerRadius)
            
            UIView.animate(
                withDuration: Constants.animationDuration,
                animations: {
                    views.forEach { view in
                        view.backgroundColor = UIColor(hexColor: color!)
                        view.layer.cornerRadius = cornerRadius
                    }
                },
                completion: {
                    _ in button.isEnabled = true
                }
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colections = [legs, body, face]
    }
    
    
    // MARK: - Private methods
    /// Legacy
    private func getRandomColors() -> Set<UIColor> {
        var colors: Set<UIColor> = []
        
        colections.forEach { view in
            var color: UIColor
            repeat {
                color = UIColor(
                    displayP3Red: .random(in: 0...1 ),
                    green:.random(in: 0...1),
                    blue:.random(in: 0...1),
                    alpha: 1
                )
            } while colors.contains(color)
            
            colors.insert(color)
        }
        return colors
    }
    
    private func getRandomHexColors() -> Set<String> {
        var colors: Set<String> = []
        
        colections.forEach { view in
            var color: String = ""
            repeat {
                let red = Int.random(in: 0...255)
                let green = Int.random(in: 0...255)
                let blue = Int.random(in: 0...255)
                
                color = String(format: "#%02X%02X%02X", red, green, blue)
            } while colors.contains(color)
            
            colors.insert(color)
        }
        return colors
    }
}

// MARK: - UIColor extension
extension UIColor {
    convenience init?(hexColor: String) {
        var hexFormatted = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        guard hexFormatted.count == 6 else {
            return nil
        }
        
        let redHex = String(hexFormatted.prefix(2))
        let greenHex = String(hexFormatted.dropFirst(2).prefix(2))
        let blueHex = String(hexFormatted.dropFirst(4).prefix(2))
        
        guard let red = UInt8(redHex, radix: 16),
              let green = UInt8(greenHex, radix: 16),
              let blue = UInt8(blueHex, radix: 16) else {
            return nil
        }
        
        self.init(red:CGFloat(red) / 255.0,green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0,alpha: 1)
    }
}

