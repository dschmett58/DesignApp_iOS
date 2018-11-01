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
//    // label for slider value
//    @IBOutlet weak var sliderValue: UILabel!
//    @IBOutlet weak var sliderLabel: UILabel!
//    @IBOutlet weak var pedalName: UILabel!
//    @IBOutlet weak var loadButton: UIButton!
//
//    // update text field with current value
//    @IBAction func sliderTime_changed(_ sender: UISlider)
//    {
//        let val = floorf(sender.value)
//        sliderValue.text = String(format: "%.0f", val)
//    }
//
//    // LOAD button functionality
//    @IBAction func loadButtonOnClick(_ sender: Any)
//    {
//        // publish and subscribe
//        mqttClient.publish(string: "message", topic: "publish/topic/dan", qos: 2, retain: false)
//    }
//
//    override func viewDidLoad() // NOT CALLED BY TAB SWITCH!
//    {
//        super.viewDidLoad()
//
//        // set MQTT Client Configuration
//        mqttConfig.onConnectCallback = { returnCode in
//            NSLog("Return Code is \(returnCode.description)")
//        }
//        mqttConfig.onMessageCallback = { mqttMessage in
//            NSLog("MQTT Message received: payload=\(mqttMessage.payloadString ?? "")")
//        }
//
//        // disconnect - WHERE TO PUT THIS
//        //mqttClient.disconnect()
//
//        // update title
//        //pedalName.text = currentPedal
//    }
}
