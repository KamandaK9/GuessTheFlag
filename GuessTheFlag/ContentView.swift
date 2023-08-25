//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Senga on 2023/02/27.
//

import SwiftUI

struct ContentView: View {
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var score = 0
	
    var body: some View {
		ZStack {
			RadialGradient(stops: [
				.init(color: .blue, location: 0.3),
				.init(color: .red, location: 0.3),
			], center: .top, startRadius: 200, endRadius: 700)
				.ignoresSafeArea()
			VStack {
				Spacer()
				Text("Guess the Flag")
					.font(.largeTitle.weight(.bold))
					.foregroundColor(.white)
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.font(.subheadline.weight(.heavy))
							.foregroundColor(.secondary)
						
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
							
						
						ForEach(0..<3) { number in
							Button {
								flagTapped(number)
							} label: {
								Image(countries[number])
									.renderingMode(.original)
									.clipShape(Capsule())
									.shadow(radius: 5)
							}
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
			.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				Spacer()
				Text("Score: ???")
					.foregroundColor(.white)
					.font(.title.bold())
				Spacer()
			}
			.padding()
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text("Your score is \(score)")
		}
		
		
    }
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			score += 1
			scoreTitle = "Correct"
		} else {
			scoreTitle = "Wrong"
		}
		showingScore = true
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
	
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
