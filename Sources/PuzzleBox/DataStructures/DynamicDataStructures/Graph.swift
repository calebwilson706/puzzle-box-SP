//
//  File.swift
//  
//
//  Created by Caleb Wilson on 16/03/2021.
//

import Foundation


struct GraphVertex<T : Hashable> : Hashable {
    var data : T
}

enum GraphEdgeType {
    case directed, undirected
}


struct GraphEdge<T : Hashable> : Hashable {
    var source : GraphVertex<T>
    var destination : GraphVertex<T>
    var weight : Double?
}

protocol Graphable {
  associatedtype Element: Hashable
  
  
  func createVertex(data: Element) -> GraphVertex<Element>
  func add(_ type: GraphEdgeType, from source: GraphVertex<Element>, to destination: GraphVertex<Element>, weight: Double?)
  func weight(from source: GraphVertex<Element>, to destination: GraphVertex<Element>) -> Double?
  func edges(from source: GraphVertex<Element>) -> [GraphEdge<Element>]?
    
}

class AdjacencyList<T : Hashable> {
    var adjacencyDict : [GraphVertex<T> : [GraphEdge<T>]] = [:]
    
    func addDirectedEdge(from source: GraphVertex<Element>, to destination: GraphVertex<Element>, weight: Double?) {
        let newEdge = GraphEdge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(newEdge)
    }
    
    func addUndirectedEdge(vertices : (GraphVertex<Element>, GraphVertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}



extension AdjacencyList : Graphable {
    typealias Element = T
    
    func createVertex(data: T) -> GraphVertex<T> {
        let vertex = GraphVertex<T>(data: data)
        
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        
        return vertex
    }
    
    func add(_ type: GraphEdgeType, from source: GraphVertex<T>, to destination: GraphVertex<T>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
    
    func weight(from source: GraphVertex<T>, to destination: GraphVertex<T>) -> Double? {
        return adjacencyDict[source]?.first { $0.destination == destination }?.weight
    }
    
    func edges(from source: GraphVertex<T>) -> [GraphEdge<T>]? {
        return adjacencyDict[source]
    }
}
