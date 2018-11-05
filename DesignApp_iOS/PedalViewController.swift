//
//  SecondViewController.swift
//  first_try
//
//  Created by Dan Schmetterling on 9/4/18.
//  Copyright © 2018 Dan Schmetterling. All rights reserved.
//

import UIKit
import Moscapsule

// GLOBAL
var mqttConfig = MQTTConfig(clientId: "cid", host: "test.mosquitto.org", port: 1883, keepAlive: 60)
var mqttClient = MQTT.newConnection(mqttConfig)

class PedalViewController: UIViewController
{
    // label for slider value
//    @IBOutlet weak var sliderValue: UILabel!
//    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var pedalName: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var settingsStack: UIStackView!
    
    // update text field with current value
//    @IBAction func sliderTime_changed(_ sender: UISlider)
//    {
//        let val = floorf(sender.value)
//        sliderValue.text = String(format: "%.0f", val)
//    }

    // LOAD button functionality
//    @IBAction func loadButtonOnClick(_ sender: Any)
//    {
//        // publish and subscribe
//        mqttClient.publish(string: "message", topic: "publish/topic/dan", qos: 2, retain: false)
//    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // set MQTT Client Configuration
//        mqttConfig.onConnectCallback = { returnCode in
//            NSLog("Return Code is \(returnCode.description)")
//        }
//        mqttConfig.onMessageCallback = { mqttMessage in
//            NSLog("MQTT Message received: payload=\(mqttMessage.payloadString ?? "")")
//        }

        // disconnect - WHERE TO PUT THIS
        //mqttClient.disconnect()

        // update title
        pedalName.text = currentPedal
        
        // update layout
//        let stackView = UIStackView(arrangedSubviews: buttonArray)
//        stackView.axis = .Horizontal
//        stackView.distribution = .FillEqually
//        stackView.alignment = .Fill
//        stackView.spacing = 5
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackView)
        
        // create settingLabel
        let settingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        settingLabel.text = "setting1"
        settingLabel.textAlignment = .right
        
        // create valueSlider
        let valueSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 128, height: 32))
        
        // create valueLabel
        let valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        valueLabel.text = "50"
        valueLabel.textAlignment = .left
        
        // create stack for first setting
        let setting1 = UIStackView(arrangedSubviews: [settingLabel,valueSlider,valueLabel])
        setting1.axis = .horizontal
        setting1.distribution = .fillEqually
        setting1.alignment = .fill
        setting1.spacing = 16
        setting1.translatesAutoresizingMaskIntoConstraints = false
        
        // add first setting to settingsStack
        settingsStack.addSubview(setting1)
        
        // update settings? - TODO
    }
}
