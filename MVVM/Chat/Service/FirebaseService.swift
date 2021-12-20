/*
    Publisher -> Observer
    Subject
 */
import Combine
import FirebaseDatabase

final class FirebaseService {
    let messagePublisher = PassthroughSubject<MessageDTO, Error>()
    
    init() {
        Nodes.messages.observe(.childAdded) { snapshot in
            guard let message = snapshot.value as? [String : String],
                  let content = message["content"],
                  let authorId = message["authorId"]
            else { return }
            
            self.messagePublisher.send(MessageDTO(
                content: content,
                authorId: authorId
            ))
        }
    }
    
    func add(message: MessageDTO) {
        let data = try! JSONEncoder().encode(message)
        let dict = try! JSONSerialization.jsonObject(with: data, options: [])
        Nodes.messages.childByAutoId().setValue(dict)
    }
}

extension FirebaseService {
    enum Nodes {
        static let messages = Database.database().reference().child("messages")
    }
}
