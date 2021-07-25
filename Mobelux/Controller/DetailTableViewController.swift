//
//  DetailTableViewController.swift
//  Mobelux
//
//  Created by Chase Giles on 7/23/21.
//

import UIKit

class DetailTableViewController: UITableViewController {

	// MARK: - Properties
	
	var albums: [Album] = []
	var albumPhotos: [UIImage] = []
	var index: Int?
	var loadingViewController: UIViewController?

	// MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Load the loading view controller
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		loadingViewController = storyboard.instantiateViewController(withIdentifier: "loadingViewController")
		loadingViewController?.modalPresentationStyle = .overFullScreen
		self.navigationController?.present(loadingViewController!, animated: false)
		
		// Make sure there is an index
		
		guard let index = index else { return }
		
		// Load albums for index
		
		APIManager.shared.fetchAlbums(withPhotoIndex: index) { albums, error in
			
			// Check for error
			
			if let error = error {
				print(error.localizedDescription)
				return
			}
			
			// Set albums from retrieved data
			
			self.albums = albums
			
			// Iterate through and get images
			
			for album in albums {
				let url = album.imageUrl
				let data = try? Data(contentsOf: url!)
				let image = UIImage(data: data!)
				self.albumPhotos.append(image!)
			}
			
			// Reload table view on the main thread and dismiss loading view controller
			
			DispatchQueue.main.sync {
				self.tableView.reloadData()
				self.loadingViewController?.dismiss(animated: false)
			}
		}
    }

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albums.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let album = albums[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.text = album.title
		cell.imageView?.image = albumPhotos[indexPath.row]
		
		return cell
	}

}
