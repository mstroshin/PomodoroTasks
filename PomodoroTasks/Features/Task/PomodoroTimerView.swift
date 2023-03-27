import SwiftUI
import ComposableArchitecture

struct PomodoroTimerState: Equatable, Identifiable {
    let id = UUID()
    let type: PomodoroType
    let initialTimeInMinutes: Int

    var progress = 0.0 // 0.0 to 1.0
    var isCompleted: Bool {
        progress >= 1.0
    }
}

struct PomodoroTimerView: View {
    let state: PomodoroTimerState
    private let lineWidth = 3.0

    var body: some View {
        switch state.type {
        case .inAction:
            actionTimerView
        case .break:
            breakTimerView
        }
    }

    private var breakTimerView: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .fill(Color("breakLineBg"))
                    .cornerRadius(proxy.size.width / 2)

                Rectangle()
                    .fill(Color("breakLineFg"))
                    .cornerRadius(proxy.size.width / 2)
                    .offset(y: proxy.size.height - state.progress * proxy.size.height)
            }
            .clipped()
            .cornerRadius(proxy.size.width / 2)
        }
    }

    private var actionTimerView: some View {
        ZStack {
            Circle()
                .stroke(Color("circleStrokeBg"), lineWidth: lineWidth)

            Circle()
                .rotation(.degrees(-90))
                .trim(from: 0, to: state.progress)
                .stroke(Color("circleStrokeFg"), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))

            if state.isCompleted {
                Circle()
                    .foregroundColor(Color("circleStrokeFg"))

                VStack {
                    HStack {
                        Spacer()
                        completeView
                            .frame(width: 14, height: 14)
                    }
                    Spacer()
                }
            }

            Text("\(state.initialTimeInMinutes)")
                .foregroundColor(state.isCompleted ? Color.white : Color("circleStrokeFg"))
                .font(.system(size: 16, weight: .bold))
        }
        .padding(lineWidth / 2)
    }

    private var completeView: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .background(
                    Color("circleStrokeBg")
                        .clipShape(Circle())
                )

            Image("checkmark_icon")
                .foregroundColor(Color("circleStrokeFg"))
        }
    }

}

struct PomodoroTimerView_Previews: PreviewProvider {
    static var previews: some View {
        let actionState = PomodoroTimerState(type: .inAction, initialTimeInMinutes: 2, progress: 0.4)
        let breakState = PomodoroTimerState(type: .inAction, initialTimeInMinutes: 2, progress: 0.4)

        Group {
            PomodoroTimerView(state: actionState)
                .frame(width: 48, height: 48)

            PomodoroTimerView(state: breakState)
                .frame(width: 4, height: 48)
        }
    }
}
