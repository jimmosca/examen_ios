//
//  CategoryViewCell.swift
//  examen_ios
//
//  Created by Jaime Casado Aparicio on 26/2/20.
//  Copyright © 2020 Jaime Casado Aparicio. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell{
    static let cIdentifier = String(describing: CategoryViewCell.self)
    
    static let cRowHeight: CGFloat = 32
    
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var cNameLabel: UILabel!
    
    override func prepareForReuse() {
        cNameLabel.text = nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure(view: cView)
        
    }
    
    func configure(view: UIView){
        view.layer.cornerRadius = 8.0
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 8.0
        view.layer.shadowOpacity = 0.6
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func update(data: String?){
        guard let name = data else { return  }
        update(name: name)
    }
    
    private func update(name: String?){
        cNameLabel.text = name
    }
    
    
}
