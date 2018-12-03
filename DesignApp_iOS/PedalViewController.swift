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
var mqttTopic = "publish/topic/dan"
var pedalNameMap: [String] =
[
    "Distortion",
    "Fuzz",
    "Delay",
    "Tremolo",
    "Octave",
    "Clean"
];

var dist_thresh = Float(5000);

var fuzz_thresh = Float(4500);
var fuzz_ceil = Float(32768);

//var delay_time;
//var delay_feedback;

var trem_speed = Float(1);

var octave_depth = Float(10);

class PedalViewController: UIViewController
{
    // GUI elements
    @IBOutlet weak var pedalName: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var settingsStack: UIStackView!
    
    // list of sliders, slider value labels, and setting names
    var sliders = [UISlider]()
    var slabels = [UILabel]()
    var snames  = [UILabel]()
    
    // update value label with slider value
    @objc func sliderValueChanged(sender: UISlider)
    {
        let val = floorf(sender.value)                          // round slider value
        let num = sliders.firstIndex(of: sender)                // find slider index in list
        slabels[num ?? 0].text = String(format: "%.0f", val)    // set accompanying label with rounded value
    }

    // LOAD button functionality
    @IBAction func loadButtonOnClick(_ sender: Any)
    {
        // build string to send
        let pedalnum = pedalNameMap.firstIndex(of: pedalName.text ?? "none")!
        var info = String(pedalnum) + ":" // select pedal index
        for i in 0...(slabels.count-1) {
            info += (slabels[i].text ?? "0") + ","           // setting values
        }
        info += "."
    
        // publish via MQTT
        mqttClient.publish(string: info, topic: mqttTopic, qos: 2, retain: false)
        
        // set global var (remember setting)
        switch (pedalnum)
        {
            case 0:
                dist_thresh = Float(slabels[0].text!)!
                break;
            case 1:
                fuzz_thresh = Float(slabels[0].text!)!
                fuzz_ceil = Float(slabels[1].text!)!
                break;
            case 2:
                break;
            case 3:
                trem_speed = Float(slabels[0].text!)!
                break;
            case 4:
                octave_depth = Float(slabels[0].text!)!
                break;
            case 5:
                break;
            default:
                break;
        }
    }

    // PEDAL SELECT functionality (initiate MQTT connection, create settings GUI)
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // set MQTT Client Configuration
        mqttConfig.onConnectCallback = { returnCode in
            NSLog("Return Code is \(returnCode.description)")
        }
        mqttConfig.onMessageCallback = { mqttMessage in
            NSLog("MQTT Message received: payload=\(mqttMessage.payloadString ?? "")")
        }

        // disconnect - WHERE TO PUT THIS
        //mqttClient.disconnect()

        // update title
        pedalName.text = currentPedal
        
        // create & add settings
        switch(currentPedal)
        {
            case "Distortion":
                addSetting(name: "Thresh", minval: 4500, maxval: 10000, avgval: dist_thresh)
                break;
            case "Fuzz":
                addSetting(name: "Thresh", minval: 4000, maxval: 5000, avgval: fuzz_thresh)
                addSetting(name: "Ceiling", minval: 10000, maxval: 32768, avgval: fuzz_ceil)
                break;
            case "Delay":   // unused (too big for Arduino memory)
                addSetting(name: "Time", minval: 0, maxval: 2, avgval: 1)
                addSetting(name: "Feedback", minval: 0, maxval: 2, avgval: 1)
                break;
            case "Tremolo":
                addSetting(name: "Speed", minval: 1, maxval: 10, avgval: trem_speed)
                break;
            case "Octave":
                addSetting(name: "Depth", minval: 0, maxval: 50, avgval: octave_depth)
                break;
            case "Clean":
                addSetting(name: "none", minval: 0, maxval: 0, avgval: 0)
                break;
            default:
                break;
        }
    }
    
    // create settings (GUI)
    func addSetting(name: String, minval: Float, maxval: Float, avgval: Float)
    {
        // create settingLabel (name of setting)
        let settingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        settingLabel.text = name
        settingLabel.textAlignment = .right
        settingLabel.addConstraint(NSLayoutConstraint.init(item: settingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64))
        
        // create valueSlider
        let valueSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 128, height: 32))
        valueSlider.minimumValue = minval
        valueSlider.maximumValue = maxval
        valueSlider.value = avgval
        valueSlider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        sliders.append(valueSlider)
        
        // create valueLabel (value of slider)
        let valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        valueLabel.text = String(Int(valueSlider.value))
        valueLabel.textAlignment = .left
        valueLabel.addConstraint(NSLayoutConstraint.init(item: valueLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64))
        slabels.append(valueLabel)
        
        // create horiz. stack for first setting
        let setting = UIStackView(arrangedSubviews: [settingLabel,valueSlider,valueLabel])
        setting.axis = .horizontal
        setting.distribution = .fill
        setting.alignment = .fill
        setting.spacing = 16
        //setting.contentMode = .scaleToFill
        setting.translatesAutoresizingMaskIntoConstraints = false
        //setting.addConstraint(NSLayoutConstraint.init(item: setting, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32))
        
        // add setting to vert. settingsStack
        settingsStack.addArrangedSubview(setting)
        
        // update setting name
        snames.append(settingLabel)
    }
}
