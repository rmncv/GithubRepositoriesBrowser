//
//  GithubRepositoryCell.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 12/20/17.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class GithubRepositoryCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var isViewedLabel: UILabel!
}

extension GithubRepositoryCell {
    func configure(with repository: GithubRepositoryPlain) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.repositoryDescription
        starsCountLabel.text = String(repository.stars)
        isViewedLabel.isHidden = !repository.isViewed
    }
}
