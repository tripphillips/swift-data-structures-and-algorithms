//
//  AdjacencyMatrix.swift
//  Graph
//
//  Created by Trip Phillips on 6/1/22.
//

import Foundation

public class AdjacencyMatrix<T>: Graph {
    
    private var allVertices: [Vertex<T>] = []
    private var weights: [[Double?]] = []
    
    public init() {}
    
    public var vertices: [Vertex<T>] {
        allVertices
    }
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: allVertices.count, data: data)
        allVertices.append(vertex)
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        let row = [Double?](repeating: nil, count: allVertices.count)
        weights.append(row)
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }

    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(source: source,
                                  destination: allVertices[column],
                                  weight: weight))
            }
        }
        return edges
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        weights[source.index][destination.index]
    }
}

extension AdjacencyMatrix: CustomStringConvertible {

  public var description: String {
    // 1
    let verticesDescription = allVertices.map { "\($0)" }
                                      .joined(separator: "\n")
    // 2
    var grid: [String] = []
    for i in 0..<weights.count {
      var row = ""
      for j in 0..<weights.count {
        if let value = weights[i][j] {
          row += "\(value)\t"
        } else {
          row += "ø\t\t"
        }
      }
      grid.append(row)
    }
    let edgesDescription = grid.joined(separator: "\n")
    // 3
    return "\(verticesDescription)\n\n\(edgesDescription)"
  }
}
