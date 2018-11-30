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
    "Overdrive",
    "Fuzz",
    "Delay",
    "Tremolo",
    "Echo",
    "Chorus",
    "Octave"
];

class PedalViewController: UIViewController
{
    // label for slider value
    @IBOutlet weak var pedalName: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var settingsStack: UIStackView!
    
    // http post information
    //let url = URL(string: "192.168.4.1")!
    //let postData = "stuff for the pedal"        // test
    
    // list of sliders and slider value labels
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
        var info = String(pedalNameMap.firstIndex(of: pedalName.text ?? "none")!) + ":"
        for i in 0...(slabels.count-1) {
            //info += (snames[i].text ?? "--") + ", "
            info += (slabels[i].text ?? "--")
            if(i<slabels.count-1) {
                info += ","
            }
        }
    
        // publish via MQTT
        mqttClient.publish(string: info, topic: mqttTopic, qos: 2, retain: false)
        
        // json POST
        //Post(jsonData: postData.data(using: .ascii)!)
    }
    
    // E's post function
//    func Post(jsonData: Data) {
//        if !jsonData.isEmpty {
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.httpBody = jsonData;
//
//            URLSession.shared.getAllTasks { (openTasks: [URLSessionTask]) in
//                NSLog("open tasks: \(openTasks)")
//            }
//
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { (responseData: Data?, response: URLResponse?, error: Error?) in
//                NSLog("\(response)")
//            })
//            task.resume()
//        }
//    }

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
        valueSlider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        sliders.append(valueSlider)
        
        // create valueLabel
        let valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        valueLabel.text = "50"
        valueLabel.textAlignment = .left
        valueLabel.addConstraint(NSLayoutConstraint.init(item: valueLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64))
        slabels.append(valueLabel)
        
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
        snames.append(settingLabel)
    }
}
