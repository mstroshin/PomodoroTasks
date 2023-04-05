import SwiftUI
import ComposableArchitecture

struct TaskView: View {
    @FocusState var titleFocusState: Bool
    let store: StoreOf<TaskFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image("pomodoro_icon")
                            .frame(width: 32, height: 32)

                        TextField("", text: viewStore.binding(get: \.title, send: TaskFeature.Action.titleTyped))
                            .textFieldStyle(.plain)
                            .focused($titleFocusState)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.black)
                            .onSubmit {
                                titleFocusState = false
                            }
                    }

                    HStack {
                        ForEach(viewStore.pomodoros) { pomodoroState in
                            PomodoroTimerView(state: pomodoroState)
                                .frame(
                                    width: getPomodoroViewSize(for: pomodoroState.type).width,
                                    height: getPomodoroViewSize(for: pomodoroState.type).height
                                )
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewStore.send(.removePomodoro(id: pomodoroState.id))
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }

                        PlusButtonView(didPressAction: { viewStore.send(.addPomodoroPressed) })
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(hex: 0x5D74FC))
                            .popover(
                                store: store.scope(state: \.$addingPomodoro, action: TaskFeature.Action.addingPomodoro),
                                arrowEdge: .bottom
                            ) { store in
                                AddingNewPomodoroView(store: store)
                            }
                    }
                }
                .padding(12)

                Spacer()

                if let id = viewStore.currentPomodoroId, let currentPomodoro = viewStore.pomodoros[id: id] {
                    playButtonView(with: currentPomodoro, viewStore: viewStore)
                        .frame(width: 80)
                }
            }
            .background {
                Color("bg")
            }
            .cornerRadius(12)
            .onTapGesture {
                titleFocusState = false
            }
            .contextMenu {
                Button(role: .destructive) {
                    viewStore.send(.removePressed)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }

    private func playButtonView(with currentPomodoro: PomodoroTimerState, viewStore: ViewStoreOf<TaskFeature>) -> some View {
        let color = currentPomodoro.type == .inAction ? Color("circleStrokeFg") : Color("breakLineFg")
        let formattedTime = format(minutes: currentPomodoro.initialTimeInMinutes, progress: currentPomodoro.progress)
        let buttonIcon  = Image(viewStore.isPlaying ? "pause_icon" : "play_icon")

        return ZStack {
            Color.white
                .shadow(color: Color(hex: 0x303544, alpha: 0.12), radius: 10, x: 0, y: 0)

            VStack {
                ZStack {
                    color
                        .frame(width: 48, height: 48)
                        .cornerRadius(12)

                    buttonIcon
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    viewStore.send(.startPomodoroPressed)
                }

                if viewStore.isPlaying {
                    Text(formattedTime)
                        .foregroundColor(color)
                        .font(.system(size: 14, weight: .medium))
                        .transition(.move(edge: .top))
                }
            }
        }
    }

    private func format(minutes: Int, progress: Double) -> String {
        let seconds = Double(minutes * 60) *  (1.0 - progress)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: seconds) ?? "X"
    }

    private func getPomodoroViewSize(for type: PomodoroType) -> CGSize {
        switch type {
        case .inAction:
            return CGSize(width: 48, height: 48)
        case .break:
            return CGSize(width: 4, height: 48)
        }
    }

}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        let vm = TaskViewModel(title: "First Task")
//        vm.timers = [
//            PomodoroTimerViewModel(id: UUID(), type: .inAction, initialTimeInMinutes: 1, progress: 0),
//            PomodoroTimerViewModel(id: UUID(), type: .break, initialTimeInMinutes: 5, progress: 0.2),
//            PomodoroTimerViewModel(id: UUID(), type: .inAction, initialTimeInMinutes: 30, progress: 0),
//        ]
//        vm.currentTimer = vm.timers[0]
//
//        return TaskView(vm: vm)
//            .frame(width: 400, height: 120)
//    }
//}
