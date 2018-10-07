//
//  SecondViewController.swift
//  first_try
//
//  Created by Dan Schmetterling on 9/4/18.
//  Copyright © 2018 Dan Schmetterling. All rights reserved.
//

import UIKit

class PedalViewController: UIViewController
{
    // label for slider value
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var pedalName: UILabel!
    
    // update text field with current value
    @IBAction func sliderTime_changed(_ sender: UISlider)
    {
        let val = floorf(sender.value)
        sliderValue.text = String(format: "%.0f", val)
    }
    
    override func viewDidLoad() // NOT CALLED BY TAB SWITCH!
    {
        super.viewDidLoad()

        // update title
        pedalName.text = currentPedal
    }
}
