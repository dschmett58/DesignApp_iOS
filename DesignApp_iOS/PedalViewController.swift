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
        
        // create settingLabel
        let settingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        settingLabel.text = "setting1"
        settingLabel.textAlignment = .right
        settingLabel.addConstraint(NSLayoutConstraint.init(item: settingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64))
        
        // create valueSlider
        let valueSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 128, height: 32))
        valueSlider.minimumValue = 0
        valueSlider.maximumValue = 100
        valueSlider.value = 50
        
        // create valueLabel
        let valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        valueLabel.text = "50"
        valueLabel.textAlignment = .left
        valueLabel.addConstraint(NSLayoutConstraint.init(item: valueLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64))
        
        // create stack for first setting
        let setting1 = UIStackView(arrangedSubviews: [settingLabel,valueSlider,valueLabel])
        setting1.axis = .horizontal
        setting1.distribution = .fill
        setting1.alignment = .fill
        setting1.spacing = 16
        setting1.contentMode = .scaleToFill
        setting1.translatesAutoresizingMaskIntoConstraints = false
        setting1.addConstraint(NSLayoutConstraint.init(item: setting1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32))
        
        // add first setting to settingsStack
        settingsStack.addSubview(setting1)
        
        // update settings values? - TODO
    }
}
