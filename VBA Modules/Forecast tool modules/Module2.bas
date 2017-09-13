Attribute VB_Name = "Module2"
Sub Get_Commandbars_Names()
    Dim Cbar As CommandBar
    Dim NewWS As Worksheet
    Dim RNum As Long

    RNum = 1
'    Set NewWS = Worksheets.Add
'    On Error Resume Next
'    ActiveSheet.Name = "CommandBarNames"
'    On Error GoTo 0

    For Each Cbar In Application.CommandBars
'        NewWS.Cells(RNum, "A").Value = Cbar.Name
        Cbar.Enabled = True
'        NewWS.Cells(RNum, "B").Value = Cbar.NameLocal
        RNum = RNum + 1
    Next Cbar

'    NewWS.Columns.AutoFit
End Sub

