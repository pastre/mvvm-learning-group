import Combine

final class ChatViewModel: ObservableObject {
    private let sendMessageUseCase = SendMessageUseCase()
    private let fetchMessagesUseCase = FetchMessagesUseCase()
    private var cancelBag: [AnyCancellable] = []
    
    @Published
    private(set) var messages: [ChatView.Message] = []
    
    @Published
    private(set) var isLoading = true
    
    @Published
    var newMessageText: String = ""
    
    init() {
        let cancellable = fetchMessagesUseCase
            .onMessage()
            .sink { [weak self] message in
                self?.messages.append(.init(
                    content: message.content,
                    backgroundColor: message.amITheAuthor ? .green : .white,
                    orientation: message.amITheAuthor ? .left : .right))
                self?.isLoading = self?.messages.count == 0
            }
        cancelBag.append(cancellable)
    }
    
    deinit {
        cancelBag.removeAll()
    }
    
    func sendMessage() {
        sendMessageUseCase.execute(using: newMessageText)
        newMessageText = ""
    }
}

extension Array where Element == AnyCancellable {
    func removeAll() {
        forEach { $0.cancel() }
    }
}
