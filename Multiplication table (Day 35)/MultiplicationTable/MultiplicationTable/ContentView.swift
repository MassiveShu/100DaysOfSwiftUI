//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Max Shu on 21.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectNumbers = 0
    @State private var selectQuestions = 5
    var questions = [5, 10, 15, 20]
    @State private var selectDifficulty = 0 // 0 = easy, 1 = normal, 2 = hard
    var difficulty = ["Easy", "Normal", "Hard"]
    
    @State private var questionsList: [Question] = []
    @State private var currentQuestion = 0
    @State private var correctAnswerCounter = 0
    @State private var animationAmount = 0.0
    
    @State private var gameStarted = false
    @State private var gameEnded = false
    @State private var isQuestionAnswered = false
    
    @State private var selectedAnswer = ""
    @State var answerAlertTitle = ""
    @State var answerAlertMessage = ""
    
    
    // HEADER
    var header: String {
        if !gameEnded && !gameStarted {
            return "Multiplication table"
        } else if gameStarted && !gameEnded {
            return "Question: \(currentQuestion + 1) of \(question)"
        } else if gameStarted && gameEnded {
            return "Results"
        } else {
            return "Everything is broken..."
        }
    }
    
    // TITLE
    var title: String {
        return  selectDifficulty == 0 ? "Easy" : selectDifficulty == 1 ? "Normal" : "Hard"
    }
    
    var question: Int { Int(selectQuestions) }
    var number: Int { selectNumbers + 2 }
    var numberOfAnswers: Int { selectDifficulty + 2 }
    
    
    // FIRST SCREEN - BODY VIEW
    var body: some View {
        NavigationView {
            Group {
                if !gameEnded && !gameStarted {
                    settingsView
                } else if !gameEnded && gameStarted {
                        questionView
                    } else if gameEnded && gameStarted {
                            resultView
                        }
            }.navigationTitle(header)
            .alert(answerAlertTitle, isPresented: $isQuestionAnswered) {
                Button("OK", action: showNextQuestion)
            } message: {
                Text(answerAlertMessage)
            }
        }
    }
    
    // SETTINGS VIEW
    var settingsView: some View {
        NavigationView {
            Form {
                Section {
                Picker("Choose a number to learn:", selection: $selectNumbers) {
                    ForEach(2..<13) {
                    Text("\($0)")
                        }
                } .font(.headline)
                }
        
                Section {
                    Text("How many questions?")
                    Stepper("\(selectQuestions)", value: $selectQuestions, in: 5...20, step: 5)
                }
                .font(.headline)
                
                Section {
                    Text("Difficulty:")
                    Picker("Difficulty", selection: $selectDifficulty) {
                        Text("Easy").tag(0)
                        Text("Normal").tag(1)
                        Text("Hard").tag(2)
                    } .pickerStyle(.segmented)
                } .font(.headline)
            }

            // START BUTTON
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Start", action: startButton)
                        .frame(width: 300, height: 50)
                        .foregroundColor(.black)
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.yellow, radius: 5, y: 5)
                        .font(.largeTitle.bold())
                }
            }
        }
    }
    
    // QUESTION VIEW
    var questionView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.yellow.opacity(0.85))
                .padding()
                .shadow(radius: 5)
            
            VStack(spacing: 50) {
                Text(questionsList[currentQuestion].text)
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                VStack(spacing: 20) {
                    ForEach(questionsList[currentQuestion].answers, id: \.self) { answer in
                        Button {
                            isQuestionAnswered = true
                            selectedAnswer = answer
                            withAnimation(.easeInOut(duration: 0.85)) {
                                checkAnswer()
                                animationAmount += 360.0
                            }
                        } label: {
                            Text(answer)
                                .padding()
                                .font(.largeTitle.bold())
                                .frame(width: 250, height: 50)
                                .background(.white)
                                .foregroundColor(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }.shadow(radius: 4)
                    }
                }
            }.opacity(!isQuestionAnswered ? 1 : 0)
                .scaleEffect(!isQuestionAnswered ? 1 : 0.75)
                .foregroundColor(.white)
        }
    }
    
    // RESULT VIEW
    var resultView: some View {
        VStack (spacing: 50) {
            Spacer()
            VStack (spacing: 50) {
            Text("\(correctAnswerCounter) of \( question) \n answers were correct.")
                .font(.title2.bold())
                .foregroundColor(.primary)
            }.multilineTextAlignment(.center)
            Spacer()
            Button(action: restartGame) {
                Text("Try again")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.black)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(color: Color.yellow, radius: 5, y: 5)
                    .font(.largeTitle.bold())
            }
            Spacer()
        }.padding()
    }
    
    
    // START BUTTON
    func startButton() {
        generateQuestions()
        if !questionsList.isEmpty {
            gameStarted = true
        }
    }
    
    
    // GENERATE QUESTION
    func generateQuestions() {
        for _ in 0..<question {
            let secondNumber = Int.random(in: 1...12)
            let text = "\(number) x \(secondNumber) ="
            let correctAnswer = number * secondNumber
            let answers = generateAnswers(number, and: secondNumber)
            let question = Question(text: text, correctAnswer: correctAnswer, answers: answers)
            questionsList.append(question)
        }
    }

    // NEXT QUESTION
    func showNextQuestion() {
        if currentQuestion < question - 1 {
            currentQuestion += 1
            selectedAnswer = ""
        } else {
            gameEnded = true
        }
    }
    
    
    // ANSWER CHECK
     func checkAnswer() {
         var title = ""
         if selectedAnswer == String(questionsList[currentQuestion].correctAnswer) {
             correctAnswerCounter += 1
            // title += " is happy"
             answerAlertMessage =  "You are right, keep going!"
             
         } else {
             title += "Let me help you"
             answerAlertMessage = "Remember: \n\(questionsList[currentQuestion].text) \(questionsList[currentQuestion].correctAnswer)"
         }
         answerAlertTitle = title
     }
    
    
    // GENERATE ANSWER
    func generateAnswers(_ number: Int, and secondNumber: Int) -> [String] {
        var answers = [String]()
        answers.append("\(number * secondNumber)")
        answers.append("\((number - 1) * secondNumber)")
        for i in 1..<numberOfAnswers - 1 {
            let answer = "\((i + number) * secondNumber)"
            answers.append(answer)
        }
        return answers.shuffled()
    }
    
    // RESTART GAME
    func restartGame() {
        gameEnded = false
        gameStarted = false
        
        questionsList = []
        currentQuestion = 0
        correctAnswerCounter = 0
        selectedAnswer = ""
    }
    

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
