//
//  TrackTableViewCell.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import SDWebImage

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImage : UIImageView!
    
    @IBOutlet weak var movieNameLabel : UILabel!

    @IBOutlet weak var releaseDateYearLabel : UILabel!
    
    var trackViewModel : TrackViewModel?
    
    // Setup Cell for Track View Model
    
    func setupCell(_ trackViewModel : TrackViewModel?)  {
        
        if let _trackViewModel = trackViewModel {
            
            self.releaseDateYearLabel.text =  _trackViewModel.releaseDate
            self.movieNameLabel.text =  _trackViewModel.movieName
            self.previewImage.sd_setImage(with: URL(string: _trackViewModel.artworkUrl), completed: nil)
        }
    }
    
}
