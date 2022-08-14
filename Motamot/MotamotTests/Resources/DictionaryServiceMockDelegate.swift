//
//  DictionaryServiceMockDelegate.swift
//  MotamotTests
//
//  Created by Ernesto Elias on 14/08/2022.
//

import Foundation
@testable import Motamot

class DictionaryServiceMockDelegate: SearchDelegate {
    private (set) var warningMessageIsCalled = false
    private (set) var showActivityIndicatorIsCalled = false
    private (set) var goToWordViewControllerIsCalled = false

    func warningMessage(_ message: String) {
        warningMessageIsCalled = true
    }

    func showActivityIndicator(_ value: Bool) {
        showActivityIndicatorIsCalled = true
    }
    
    func goToWordViewController() {
        goToWordViewControllerIsCalled = true
    }

    func reloadTableView() {
        //TODO: to delete
    }
}
