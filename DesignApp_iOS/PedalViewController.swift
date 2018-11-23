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
        
        // create & add settings
        switch(currentPedal)
        {
            case "Distortion":
                addSetting(name: "setting1")
                break;
            case "Overdrive":
                addSetting(name: "setting1")
                break;
            case "Fuzz":
                addSetting(name: "Cutoff")
                addSetting(name: "Ceiling")
                break;

            case "Delay":
                addSetting(name: "Time")
                addSetting(name: "Sustain")
                break;
            case "Tremolo":
                addSetting(name: "Speed")
                break;
            case "Echo":
                addSetting(name: "Time")
                addSetting(name: "Sustain")
                break;

            case "Chorus":
                addSetting(name: "setting1")
                break;
            case "Octave":
                addSetting(name: "setting1")
                break;

            default:
                addSetting(name: "nothing")
                break;
        }
    }
    
    func addSetting(name: String)
    {
        // create settingLabel
        let settingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        settingLabel.text = name
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
        let setting = UIStackView(arrangedSubviews: [settingLabel,valueSlider,valueLabel])
        setting.axis = .horizontal
        setting.distribution = .fill
        setting.alignment = .fill
        setting.spacing = 16
        //setting.contentMode = .scaleToFill
        setting.translatesAutoresizingMaskIntoConstraints = false
        //setting.addConstraint(NSLayoutConstraint.init(item: setting, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32))
        
        // add first setting to settingsStack
        settingsStack.addArrangedSubview(setting)
        
        // update setting value? - TODO
    }
}
