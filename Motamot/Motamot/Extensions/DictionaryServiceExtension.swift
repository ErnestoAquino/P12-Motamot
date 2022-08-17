//
//  DictionaryServiceExtension.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 26/07/2022.
//

import Foundation

extension DictionaryService: SearchDelegate {
    /**
     This function displays an alert to the user.
     
     - parameter message: String with the message to be displayed in the alert.
     */
    func warningMessage(_ message: String) {
        viewDelegate?.warningMessage(message)
    }
    /**
     This button shows (or hides) the activity indicator.
     
     - parameter value: True to show. False to hide.
     */
    func showActivityIndicator(_ value: Bool) {
        viewDelegate?.showActivityIndicator(value)
    }
    /**
     This method navigate to word view control.
     */
    func goToWordViewController() {
        viewDelegate?.goToWordViewController()
    }
}
