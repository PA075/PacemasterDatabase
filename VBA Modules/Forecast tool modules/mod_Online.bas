Attribute VB_Name = "mod_Online"
Option Explicit

Function InitializeDisplay()
    Workbooks(1).Activate
    Workbooks(1).Worksheets("Generic_Forecast").Select
    ActiveWindow.DisplayHeadings = False
    ActiveWindow.DisplayWorkbookTabs = False
    ActiveWindow.DisplayHorizontalScrollBar = True
    ActiveWindow.DisplayVerticalScrollBar = True
End Function
 
Function ScrollToSection()
    Dim finalNumber As Integer
    finalNumber = Workbooks(1).Worksheets("SPDocLib").Cells(1, 4).Value
    Workbooks(1).Activate
    Workbooks(1).Worksheets("Generic_Forecast").Select
    ActiveWindow.ScrollRow = finalNumber
End Function

Function Scenario_DropDown_Message()
    Dim intRow As Integer
    Dim strRange As String
    wks_Vars.Calculate
    intRow = wks_Vars.Range("CD6").Value
    
    If intRow = 0 Then
        Scenario_DropDown_Message = 0
        Exit Function
    End If
    If wks_Vars.Range("BK1").Value = 1 Then
        Scenario_DropDown_Message = 0
        Exit Function
    End If
    strRange = "E" & intRow & ":RP" & intRow + 1199
    If Application.WorksheetFunction.CountA(wks_Output.Range(strRange)) = 0 Then
        Scenario_DropDown_Message = 1
    Else
        Scenario_DropDown_Message = 0
    End If
End Function

Function Hide_Unhide_123()
    Dim blnFlag As Boolean
    blnFlag = False
    With wks_ForecastFlow
        .Shapes("lbl_Country").Visible = blnFlag
        .Shapes("lbl_Scenario").Visible = blnFlag
        .Shapes("drp_Country").Visible = blnFlag
        .Shapes("drp_Scenario").Visible = blnFlag
        .Shapes("shp_Consolidator").Visible = blnFlag
        .Shapes("shp_Graphs").Visible = blnFlag
        .Shapes("shp_Assumptions").Visible = blnFlag
    End With
    wks_Home.Shapes("grp_Offline").Visible = blnFlag
End Function
