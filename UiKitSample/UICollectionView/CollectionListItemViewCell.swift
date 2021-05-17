//
//  CollectionListItemViewCell.swift
//  UiKitSample
//
//  Created by Ryo Narisawa on 2021/05/14.
//

import Foundation
import UIKit

class CollectionListItemViewCell: UICollectionViewListCell {
    var id: UUID!
    var title: String!
    var author: String!
    var dateTime: String!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = ListItemCellConfiguration().updated(for: state)
        newConfiguration.id = id
        newConfiguration.title = title
        newConfiguration.author = author
        newConfiguration.dateTime = dateTime
        contentConfiguration = newConfiguration
    }
}

class ListItemView: UIView, UIContentView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    @IBOutlet private weak var datetimeLabel: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentConfiguration: ListItemCellConfiguration!
    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? ListItemCellConfiguration else {
                return
            }
            
            apply(configuration: newConfiguration)
        }
    }
    
    private func apply(configuration: ListItemCellConfiguration) {
        guard currentConfiguration != configuration else { return }
        
        currentConfiguration = configuration
        
        titleLabel.text = configuration.title
        authorLabel.text = configuration.author
        datetimeLabel.text = configuration.dateTime
    }
    
    init(newConfiguration: ListItemCellConfiguration) {
        super.init(frame: .zero)
        
        let nib = UINib(nibName: "CollectionListItem", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = frame
        
        addSubview(view)
        
        apply(configuration: newConfiguration)
    }
}

struct ListItemCellConfiguration: UIContentConfiguration, Hashable {
    var id: UUID!
    var title: String!
    var author: String!
    var dateTime: String!
    
    func makeContentView() -> UIView & UIContentView {
        return ListItemView(newConfiguration: self)
    }
    
    func updated(for state: UIConfigurationState) -> ListItemCellConfiguration {
        return self
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ListItemCellConfiguration, rhs: ListItemCellConfiguration) -> Bool {
        lhs.id == rhs.id
    }
}


