//
//  FullScreenCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/20.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class FullScreenCell: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black ])
        attributedText.append(.init(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]))
        attributedText.append(.init(string: "\n\n\nHeroic advanture", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black ]))
        attributedText.append(.init(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.gray ]))
        attributedText.append(.init(string: "\n\n\nHeroic advanture", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.black ]))
        attributedText.append(.init(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [ NSAttributedString.Key.foregroundColor: UIColor.gray ]))
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(label)
        label.fillSuperview(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
