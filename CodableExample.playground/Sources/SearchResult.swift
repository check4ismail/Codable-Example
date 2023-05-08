import Foundation

public struct SearchResults: Codable {
	let items: [SearchResult]
}

public struct SearchResult: Codable {
	let id: String
	let description: String
	let title: String
	let imageURL: String
	let date: Date
	
	/// Outer keys to map to JSON response data.
	enum CodingKeys: CodingKey {
	   case data
	   case links
	}
	
	/// Sub-model of `SearchResult` containing most elements.
	private struct Data: Codable {
		let nasa_id: String
		let description: String
		let title: String
		let date_created: Date
	}
	
	/// Sub-model of `SearchResult` that contains the `imageURL` link.
	private struct Link: Codable {
		let href: String
	}
	
	public init(from decoder: Decoder) throws {
		/// 1
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		/// 2
		let datas = try container.decode([Data].self, forKey: .data)
		
		/// 3
		let links = try container.decode([Link].self, forKey: .links)
		
		/// 4
		let data = datas.first!
		let link = links.first!
		
		/// 5
		description = data.description
		title = data.title
		id = data.nasa_id
		imageURL = link.href
		date = data.date_created
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		let data = Data(nasa_id: id, description: description, title: title, date_created: date)
		let link = Link(href: imageURL)
			
		try container.encode([data], forKey: .data)
		try container.encode([link], forKey: .links)
	}
}
