//
//  MasterTableViewController.swift
//  Mobelux
//
//  Created by Chase Giles on 7/23/21.
//

import UIKit

class MasterTableViewController: UITableViewController {

	// MARK: - Properties
	
	private var albums: [Album] = []
	
	// MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// Fetch data from provided URL
		
		APIManager.shared.fetchAlbums(withPhotoIndex: nil) { albums, error in
			
			// Check for error
			
			if let error = error {
				print(error.localizedDescription)
			}
			
			// Set albums equal to the retrieved values
			
			self.albums = albums
			
			// Reload table view on main thread
			
			DispatchQueue.main.sync {
				self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = albums[indexPath.row].title
        return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: "detailTableViewController") as! DetailTableViewController
		viewController.index = indexPath.row
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}
