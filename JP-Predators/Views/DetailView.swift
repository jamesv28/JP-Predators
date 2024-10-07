//
//  DetailView.swift
//  JP-Predators
//
//  Created by James Volmert on 10/6/24.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @State var position: MapCameraPosition
    let predator: ApexPredator
    var body: some View {
        GeometryReader {geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [ Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1), ], startPoint: .top, endPoint: .bottom)
                        }
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5, height: geo.size.height / 3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 30)
                }
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current LOcation")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                        }
                        .clipShape(.rect(cornerRadius: 15))

                    }
                    Text("Appears In")
                        .font(.title)
                        .padding(.top)
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                        
                    }
                    Text("Read More")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        DetailView(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[3].location, distance: 30000)), predator: Predators().apexPredators[3])
            .preferredColorScheme(.dark)
    }
}
