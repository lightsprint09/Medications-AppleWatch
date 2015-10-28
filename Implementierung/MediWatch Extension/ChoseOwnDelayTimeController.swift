//
//  ChoseOwnDelayTimeController.swift
//  Medications
//
//  Created by Lukas Schmidt on 25.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import WatchKit

class ChoseOwnDelayTimeController: WKInterfaceController {
    @IBOutlet var delayTimePicker: WKInterfacePicker!

    override func awakeWithContext(context: AnyObject?) {
        var pickerItems: [WKPickerItem] = []
        let pickerItem = WKPickerItem()
        pickerItem.title = "\(1) Minute"
        pickerItems.append(pickerItem)
        for (var i = 2; i <= 121; i++) {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\(i) Minuten"
            pickerItems.append(pickerItem)
        }
        delayTimePicker.setItems(pickerItems)
    }
    
    @IBAction func delayMedication() {
    }
}
