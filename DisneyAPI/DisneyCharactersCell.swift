//
//  DisneyCharactersCell.swift
//  DisneyAPI
//
//  Created by Jamario Davis on 10/20/21.
//

import UIKit

class DisneyCharactersCell: UITableViewCell {
    


    @IBOutlet weak var disneyImageView: UIImageView!
    @IBOutlet weak var disneyCharacterNameLabel: UILabel!
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        disneyImageView.layer.cornerRadius = 8
        disneyImageView.clipsToBounds = true
    }
    
    func configureCell(for dc: DisneyCharacters) {
        disneyCharacterNameLabel.text = dc.name
        
        if dc.imageUrl != nil {
            
            ImageClient.fetchImage(for: dc.imageUrl) { [unowned self](result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.disneyImageView.image = image
                    }
                case .failure(let error):
                    print("configureCell image error - \(error)")
                }
            }
        }
    }
}
