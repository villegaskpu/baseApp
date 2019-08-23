//
//  cellOffert.swift
//  baseApp
//
//  Created by David on 8/23/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import UIKit
import SDWebImage
import a4SysCoreIOS

class cellOffert: UITableViewCell {
    
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var offertTitle: UILabel!
    @IBOutlet weak var offertDistance: UILabel!
    
    
    // botones
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var saveOrDeleteImage: UIImageView!
    
    // imagenes
    @IBOutlet weak var newIndicator: UIImageView!
    @IBOutlet weak var offertImage: UIImageView!
    @IBOutlet weak var companyLogo: UIImageView!
    
    var indexPath:IndexPath?

    
    var offer: Offer? {
        didSet {
            guard let off = offer else {return}
            companyName.text = off.commerce.name
            offertTitle.text = off.title
            validDistanceOfert(off: off)
            setImageLogo(infoCell: off)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        offertDistance.adjustsFontSizeToFitWidth = true
        offertDistance.minimumScaleFactor = 0.3
        newIndicator.isHidden = true
    }
    
    override func prepareForReuse() {
        newIndicator.isHidden = true
    }
    
    private func validDistanceOfert(off:Offer) {
        if let distance = off.commerce.stores.first?.distance {
            if distance > 50 {
                if let city = off.commerce.stores.first?.city {
                    offertDistance.text = String(format: "%@", city)
                } else {
                    offertDistance.text = String(format: "%.02f km", distance)
                }
            } else {
                offertDistance.text = String(format: "%.02f km", distance)
            }
        } else {
            offertDistance.isHidden = true
        }
        
        if off.virtual > 0
        {
            offertDistance.text = "Oferta web"
        }
    }
    
    func setImageLogo(infoCell:Offer) {
        var commerceLogo = infoCell.commerce.s3LogoURL != "" ? (infoCell.commerce.logoURL != "" ? infoCell.commerce.logoURL : nil) : nil
        var offerImageP = infoCell.images.first?.s3URL != "" ? (infoCell.images.first?.imageURL != "" ? infoCell.images.first?.imageURL : nil) : nil
        offerImageP = offerImageP ?? commerceLogo
        commerceLogo = offerImageP == commerceLogo ? nil : commerceLogo
        
        _ = commerceLogo != nil ? (companyLogo.sd_setImage(with: URL.init(string: (commerceLogo?.replacingOccurrences(of: "{1}", with: "100").replacingOccurrences(of: "{2}", with: "full"))!), placeholderImage: nil)) : (companyLogo.isHidden = true)
        
        
        if offerImageP != nil {
            offertImage.sd_setImage(with: URL.init(string: (offerImageP?.replacingOccurrences(of: "{1}", with: "320").replacingOccurrences(of: "{2}", with: "full"))!), placeholderImage: nil)
        } else {
            offertImage.image = UIImage(named: "back_no")
        }
        
        if infoCell.isHome{ 
            if infoCell.viewed > 0 {
                newIndicator.isHidden = true
            } else {
                newIndicator.isHidden = false
            }
        }
        else{
            newIndicator.isHidden = true
        }
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
