Attribute VB_Name = "mod_Trending"
Option Explicit

Function Treding_Options_Click()
    wks_Vars.Range("AB1").Value = 1
    Call Segment_Change_Trending
End Function

Function Segment_Change_Trending()
    Dim intLoop As Integer
    Dim intRow As Integer
    Dim intHist As Integer
Call Application_Event_Handler(False)
    With wks_Trending
        .Range("M6:RR61").Clear
        
        .Range("L6:L61").Copy
        .Range(.Cells(6, 13), .Cells(61, wks_Vars.Range("J6").Value)).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        
        .Range("A8:A61").EntireRow.Hidden = True
        For intLoop = 1 To 5
            .Shapes("grp_" & intLoop).Visible = msoFalse
        Next intLoop
        
        intRow = 12
        intHist = wks_Vars.Range("EB2") + 180 + (6 * (wks_Vars.Range("AB1").Value - 1))
        For intLoop = 1 To wks_Vars.Range("M1").Value
            .Range("A" & intRow - 8 & ":A" & intRow + 6).EntireRow.Hidden = False
            .Shapes("grp_" & intLoop).Visible = msoCTrue
            
            .Range("G" & intRow).Formula = "=Apply_Curve($G$6:$" & wks_Vars.Range("J9").Value & "$6,Generic_Forecast!$G$" & intHist & ":$" & wks_Vars.Range("J9").Value & "$" & intHist & ",G$5,$F11)"
            .Range("G" & intRow).Copy
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 5).PasteSpecial xlPasteFormulas
            Application.CutCopyMode = False
            
            intRow = intRow + 11
            intHist = intHist + 1
        Next intLoop
        
        .Calculate
        
        With .Range("G11:" & wks_Vars.Range("J8").Value & "56")
            .Value = .Value
        End With
        
''        .Range("A10,A20,A30,A40,A50").Value = 2
        
        Call Product1_Chart
        
        .Activate
        .Range("G7").Select
    End With
Call Application_Event_Handler(True)
End Function

Function Product1_Chart()
    With wks_Trending.ChartObjects("cht_Trend").Chart
        .SetSourceData wks_Trending.Range("F11:" & wks_Vars.Range("J8").Value & "17")
        .SeriesCollection(1).XValues = "=Trending!$G$6:$" & wks_Vars.Range("J8").Value & "$6"
    End With
    wks_Trending.Shapes("grp_Chart").Visible = msoCTrue
    wks_Trending.Shapes("grp_Chart").Top = wks_Trending.Range("G9").Top + 5
    
    wks_Trending.Shapes("shp_Chart").TextFrame.Characters.Text = wks_Trending.Range("F8").Value
End Function

Function Product2_Chart()
    With wks_Trending.ChartObjects("cht_Trend").Chart
        .SetSourceData wks_Trending.Range("F22:" & wks_Vars.Range("J8").Value & "28")
        .SeriesCollection(1).XValues = "=Trending!$G$6:$" & wks_Vars.Range("J8").Value & "$6"
    End With
    wks_Trending.Shapes("grp_Chart").Visible = msoCTrue
    wks_Trending.Shapes("grp_Chart").Top = wks_Trending.Range("G20").Top + 5
    
    wks_Trending.Shapes("shp_Chart").TextFrame.Characters.Text = wks_Trending.Range("F18").Value
End Function

Function Product3_Chart()
    With wks_Trending.ChartObjects("cht_Trend").Chart
        .SetSourceData wks_Trending.Range("F33:" & wks_Vars.Range("J8").Value & "39")
        .SeriesCollection(1).XValues = "=Trending!$G$6:$" & wks_Vars.Range("J8").Value & "$6"
    End With
    wks_Trending.Shapes("grp_Chart").Visible = msoCTrue
    wks_Trending.Shapes("grp_Chart").Top = wks_Trending.Range("G31").Top + 5
    
    wks_Trending.Shapes("shp_Chart").TextFrame.Characters.Text = wks_Trending.Range("F28").Value
End Function

Function Product4_Chart()
    With wks_Trending.ChartObjects("cht_Trend").Chart
        .SetSourceData wks_Trending.Range("F44:" & wks_Vars.Range("J8").Value & "50")
        .SeriesCollection(1).XValues = "=Trending!$G$6:$" & wks_Vars.Range("J8").Value & "$6"
    End With
    wks_Trending.Shapes("grp_Chart").Visible = msoCTrue
    wks_Trending.Shapes("grp_Chart").Top = wks_Trending.Range("G42").Top + 5
    
    wks_Trending.Shapes("shp_Chart").TextFrame.Characters.Text = wks_Trending.Range("F38").Value
End Function

Function Product5_Chart()
    With wks_Trending.ChartObjects("cht_Trend").Chart
        .SetSourceData wks_Trending.Range("F55:" & wks_Vars.Range("J8").Value & "61")
        .SeriesCollection(1).XValues = "=Trending!$G$6:$" & wks_Vars.Range("J8").Value & "$6"
    End With
    wks_Trending.Shapes("grp_Chart").Visible = msoCTrue
    wks_Trending.Shapes("grp_Chart").Top = wks_Trending.Range("G53").Top + 5
    
    wks_Trending.Shapes("shp_Chart").TextFrame.Characters.Text = wks_Trending.Range("F48").Value
End Function

Function Hide_Chart_Trending()
    wks_Trending.Shapes("grp_Chart").Visible = msoFalse
End Function

Function Save_Continue_Trending()
    Dim intLoop As Integer
    Dim intRow As Integer
    Dim intHist As Integer
Call Application_Event_Handler(False)
    intRow = 10
    intHist = wks_Vars.Range("EB3").Value + (6 * (wks_Vars.Range("AB1").Value - 1))
    For intLoop = 1 To wks_Vars.Range("M1").Value
        wks_ForecastFlow.Range("G" & intHist & ":" & wks_Vars.Range("J8").Value & intHist).Value = _
            wks_Trending.Range("G" & intRow + wks_Trending.Range("A" & intRow).Value & ":" & wks_Vars.Range("J8").Value & intRow + wks_Trending.Range("A" & intRow).Value).Value
        intRow = intRow + 11
        intHist = intHist + 1
    Next intLoop
    
''    wks_ForecastFlow.Activate
Call Application_Event_Handler(True)
End Function

Function ForecastFlow_Activate()
    wks_ForecastFlow.Activate
End Function
