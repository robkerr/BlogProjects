//
//  TutorialChartViewModel.swift
//
//  Created by Rob Kerr on 2/3/21.
//

import UIKit

class TutorialChartViewModel {
    var dataPoints = [Double]()
    var barColor = UIColor.systemBlue
    
    var maxY : Double {
        return dataPoints.sorted(by: >).first ?? 0
    }
    
    var barGapPctOfTotal : CGFloat {
        return CGFloat(0.2) / CGFloat(dataPoints.count - 1)
    }
    
    var barWidthPctOfTotal : CGFloat {
        return CGFloat(0.8) / CGFloat(dataPoints.count)
    }
    
    var barCornerRadius : CGFloat {
        return CGFloat(50 / dataPoints.count)
    }
}
