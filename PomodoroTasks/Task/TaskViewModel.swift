import Foundation

final class TaskViewModel: ObservableObject, Identifiable {
    let id: UUID
    let title: String

    init(
        id: UUID = UUID(),
        title: String
    ) {
        self.id = id
        self.title = title
    }

}
