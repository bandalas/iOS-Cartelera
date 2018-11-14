//
//  LoadingScreen.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/13/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class LoadingScreen: NSObject {
    
    func launchLoadingScreen(view: UIView, activityView: UIActivityIndicatorView) {
        activityView.center = view.center
        activityView.startAnimating()
        view.addSubview(activityView)
    }
    
    func stopLoadingScreen(view: UIView, activityView: UIActivityIndicatorView) {
        activityView.stopAnimating()
    }
    
}
