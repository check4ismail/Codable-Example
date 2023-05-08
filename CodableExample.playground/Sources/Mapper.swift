import Foundation

public final class Mapper {
	public enum CodableType {
		case fruit, fruits, searchResult
		
		var fileURL: URL {
			let bundle = Bundle.main
			
			switch self {
			case .fruit:
				return bundle.url(forResource: "fruit", withExtension: "json")!
			case .fruits:
				return bundle.url(forResource: "fruits", withExtension: "json")!
			case .searchResult:
				return bundle.url(forResource: "search-results", withExtension: "json")!
			}
		}
		
		/// Setup custom-decoder based on
		var decoder: JSONDecoder {
			let decoder = JSONDecoder()
			switch self {
			case .searchResult:
				decoder.dateDecodingStrategy = .iso8601
			default:
				break
			}
			
			return decoder
		}
	}
	
	public static func decode<T: Codable>(_ type: CodableType) -> Result<T, Error> {
		do {
			let data = try Data(contentsOf: type.fileURL)
			let decoder = type.decoder
			let results = try decoder.decode(T.self, from: data)
			return .success(results)
		} catch {
			return .failure(error)
		}
	}
}

/// Explicitly specify type before calling `Mapper.decode()` function.
let fruit: Fruit = try! Mapper.decode(.fruit).get()
let fruits: Fruits = try! Mapper.decode(.fruits).get()
let searchResults: SearchResults = try! Mapper.decode(.searchResult).get()
