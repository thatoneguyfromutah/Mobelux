//
//  APIManager.swift
//  Mobelux
//
//  Created by Chase Giles on 7/23/21.
//

import UIKit

class APIManager: NSObject {

	// MARK: - Singleton
	
	static let shared: APIManager = {
		return APIManager()
	}()
	
	// MARK: - REST
	
	func fetchAlbums(withPhotoIndex index: Int?, completion: @escaping ([Album], Error?) -> Void) {
		
		// Main url to request data from
		
		var url: URL?
		
		if let index = index {
			url = URL(string: "http://jsonplaceholder.typicode.com/albums/\(index)/photos")
		} else {
			url = URL(string: "http://jsonplaceholder.typicode.com/albums")
		}
		
		let request = URLRequest(url: url!)
		
		// URL task to retrieve data
		
		let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in

			do {
				
				// Properties related to JSON parsing
				
				let json = try JSONSerialization.jsonObject(with: data!) as! [NSDictionary]
				var albums: [Album] = []
				
				// Iterate through albums and add to array
				
				for item in json {
					
					let album: Album
					
					guard let albumId = item["albumId"] as? Int ?? item["userId"] as? Int,
						  let id = item["id"] as? Int,
						  let title = item["title"] as? String
					else { return }
					
					if let imageUrl = item["url"] as? String,
					   let thumbnailUrl = item["thumbnailUrl"] as? String {
						album = Album(albumId: albumId, id: id, title: title, imageUrl: URL(string: imageUrl), thumbnailUrl: URL(string: thumbnailUrl))
					} else {
						album = Album(albumId: albumId, id: id, title: title)
					}
					
					albums.append(album)
				}
				
				// Completion and return values
				
				completion(albums, error)
				
			} catch let error {
				
				completion([], error)
			}
		})
		
		task.resume()
	}
}
