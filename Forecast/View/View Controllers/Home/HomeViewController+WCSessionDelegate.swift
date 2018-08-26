//
//  HomeViewController+WCSessionDelegate.swift
//  Forecast
//
//  Created by Cole Roberts on 7/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import WatchConnectivity

extension HomeViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(session)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
}
