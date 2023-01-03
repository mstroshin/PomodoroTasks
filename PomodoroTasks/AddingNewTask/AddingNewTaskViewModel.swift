import Foundation

final class AddingNewTaskViewModel: ObservableObject {
    @Published var title: String = ""

    var doneHandler: ((String) -> Void)?

    func doneButtonPressed() {
        doneHandler?(title)
    }

}
