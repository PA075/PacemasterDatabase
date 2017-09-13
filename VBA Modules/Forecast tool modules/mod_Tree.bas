Attribute VB_Name = "mod_Tree"
Option Explicit
Dim intFlag As Integer

Function Tree()
    Dim intLoop As Integer, intSegments As Integer
    Dim intMerge As Integer
    Dim intRow As Integer
    Dim intColumn As Integer
    
    intRow = 2
    intColumn = 4
    intFlag = 0
    For intLoop = 1 To wks_Vars.Range("AM1").Value
        intMerge = wks_Vars.Range("AO" & intLoop + 1).Value
        wks_Tree.Range(wks_Tree.Cells(intRow, intColumn), wks_Tree.Cells(intRow, intColumn + intMerge - 1)).Merge
        wks_Tree.Cells(intRow, intColumn).Value = wks_Vars.Range("AD" & intLoop + 1).Value
        intRow = intRow + 1
        
        If wks_Vars.Range("AE" & intLoop + 1).Value Then
            For intSegments = 1 To wks_Vars.Range("AN" & intLoop + 1).Value
                wks_Tree.Range(wks_Tree.Cells(intRow, intColumn), wks_Tree.Cells(intRow, intColumn + intMerge / wks_Vars.Range("AN" & intLoop + 1).Value - 1)).Merge
                wks_Tree.Cells(intRow, intColumn).Value = "â"
                wks_Tree.Cells(intRow, intColumn).Font.Name = "Wingdings"
                intRow = intRow + 1
                
                wks_Tree.Range(wks_Tree.Cells(intRow, intColumn), wks_Tree.Cells(intRow, intColumn + intMerge / wks_Vars.Range("AN" & intLoop + 1).Value - 1)).Merge
                wks_Tree.Cells(intRow, intColumn).Value = wks_Vars.Cells(intLoop + 1, intSegments + 32).Value
                intRow = intRow + 1
            Next intSegments
        End If
    Next intLoop
End Function

