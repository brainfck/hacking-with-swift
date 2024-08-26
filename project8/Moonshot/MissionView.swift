// Created by brainfck on 8/6/24.

import SwiftUI

struct MissionView: View {
  
  
  let mission: Mission
  let crew: [CrewMember]
  
  init(mission: Mission, astronauts: [String: Astronaut]) {
    self.mission = mission
    
    self.crew = mission.crew.map { member in
      if let astronaut = astronauts[member.name] {
        return CrewMember(role: member.role, astronaut: astronaut)
      } else {
        fatalError("Missing \(member.name)")
      }
    }
  }
  
  var body: some View {
    ScrollView {
      VStack {
        Image(mission.image)
          .resizable()
          .scaledToFit()
          .containerRelativeFrame(.horizontal) { width, axis in
            width * 0.6
          }
          .padding(.top)
        
        Text(mission.formattedLaunchDate)
        
        VStack(alignment: .leading) {
          customDivider
          
          Text("Mission Highlights")
            .font(.title.bold())
            .padding(.bottom, 5)
          
          Text(mission.description)
          
          customDivider
          
          Text("Crew")
            .font(.title.bold())
            .padding(.bottom, 5)
        }
        .padding(.horizontal)
        
        CrewView(crew: crew)
      }
      .padding(.bottom)
    }
    .navigationTitle(mission.displayName)
    .navigationBarTitleDisplayMode(.inline)
    .background(.darkBackground)
  }
  
  var customDivider: some View {
    Rectangle()
      .frame(height: 2)
      .foregroundStyle(.lightBackground)
      .padding(.vertical)
  }
}

struct CrewMember {
  let role: String
  let astronaut: Astronaut
}

struct CrewView: View {
  var crew: [CrewMember]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(crew, id: \.role) { crewMember in
          NavigationLink {
            AstronautView(astronaut: crewMember.astronaut)
          } label: {
            HStack {
              Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(.capsule)
                .overlay(
                  Capsule()
                    .strokeBorder(.white, lineWidth: 1)
                )
              
              VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                  .foregroundStyle(.white)
                  .font(.headline)
                
                Text(crewMember.role)
                  .foregroundStyle(.white.opacity(0.5))
              }
            }
            .padding(.horizontal)
          }
        }
      }
    }
  }
}

#Preview {
  let missions: [Mission] = Bundle.main.decode("missions.json")
  let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
  
  return MissionView(mission: missions[0], astronauts: astronauts)
    .preferredColorScheme(.dark)
}
