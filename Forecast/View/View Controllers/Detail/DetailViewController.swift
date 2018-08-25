//
//  DetailViewController.swift
//  Forecast
//
//  Created by Cole Roberts on 8/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import UIKit
import ForecastIO
import ScrollableGraphView

class DetailViewController: BaseViewController {
    
    var selectedDay: DataPoint?
    var hourlyForecast = [DataPoint]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dump(selectedDay)
        dump(hourlyForecast)
        view.backgroundColor = Colors.darkGrey
        
        let graphView = ScrollableGraphView(frame: view.frame, dataSource: self)
        let referenceLines = ReferenceLines()
        let linePlot = LinePlot(identifier: "line")
        
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        
        linePlot.lineStyle = .smooth

        linePlot.adaptAnimationType = .elastic
        linePlot.shouldFill = true
//        linePlot.fillGradientStartColor
        
        referenceLines.referenceLineColor = Colors.brandBlue
        
        graphView.dataPointSpacing = 10

        self.view.addSubview(graphView)
    }
}


extension DetailViewController: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
    
        switch(plot.identifier) {
        case "line":
            return hourlyForecast[pointIndex].temperature!
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "\(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return hourlyForecast.count
    }
}
