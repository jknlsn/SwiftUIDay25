//
//  ContentView.swift
//  SwiftUIDay25
//
//  Created by Jake Nelson on 19/4/20.
//  Copyright © 2020 Jake Nelson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var moves = ["Rock", "Paper", "Scissors"]
    var symbols = ["circle", "doc", "scissors"]
    
    @State var appChoice: Int = Int.random(in: 0...2)
    @State var shouldWin: Bool = Bool.random()
    
    @State var points = 0
    @State var turn = 1
    
    @State var showingAlert = false
    
    @State var results = ""
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("Round: \(turn)/10")
            
            Spacer()
            
            if shouldWin {
                Text("WIN")
            }
            else {
                Text("LOSE")
            }
            
            Text("against")
            
            Text("\(moves[appChoice])")
            
            Spacer()
            
            HStack{
                Spacer()
                ForEach(moves.indices, id: \.self) {
                    index in
                    Group{
                        Spacer()
                        Button(action: {
                            // Record results
                            self.results += "Picked \(self.moves[index]) to \( self.shouldWin ? "WIN":"LOSE" ) against \(self.moves[self.appChoice])"
                            
                            self.yourMove(index: index)
                            
                            // reset shouldWin and the appChoice
                            self.shouldWin = Bool.random()
                            self.appChoice = Int.random(in: 0...2)
                            
                            self.turn += 1
                            
                            if self.turn > 10 {
                                self.showingAlert = true
                            }
                            
                        }) {
                            VStack{
                                Image(systemName: "\(self.symbols[index])")
                                    .imageScale(.large)
                                Text("\(self.moves[index])")
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Finished!"),
                  message: Text("Scored \(points) points.\n\(results)"),
                  dismissButton: .default(
                    Text("OK"),
                    action: {
                        self.turn = 1
                        self.points = 1
                        self.appChoice = Int.random(in: 0...2)
                        self.shouldWin = Bool.random()
                  }
                )
            )
        }
    }
    
    func yourMove(index: Int){
        if self.shouldWin {
            if (self.appChoice + 1) % 3 == index {
                self.points += 1
                self.results += ": +1\n"
            }
            else {
                self.points -= 1
                self.results += ": -1\n"
            }
        }
        else {
            if (index + 1) % 3 == self.appChoice {
                self.points += 1
                self.results += ": +1\n"
            }
            else {
                self.points -= 1
                self.results += ": -1\n"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
