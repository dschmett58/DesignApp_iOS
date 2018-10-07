//
//  FirstViewController.swift
//  first_try
//
//  Created by Dan Schmetterling on 9/4/18.
//  Copyright © 2018 Dan Schmetterling. All rights reserved.
//

import UIKit

// GLOBAL
var currentPedal = "none so far"

@IBDesignable class PedalboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // PEDAL NAMES
    let pedalNames: [[String]] =
    [
        ["Distortion", "Overdrive", "Fuzz"],
        ["Delay", "Tremolo", "Echo"],
        ["Chorus", "Octave"]
    ]
    
    // PEDAL ICONS
    let pedalIcons: [[UIImage]] =
    [
        [#imageLiteral(resourceName: "Distortion"),#imageLiteral(resourceName: "Distortion"),#imageLiteral(resourceName: "Distortion")],
        [#imageLiteral(resourceName: "Distortion"),#imageLiteral(resourceName: "Distortion"),#imageLiteral(resourceName: "Distortion")],
        [#imageLiteral(resourceName: "Distortion"),#imageLiteral(resourceName: "Distortion")]
    ]
    
    // SECTION num
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return pedalNames.count
    }
    
    // SUBSECTION num
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pedalNames[section].count
    }
    
    // CELL content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        let pedalLabel = pedalNames[indexPath.section][indexPath.row]
        let pedalIcon = pedalIcons[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = pedalLabel
        cell.imageView?.image = pedalIcon
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    // SECTION titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        var section_title = ""
        
        // set section titles
        switch section {
            case 0:
                section_title = "Distortions"
                break
            case 1:
                section_title = "Modulations"
                break
            case 2:
                section_title = "Weird Shit"
                //break;
            default:
                break
        }
        
        return section_title
    }
    
    // OnClick functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // set pedal name
        currentPedal = pedalNames[indexPath.section][indexPath.row]
        
        // change view (tab over)
        self.tabBarController?.selectedIndex = 1
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

