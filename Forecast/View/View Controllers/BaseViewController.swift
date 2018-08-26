//
//  BaseViewController.swift
//  Forecast
//
//  Created by Cole Roberts on 8/23/18.
//  Copyright © 2018 Cole Roberts. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide the TabBar before view transitions
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = Colors.white
        setNavigationBarTransparent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTransparent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func willMove(toParent parent: UIViewController?) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    }
    
    // MARK: - Public methods
    
    public func setNavigationBarTransparent() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.backgroundColor =  UIColor.clear
    }
    
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okayAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
