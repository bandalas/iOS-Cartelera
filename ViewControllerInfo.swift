//
//  ViewControllerInfo.swift
//  CarteleraEventos
//
//  Created by Ana Villarreal on 5/8/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class ViewControllerInfo: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.contentSize = contentView.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
