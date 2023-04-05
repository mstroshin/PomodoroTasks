import SwiftUI
import ComposableArchitecture

struct DayView: View {
    let store: StoreOf<DayFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ForEachStore(store.scope(state: \.tasks, action: DayFeature.Action.task)) { store in
                    TaskView(store: store)
                        .contextMenu {
                            Button {
//                                viewStore.send(.removePomodoro(id: pomodoroState.id))
                            } label: {
                                Label("Rename", systemImage: "pencil")
                            }

                            Button(role: .destructive) {
                                viewStore.send(.removeTask(id: ViewStore(store, observe: \.id).state))
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }

                PlusButtonView(didPressAction: { viewStore.send(.addTaskPressed) })
                    .frame(width: 52, height: 52)
                    .foregroundColor(Color(hex: 0xBC60D4))
                    .popover(store: store.scope(state: \.$addingNewTask, action: DayFeature.Action.addingNewTask), arrowEdge: .bottom) {
                        AddingNewTaskView(store: $0)
                    }
            }
        }
    }
}
