//
//  File.swift
//  
//
//  Created by Caleb Wilson on 17/03/2021.
//

import Foundation

public class TreeNode<T:Comparable> {
    
    public var value : T
    public var left : TreeNode?
    public var right : TreeNode?
    
    public init(value : T){
        self.value = value
    }
    
    public func addChild(newValue : T){
        switch (newValue < value){
        case true :
            if (left == nil ) { left = TreeNode(value: newValue)}
            else {
                left!.addChild(newValue: newValue)
            }
        case false :
            if (right == nil) {right = TreeNode(value: newValue)}
            else if(newValue != value){
                right!.addChild(newValue: newValue)
            }
        }
    }
    
    public func getPathToTreeNode(curr : [T],searchVal : T) -> [T]? {
        var workingCur = curr
        workingCur.append(self.value)
        
        if (searchVal == self.value){
            return workingCur
        } else if(searchVal < self.value){
            if (self.left == nil) { return nil}
            return left!.getPathToTreeNode(curr: workingCur, searchVal: searchVal)
        } else {
            if (self.right == nil) { return nil}
            return right!.getPathToTreeNode(curr: workingCur, searchVal: searchVal)
        }
    }
        
}

public func treeString<T>(_ node:T, reversed:Bool=false, isTop:Bool=true, using nodeInfo:(T)->(String,T?,T?)) -> String
{
   // node value string and sub nodes
   let (stringValue, leftNode, rightNode) = nodeInfo(node)

   let stringValueWidth  = stringValue.count

   // recurse to sub nodes to obtain line blocks on left and right
   let leftTextBlock     = leftNode  == nil ? []
                         : treeString(leftNode!,reversed:reversed,isTop:false,using:nodeInfo)
                           .components(separatedBy:"\n")

   let rightTextBlock    = rightNode == nil ? []
                         : treeString(rightNode!,reversed:reversed,isTop:false,using:nodeInfo)
                           .components(separatedBy:"\n")

   // count common and maximum number of sub node lines
   let commonLines       = min(leftTextBlock.count,rightTextBlock.count)
   let subLevelLines     = max(rightTextBlock.count,leftTextBlock.count)

   // extend lines on shallower side to get same number of lines on both sides
   let leftSubLines      = leftTextBlock
                         + Array(repeating:"", count: subLevelLines-leftTextBlock.count)
   let rightSubLines     = rightTextBlock
                         + Array(repeating:"", count: subLevelLines-rightTextBlock.count)

   // compute location of value or link bar for all left and right sub nodes
   //   * left node's value ends at line's width
   //   * right node's value starts after initial spaces
   let leftLineWidths    = leftSubLines.map{$0.count}
   let rightLineIndents  = rightSubLines.map{$0.prefix{$0==" "}.count  }

   // top line value locations, will be used to determine position of current node & link bars
   let firstLeftWidth    = leftLineWidths.first   ?? 0
   let firstRightIndent  = rightLineIndents.first ?? 0


   // width of sub node link under node value (i.e. with slashes if any)
   // aims to center link bars under the value if value is wide enough
   //
   // ValueLine:    v     vv    vvvvvv   vvvvv
   // LinkLine:    / \   /  \    /  \     / \
   //
   let linkSpacing       = min(stringValueWidth, 2 - stringValueWidth % 2)
   let leftLinkBar       = leftNode  == nil ? 0 : 1
   let rightLinkBar      = rightNode == nil ? 0 : 1
   let minLinkWidth      = leftLinkBar + linkSpacing + rightLinkBar
   let valueOffset       = (stringValueWidth - linkSpacing) / 2

   // find optimal position for right side top node
   //   * must allow room for link bars above and between left and right top nodes
   //   * must not overlap lower level nodes on any given line (allow gap of minSpacing)
   //   * can be offset to the left if lower subNodes of right node
   //     have no overlap with subNodes of left node
   let minSpacing        = 2
   let rightNodePosition = zip(leftLineWidths,rightLineIndents[0..<commonLines])
                           .reduce(firstLeftWidth + minLinkWidth)
                           { max($0, $1.0 + minSpacing + firstRightIndent - $1.1) }


   // extend basic link bars (slashes) with underlines to reach left and right
   // top nodes.
   //
   //        vvvvv
   //       __/ \__
   //      L       R
   //
   let linkExtraWidth    = max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
   let rightLinkExtra    = linkExtraWidth / 2
   let leftLinkExtra     = linkExtraWidth - rightLinkExtra

   // build value line taking into account left indent and link bar extension (on left side)
   let valueIndent       = max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
   let valueLine         = String(repeating:" ", count:max(0,valueIndent))
                         + stringValue
   let slash             = reversed ? "\\" : "/"
   let backSlash         = reversed ? "/"  : "\\"
   let uLine             = reversed ? "¯"  : "_"
   // build left side of link line
   let leftLink          = leftNode == nil ? ""
                         : String(repeating: " ", count:firstLeftWidth)
                         + String(repeating: uLine, count:leftLinkExtra)
                         + slash

   // build right side of link line (includes blank spaces under top node value)
   let rightLinkOffset   = linkSpacing + valueOffset * (1 - leftLinkBar)
   let rightLink         = rightNode == nil ? ""
                         : String(repeating:  " ", count:rightLinkOffset)
                         + backSlash
                         + String(repeating:  uLine, count:rightLinkExtra)

   // full link line (will be empty if there are no sub nodes)
   let linkLine          = leftLink + rightLink

   // will need to offset left side lines if right side sub nodes extend beyond left margin
   // can happen if left subtree is shorter (in height) than right side subtree
   let leftIndentWidth   = max(0,firstRightIndent - rightNodePosition)
   let leftIndent        = String(repeating:" ", count:leftIndentWidth)
   let indentedLeftLines = leftSubLines.map{ $0.isEmpty ? $0 : (leftIndent + $0) }

   // compute distance between left and right sublines based on their value position
   // can be negative if leading spaces need to be removed from right side
   let mergeOffsets      = indentedLeftLines
                           .map{$0.count}
                           .map{leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
                           .enumerated()
                           .map{ rightSubLines[$0].isEmpty ? 0  : $1 }


   // combine left and right lines using computed offsets
   //   * indented left sub lines
   //   * spaces between left and right lines
   //   * right sub line with extra leading blanks removed.
   let mergedSubLines    = zip(mergeOffsets.enumerated(),indentedLeftLines)
                           .map{ ( $0.0, $0.1, $1 + String(repeating:" ", count:max(0,$0.1)) ) }
                           .map{ $2 + String(rightSubLines[$0].dropFirst(max(0,-$1))) }

   // Assemble final result combining
   //  * node value string
   //  * link line (if any)
   //  * merged lines from left and right sub trees (if any)
   let treeLines = [leftIndent + valueLine]
                 + (linkLine.isEmpty ? [] : [leftIndent + linkLine])
                 + mergedSubLines

   return (reversed && isTop ? treeLines.reversed(): treeLines)
          .joined(separator:"\n")
}


public extension TreeNode {
    var asString : String {
        return treeString(self){("\($0.value)",$0.left,$0.right)}
    }
   
}

public extension TreeNode { //traversals
    func inOrderTraversal() -> [T]{
        var workingCurr = [T]()
        if (self.left != nil){
            workingCurr += self.left!.inOrderTraversal()
        }
        
        workingCurr.append(self.value)
        
        if (self.right != nil){
            workingCurr += self.right!.inOrderTraversal()
        }
        
        return workingCurr
    }
    func postOrderTraversal() -> [T]{
        var workingCurr = [T]()
        
        if (self.left != nil){
            workingCurr += self.left!.postOrderTraversal()
        }
        if (self.right != nil){
            workingCurr += self.right!.postOrderTraversal()
        }
        workingCurr.append(self.value)
        
        return workingCurr
    }
    func preOrderTraversal() -> [T]{
        var workingCurr = [T]()
        
        workingCurr.append(self.value)
        
        if (self.left != nil){
            workingCurr += self.left!.preOrderTraversal()
        }
        
        if (self.right != nil){
            workingCurr += self.right!.preOrderTraversal()
        }
        
        return workingCurr
    }
}


public extension TreeNode {
    func sumOfDepthOfNodesInTree(currDepth : Int = 0) -> Int {
        var workingTotal = currDepth
        
        if self.left != nil {
            workingTotal += self.left!.sumOfDepthOfNodesInTree(currDepth: currDepth + 1)
        }
        if self.right != nil {
            workingTotal += self.right!.sumOfDepthOfNodesInTree(currDepth: currDepth + 1)
        }
        
        return workingTotal
    }
    
    func invert() {
        let tmp = self.left
        self.left = self.right
        self.right = tmp
        
        if (self.right != nil){
            self.right!.invert()
        }
        if (self.left != nil){
            self.left!.invert()
        }
    }
    
    func findPathInTree(from origin : T,to dest : T) -> [T]? {
        guard var path1 = self.getPathToTreeNode(curr: [], searchVal: origin) else {
            return nil
        }
        path1 = path1.reversed() //path from origin to root node
        guard let path2 = self.getPathToTreeNode(curr: [], searchVal: dest) else {
            return nil //path from root node to destination
        }
        
        let constistentToBoth = path2.filter { path1.contains($0)} //numbers in both paths
        let remainingVal = constistentToBoth.last!
        
        func removeConsistent(from path : [T]) -> [T]{
            return path.filter {!constistentToBoth.contains($0)}
        }
        var editedPath1 = removeConsistent(from: path1)
        editedPath1.append(remainingVal)
        
        return (editedPath1 + removeConsistent(from: path2))
    }
    
    func distance(from origin : T,to dest : T) -> Int? {
        var myPaths = [[T]]()
        guard let path1 = self.getPathToTreeNode(curr: [], searchVal: origin) else {
            return nil
        }
        myPaths.append(path1)
        guard let path2 = self.getPathToTreeNode(curr: [], searchVal: dest) else {
            return nil
        }
        myPaths.append(path2)
        let flattenedPath = myPaths.flatMap {$0}
        
        return flattenedPath.filter {path1.contains($0) != path2.contains($0)}.count
    }
    
    func getAllDepthsOfNodesInAllSubtrees() -> Int {
        var impactOfDepth = [0 : 0]
        
        func getDepthOfNodeTotaled(root : TreeNode<T> = self,currDepth : Int = 0) -> Int {
            if impactOfDepth[currDepth] == nil {
                impactOfDepth[currDepth] = impactOfDepth[currDepth - 1]! + currDepth
            }
            
            var workingTotal = impactOfDepth[currDepth]!
            
            if root.left != nil {
                workingTotal += getDepthOfNodeTotaled(root: root.left!, currDepth: currDepth + 1)
            }
            if root.right != nil {
                workingTotal += getDepthOfNodeTotaled(root: root.right!, currDepth: currDepth + 1)
            }
            
            return workingTotal
        }
        
        return getDepthOfNodeTotaled()
    }
    
}



