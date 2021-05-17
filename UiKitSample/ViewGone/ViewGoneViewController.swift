//
//  ViewGoneViewController.swift
//  UiKitSample
//
//  Created by ororo on 2021/05/12.
//

import Foundation
import UIKit

class ViewGoneViewController: UIViewController {

    @IBOutlet weak var targetSecondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toggleViewVisiblity(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.targetSecondLabel.isHidden = !sender.isOn
        }
    }
}
