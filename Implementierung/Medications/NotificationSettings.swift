//
//  NotificationSettings.swift
//  Medications
//
//  Created by Lukas Schmidt on 04.10.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class NotificationSettings: NSObject {
    static var takeMedikationAction:  UIUserNotificationAction {
        let takeMedikation = UIMutableUserNotificationAction()
        takeMedikation.identifier = ""
        takeMedikation.destructive = false
        takeMedikation.title = "Genommen"
        takeMedikation.activationMode = .Background
        takeMedikation.authenticationRequired = false
        
        return takeMedikation
    }
    
    static var delayMedicationAction: UIUserNotificationAction {
        let delayMedication = UIMutableUserNotificationAction()
        delayMedication.identifier = ""
        delayMedication.destructive = false
        delayMedication.title = "Verschieben"
        delayMedication.activationMode = .Background
        delayMedication.authenticationRequired = false
        
        return delayMedication
    }
    
    static var medicationNotificationCategory: UIUserNotificationCategory {
        let category = UIMutableUserNotificationCategory()
        category.identifier = medicationNotificationCategoryIdentifier
        category.setActions([takeMedikationAction, delayMedicationAction], forContext: .Minimal)
        category.setActions([takeMedikationAction, delayMedicationAction], forContext: .Default)
        
        return category
    }
    
    static var medicationNotificationCategoryIdentifier: String {
        return "take_medikation_identifier"
    }
    
    static let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert.union(.Badge).union(.Sound), categories: [medicationNotificationCategory])
    
}







