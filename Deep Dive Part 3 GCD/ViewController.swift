//
//  ViewController.swift
//  Deep Dive Part 3 GCD
//
//  Created by Nick Liu on 2023/5/31.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBOutlet weak var labelThree: UILabel!
    
    @IBOutlet weak var labelFour: UILabel!
    
    @IBOutlet weak var labelFive: UILabel!
    
    @IBOutlet weak var labelSix: UILabel!
    

    var labelData: [Int: (district: String, location: String)] = [:]
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatchGroup()
    }
    
    func dispatchGroup() {
        let numbers = [0, 10, 20]
        for number in numbers {
            group.enter()
            TaipeiModel.shared.getTaipeiData(number: number) { [weak self] result in
                guard let self = self else { return }
                let district = result.results[0].district
                let location = result.results[0].location
                self.labelData[number] = (district, location)
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.labelOne.text = self.labelData[0]?.district
            self.labelTwo.text = self.labelData[0]?.location
            self.labelThree.text = self.labelData[10]?.district
            self.labelFour.text = self.labelData[10]?.location
            self.labelFive.text = self.labelData[20]?.district
            self.labelSix.text = self.labelData[20]?.location
        }
    }
    
}

