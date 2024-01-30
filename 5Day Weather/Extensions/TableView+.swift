//
//  TableView+.swift
//  5Day Weather
//
//  Created by Adel on 1/26/24.
//

import UIKit

extension UITableView {
    func registerCellNib<T: UITableViewCell>(_ cellType: T.Type) {
            let className = String(describing: cellType)
            let nib = UINib(nibName: className, bundle: nil)
            register(nib, forCellReuseIdentifier: className)
        }

    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: cellType)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(className)")
        }
        return cell
    }
}
