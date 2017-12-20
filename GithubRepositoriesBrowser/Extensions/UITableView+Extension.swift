//
//  UITableView+Extension.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/20/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type) -> T {
        let identifier = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            preconditionFailure()
        }
        return cell
    }
    
    func registerNibWithSameNameAsClass(type: UITableViewCell.Type) {
        let name = String(describing: type)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: name)
    }
    
    func reloadRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation = .automatic) {
        beginUpdates()
        reloadRows(at: [indexPath], with: animation)
        endUpdates()
    }
    
    func performOnUpdates(_ block: () -> ()) {
        beginUpdates()
        block()
        endUpdates()
    }
}
