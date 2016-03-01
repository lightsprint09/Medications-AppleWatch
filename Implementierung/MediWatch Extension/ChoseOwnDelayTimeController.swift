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
    var watchExecutionTimeContext: WatchExecutionTimeContext!
    var delayMinutes: Int?

    override func awakeWithContext(context: AnyObject?) {
        if let context = context as? WatchExecutionTimeContext{
            watchExecutionTimeContext = context
        }
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
        if let delayMinutes = delayMinutes {
            watchExecutionTimeContext.delayExecutionTime(delayMinutes * 60)
        }
      popToRootController()
    }
    
    @IBAction func didChangePickerValue(value: Int) {
        delayMinutes = value + 1
    }
    func delayExecutionTime(seconds: Int) {
        watchExecutionTimeContext.executionTime.secondsMoved = seconds
        watchExecutionTimeContext.executionTimeService.updateExecutionTime(watchExecutionTimeContext.executionTime)
        popController()
    }
}
