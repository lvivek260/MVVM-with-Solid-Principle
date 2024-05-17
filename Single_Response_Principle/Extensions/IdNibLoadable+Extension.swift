//
//  Cell+Extension.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 12/10/23.
//

import UIKit
protocol IdNibLoadable{
    static var id: String { get }
    static var nib: UINib { get }
}

extension IdNibLoadable{
    static var id: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
}

extension UIViewController: IdNibLoadable { }

extension UITableViewCell: IdNibLoadable { }

extension UICollectionViewCell: IdNibLoadable { }

