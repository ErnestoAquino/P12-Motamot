//
//  SearchProtocolDelegate.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 26/07/2022.
//

import Foundation

protocol SearchDelegate: AnyObject {
    func warningMessage(_ message: String)
    func showActivityIndicator(_ value: Bool)
    func goToWordViewController()
}
