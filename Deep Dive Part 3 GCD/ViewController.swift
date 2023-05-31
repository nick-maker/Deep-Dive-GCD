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
    let serialQueue = DispatchQueue(label: "com.example.labelQueue")
    
    let semaphore = DispatchSemaphore(value: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatchSemaphore()
        
    }
    
    func dispatchSemaphore() {
        let labelArray = [labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix]
        let numbers = [0, 10, 20]
        var i = 0

        for number in numbers {
            serialQueue.async {
                self.semaphore.wait()
                TaipeiModel.shared.getTaipeiData(number: number) { result in
                    DispatchQueue.main.async {
                        labelArray[i]?.text = result.results[0].district
                        labelArray[i+1]?.text = result.results[0].location
                        self.semaphore.signal()
                        i += 2
                    }
                }
            }
        }
    }
}

