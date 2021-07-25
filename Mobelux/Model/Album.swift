//
//  Album.swift
//  Mobelux
//
//  Created by Chase Giles on 7/23/21.
//

import UIKit

class Album: NSObject {
	
	// MARK: - Properties
	
	var albumId: Int
	var id: Int
	var title: String
	var imageUrl: URL?
	var thumbnailUrl: URL?
	
	// MARK: - Initialization
	
	init(albumId: Int, id: Int, title: String) {
		self.albumId = albumId
		self.id = id
		self.title = title
	}
	
	init(albumId: Int, id: Int, title: String, imageUrl: URL?, thumbnailUrl: URL?) {
		self.albumId = albumId
		self.id = id
		self.title = title
		self.imageUrl = imageUrl
		self.thumbnailUrl = thumbnailUrl
	}
}
