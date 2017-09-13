Attribute VB_Name = "Module1"
Option Explicit
Sub Create_New()
    frm_Generic.Show vbModeless
End Sub

Function unhide_shapes()
Dim shp As Shape

For Each shp In ActiveSheet.Shapes
    If shp.Visible = msoFalse Then
        shp.Visible = msoTrue
    End If
Next shp
End Function

Function zoom()
Dim ws As Worksheet
For Each ws In ThisWorkbook.Worksheets
    
Next ws
End Function

Function unhide_shapes_CheckBoxes()
    Dim intLoop As Integer
    
    For intLoop = 1 To 15
        ActiveSheet.Shapes("chk_" & intLoop).Visible = False
    Next intLoop
End Function
