//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Carson Gross on 5/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moveChoice = ""
    @State private var ifShouldWin = Bool.random()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var round: Int = 1
    @State private var restartGame = false
    
    var loseMove: Int {
        switch correctAnswer{
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 0
        default:
            return 0
        }
    }
    
    let choices = ["Rock 🪨", "Paper 📜", "Scissors ✂️"]
    let winMove = ["Paper", "Scissors", "Rock"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.0, green: 0.3, blue: 1), location: 0.8),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack {
                    Text("\(choices[correctAnswer])")
                        .pill(50)
                    Text("\(ifShouldWin == true ? "Win" : "Lose")")
                        .pill(25)
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                if ifShouldWin {
                                    winButtonTapped(number)
                                } else {
                                    loseButtonTapped(number)
                                }
                                askQuestion()
                                if round == 11 {
                                    restartGame = true
                                    restart()
                                }
                            } label: {
                                Text("\(winMove[number])")
                            }
                            .choices()
                        }
                    }
                    
                    
                    Text("Score: \(score)")
                        .foregroundColor(.primary)
                        .font(.title.bold())
                }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Round: \(round)/10")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $restartGame) {
            Button("Restart Game", action: restart)
        }
    }
    
    
    func winButtonTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
    }
    func loseButtonTapped(_ number: Int) {
        if number == loseMove{
            score += 1
        } else {
            score -= 1
        }
    }
    func askQuestion() {
        ifShouldWin.toggle()
        correctAnswer = Int.random(in: 0...2)
        round += 1
    }
    func restart() {
        scoreTitle = "You score \(score) points!"
        score = 0
        round = 1
    }
}

struct Pill: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 50)
            .padding(.vertical, 20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.red)
            .font(.largeTitle.bold())
    }
    
    var paddingHorizontal: Int
    
    init(paddingHorizontal: Int) {
        self.paddingHorizontal = paddingHorizontal
    }
}

extension View {
    func pill(_ horizontalPadding: Int) -> some View {
        modifier(Pill(paddingHorizontal: horizontalPadding))
    }
}

struct Choices: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.blue)
            .font(.system(size: 25))
    }
}

extension View {
    func choices() -> some View {
        modifier(Choices())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
