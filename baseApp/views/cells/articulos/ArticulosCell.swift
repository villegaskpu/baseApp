//
//  ArticulosCell.swift
//  baseApp
//
//  Created by David on 9/9/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import SDWebImage
import a4SysCoreIOS

class ArticulosCell: UITableViewCell {
    
    @IBOutlet weak var imageArticulo: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var savoOrDeleteImage: UIButton!
    @IBOutlet weak var likeImage: UIButton!
    @IBOutlet weak var disLikeImage: UIButton!
    
    
    var articulo:Offer? {
        didSet {
            
            guard let infoCell = articulo else {return}
            
            setImageButons(articulo: infoCell)
            
            titulo.text = articulo?.title ?? ""
            descripcion.text = articulo?.offerDescription ?? ""
            
            titulo.font = UIFont.titleOferta
            descripcion.font = UIFont.textDescription
            
            let attributedString = NSAttributedString(string: infoCell.offerDescription, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            descripcion.attributedText = attributedString
            
            descripcion.textColor = UIColor.warmGrey
            
            
            var commerceLogo = infoCell.commerce.s3LogoURL != "" ? (infoCell.commerce.logoURL != "" ? infoCell.commerce.logoURL : nil) : nil
            var offerImage = infoCell.images.first?.s3URL != "" ? (infoCell.images.first?.imageURL != "" ? infoCell.images.first?.imageURL : nil) : nil
            offerImage = offerImage ?? commerceLogo
            commerceLogo = offerImage == commerceLogo ? nil : commerceLogo
            
            
            if offerImage != nil
            {
                imageArticulo.sd_setImage(with: URL.init(string: (offerImage?.replacingOccurrences(of: "{1}", with: "320").replacingOccurrences(of: "{2}", with: "full"))!), placeholderImage: nil)
            }
            else
            {
                imageArticulo.image = UIImage(named: "back_no")
            }
            
        }
    }
    
    
    
    private func setImageButons(articulo:Offer) {
        
        let infoCell = articulo
        if infoCell.rating != nil {
            let userRating = Int((infoCell.rating.rating))
            switch(userRating)
            {
            case 1:
                likeImage.setImage(UIImage(named: "LikeA"), for: UIControl.State.normal)
                disLikeImage.setImage(UIImage(named: "dislikeA"), for: UIControl.State.normal)
                savoOrDeleteImage.isHidden = true
            case 5:
                likeImage.setImage(UIImage(named: "LikeA"), for: UIControl.State.normal)
                disLikeImage.setImage(UIImage(named: "dislikeA"), for: UIControl.State.normal)
                savoOrDeleteImage.isHidden = true
            default:
                likeImage.setImage(UIImage(named: "LikeA"), for: UIControl.State.normal)
                disLikeImage.setImage(UIImage(named: "dislikeA"), for: UIControl.State.normal)
                savoOrDeleteImage.isHidden = true
            }
            
        } else {
            likeImage.setImage(UIImage(named: "LikeA"), for: UIControl.State.normal)
            disLikeImage.setImage(UIImage(named: "dislikeA"), for: UIControl.State.normal)
            savoOrDeleteImage.isHidden = true
        }
        
        if infoCell.favorite > 0 {
            savoOrDeleteImage.isHidden = false
            savoOrDeleteImage.setImage(UIImage(named: "deleteA"), for: UIControl.State.normal)
        } else {
            savoOrDeleteImage.isHidden = true
        }
        
        if infoCell.isFavorite {
            savoOrDeleteImage.setImage(UIImage(named: "deleteA"), for: UIControl.State.normal)
            likeImage.isHidden = true
            disLikeImage.isHidden = true
            savoOrDeleteImage.isHidden = false
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnLikeA(_ sender: Any) {
    }
    
    
    
    @IBAction func bntDisLikeA(_ sender: Any) {
    }
    
    
    @IBAction func btnFavoritosA(_ sender: Any) {
    }
    
}
