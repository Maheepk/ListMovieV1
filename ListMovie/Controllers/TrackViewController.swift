//
//  TrackViewController.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {
    
    // Taken Track View Model Class for Getting Data to show on View
    
    var trackViewModel : TrackViewModel!
    
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    @IBOutlet weak var searchBarView : UISearchBar!
    
    // KSegueDetailScreen TableViewCell Identifier
    private let KSegueDetailScreen = "gotoDetailScreen"
    
    // SelectedIndex is for remembering count for Pressed Movie List
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        setupViewModel()
        
    }
    
    // Setting Up UI for This Controller
    private func setupUI() {
        activityIndicator.isHidden = true
        self.title = "Search Movie"
    }
    
    // Setting Up View Model for This Controller
    private func setupViewModel() {
        trackViewModel = TrackViewModel(self)
    }
    
    // Preparing to Next Screen and Sending View Model to Next Detail Screen.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == KSegueDetailScreen, let trackDetailsVC = segue.destination as? TrackDetailsViewController {
            trackDetailsVC.trackViewModel = trackViewModel.trackViewModel[self.selectedIndex]
        }
    }
}

// Extension TableView Delegate and Data Source..

extension TrackViewController : UITableViewDataSource, UITableViewDelegate {
    
    // Returing Number of Rows for Movie List
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackViewModel.trackViewModel.count
    }
    
    // TrackTableViewCell Setup Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as! TrackTableViewCell
        
        cell.setupCell(trackViewModel.trackViewModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    // SelectedIndex for Movie List.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: KSegueDetailScreen, sender: nil)
    }
    
    
}

extension TrackViewController : UISearchBarDelegate {
    
    // SearchBar Bar for Text.
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = searchBar.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        trackViewModel.fetchTracks(searchString: updatedText)
        
        return true
    }
    
}

// Extension for TrackViewModelDelegate..
extension TrackViewController : TrackViewModelDelegate {
    
    func trackData(_ viewModel: TrackViewModel?) {
        activityIndicator.isHidden = true
        self.tableView.reloadData()
    }
    
    func trackDataGetError(_ error: Error?) {
        activityIndicator.isHidden = true
        
        self.perform(#selector(self.alert(message:title:)), with: error?.localizedDescription ?? "", afterDelay: 1)
    }
    
}
