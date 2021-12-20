import Foundation

struct MessageDTO: Identifiable, Codable {
    let content: String
    let authorId: String
    let id = UUID()
}
