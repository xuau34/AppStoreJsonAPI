//
//  ReviewsCell.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/16.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit

class ReviewsCell: UICollectionViewCell {
    
    var entry: JsonReviewEntry? {
        didSet{
            guard let entry = entry else { return }
            title.text = entry.title.label
            author.text = entry.author.name.label
            content.text = entry.content.label
            
            let rating = Int(entry.rating.label) ?? 0
            for (index, view) in stars.arrangedSubviews.enumerated() {
                view.alpha = index < rating ? 1 : 0
            }
        }
    }
    
    let title = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    let author = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let stars: UIStackView = {
        var views = [UIView]()
        for _ in (0..<5){
            let imageView = UIImageView()
            imageView.image = UIImage(named: "star")
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            views.append(imageView)
        }
        views.append(UIView())
        return UIStackView(arrangedSubviews: views)
    }()
    let content = UILabel(text: "content", font: .systemFont(ofSize: 13), numberOfLines: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(white: 0.9, alpha: 1)
        layer.cornerRadius = 6
        
        title.setContentCompressionResistancePriority(.init(rawValue: 0), for: .horizontal)
        author.textAlignment = .right
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                title, author
            ], customSpacing: 6),
            stars,
            content
        ], spacing: 12)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
