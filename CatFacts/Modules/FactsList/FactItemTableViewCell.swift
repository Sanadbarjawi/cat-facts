//
//  FactItemTableViewCell.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import UIKit

class FactItemTableViewCell: UITableViewCell {
    
    static var identifier: String = String(describing: FactItemTableViewCell.self)
    
    private lazy var factLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var verifiedImageView : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "verified"))
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var newImageView : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "new"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    fileprivate func configureUI() {
        newImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        newImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let iconsStackView = UIStackView(arrangedSubviews: [verifiedImageView, newImageView])
        iconsStackView.distribution = .fillEqually
        iconsStackView.alignment = .center
        iconsStackView.axis = .horizontal
        iconsStackView.spacing = 5
        
        
        let containerStackView = UIStackView(arrangedSubviews: [factLabel, iconsStackView])
        containerStackView.distribution = .fill
        containerStackView.alignment = .leading
        containerStackView.axis = .vertical
        containerStackView.spacing = 5
        addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ object: CatFact?) {
        if let fact = object {
            factLabel.text = fact.text
            verifiedImageView.isHidden = fact.status.verified == false
            newImageView.isHidden = fact.status.isNew == false
        }
    }
                   
}
