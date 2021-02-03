//
//  ViewController.swift
//
//  Created by Rob Kerr on 2/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chartView: TutorialChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SegmentSelected(_ sender: UISegmentedControl) {
        let numSegments = (sender.selectedSegmentIndex + 1) * 4
        
        var dataPoints = [Double]()
        
        for _ in 0..<numSegments {
            dataPoints.append(Double.random(in: 20.0...100.0))
        }
        
        chartView.setData(dataPoints)
    }
}

