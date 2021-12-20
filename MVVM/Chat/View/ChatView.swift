import SwiftUI

struct ChatView: View {
    
    struct Message: Identifiable {
        let content: String
        let backgroundColor: Color
        let orientation: Orientation
        let id = UUID()
        enum Orientation {
            case left
            case right
        }
    }
    
    @ObservedObject
    var viewModel = ChatViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            VStack {
                List(viewModel.messages) { message in
                    Text(message.content)
                        .background(message.backgroundColor)
                }
                ZStack {
                    TextField("Mensagem", text: $viewModel.newMessageText)
                    Button(action: viewModel.sendMessage) {
                        Text("Enviar")
                    }
                }
            }
        }
    }
    
    private var loadingView: some View {
        List([String](repeating: "", count: 100).map { _ in UUID().uuidString }, id: \.self) { string in
            Text(string)
        }.redacted(reason: .placeholder)
    }
}
