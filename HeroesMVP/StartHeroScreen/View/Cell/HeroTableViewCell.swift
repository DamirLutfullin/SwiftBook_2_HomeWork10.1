//
//  HeroTableViewCell.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 18.10.2020.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    
    // Свойство для отмены загрузки картинки, в случае быстрого скрола пользователем, когда картинка еще не загрузилась, а ячейка уже переиспользуется
    private weak var task: URLSessionTask?
    private var cornerRadius: CGFloat = 15
    
    @IBOutlet var containerViewForCell: UIView!
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var fullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.containerViewForCell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        heroImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heroImageView.layer.cornerRadius = cornerRadius
        containerViewForCell.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        self.heroImageView?.image = #imageLiteral(resourceName: "ImagePlaceholder")
        self.fullName.text = nil
    }
    
    func configurate(hero: Hero) {
        fullName.text = hero.name
        setImage(hero: hero)
    }
    
    private func setImage(hero: Hero) {
        let urlString = hero.images.lg
        task = NetworkManager.shared.downloadImageForCell(urlString: urlString, completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                self?.heroImageView?.image = image
                self?.task = nil
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
