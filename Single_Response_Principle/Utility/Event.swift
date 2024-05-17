//
//  Event.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 11/10/23.
//

import Foundation

enum Event{
    case startLoading
    case stopLoading
    case reloadData
    case error(FetchingError)
}
