//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Cole Roberts on 7/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    let watchSession = WCSession.default
    
    @IBOutlet var cityLabel: WKInterfaceLabel!
    @IBOutlet var currentTemperatureLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        watchSession.delegate = self
        watchSession.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(session)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        guard let city = message["city"] as? String else { return }
        guard let temp = message["temp"] as? String else { return }

        DispatchQueue.main.async {
            
            self.cityLabel.setText(city)
            self.currentTemperatureLabel.setText(temp + "°")
        }
    }
}
