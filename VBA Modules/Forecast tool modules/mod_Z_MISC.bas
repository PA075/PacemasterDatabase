Attribute VB_Name = "mod_Z_MISC"
Option Explicit

Function Name_Cells()
Attribute Name_Cells.VB_ProcData.VB_Invoke_Func = " \n14"
    Dim intLoop As Integer
    For intLoop = 2 To 11
        ActiveWorkbook.Names.Add Name:="Segment" & intLoop - 1, RefersToR1C1:="=Vars!R" & intLoop & "C27"
    Next intLoop
End Function

Function Unhide_All_Shapes()
    Dim shp As Shape
    
    For Each shp In ActiveSheet.Shapes
        shp.Visible = msoCTrue
    Next shp
End Function
