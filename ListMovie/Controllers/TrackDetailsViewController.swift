//
//  TrackDetailsViewController.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Alamofire
import UIKit

class TrackDetailsViewController: UIViewController {
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var moviePrice: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    
    
    var trackViewModel : TrackViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        loadLabels()
    }
    
    // LoadLabels to set values for Artist Name and Movie Price and Genre Name.
    
    private func loadLabels() {
        artistName.text = trackViewModel?.artistName
        moviePrice.text = trackViewModel?.moviePrice
        movieGenre.text = trackViewModel?.genreName
    }
    
}
