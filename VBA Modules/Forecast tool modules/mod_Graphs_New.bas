Attribute VB_Name = "mod_Graphs_New"
Option Explicit

Function Hide_Shapes_Graphs()
    With wks_Graphs
        .Shapes("txt_Product").Visible = msoFalse
        .Shapes("TxtSKU").Visible = msoFalse
        .Shapes("txt_Type").Visible = msoFalse
        .Shapes("cb_product").Visible = msoFalse
        ''.Shapes("Drp_SKU2").Visible = msoFalse
        .Shapes("drp_Type").Visible = msoFalse
        .Shapes("shp_1").Visible = msoFalse
        .Shapes("shp_2").Visible = msoFalse
        .Shapes("shp_3").Visible = msoFalse
    End With
End Function

Function Graph_Product_Change()
    'SET VALUE IN VARS!AQ2
    Dim intSKUCount As Integer
Call Application_Events_Handler(False)
    intSKUCount = wks_Vars.Range("BA" & wks_Vars.Range("AQ2").Value + 2).Value
    
    wks_Vars.Range("BD1:BD15").Clear
    wks_Vars.Range("J3:J17").Clear
    
    wks_SKU_info.Range(wks_SKU_info.Cells(2, wks_Vars.Range("AQ2").Value + 1), wks_SKU_info.Cells(intSKUCount + 1, wks_Vars.Range("AQ2").Value + 1)).Copy
    wks_Vars.Range("BD1").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    If wks_Vars.Range("BD1").Value = "" Then
        wks_Vars.Range("BD1").Value = "All"
    End If
    wks_Vars.Range("BD" & intSKUCount + 1).Value = "Total"
    
'    With wks_Graphs.Shapes("Drp_SKU2").ControlFormat
'        .ListFillRange = "Vars!BD1:BD" & intSKUCount + 1
'        .LinkedCell = "Vars!$N$24"
'        .DropDownLines = 15
'    End With
'
    wks_Vars.Range("BD1:BD" & intSKUCount + 1).Copy
    wks_Vars.Range("J3").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    wks_Forecast.Activate
    Graph_Product_Change = intSKUCount + 1
Call Application_Events_Handler(True)
End Function

Function Activate_GraphSheet()
Call Application_Events_Handler(False)
'wks_Forecast.Shapes("shp_PleaseWait").Visible = msoCTrue
    Call Back_Data
    Call SKU_SelectGraph
    Call Graph_Type
    wks_Vars.Calculate
    wks_Graphs.Calculate
    wks_Graphs.Activate
    wks_Graphs.Range("G10:NB10").EntireColumn.Hidden = True
    wks_Graphs.Range("G10:" & wks_Vars.Range("K4").Value & "10").EntireColumn.Hidden = False
    
    Call Hide_Shapes_Graphs
'wks_Forecast.Shapes("shp_PleaseWait").Visible = msoFalse
Call Application_Events_Handler(True)
End Function

Function SKU_SelectGraph()
    Dim intRng As Integer
    intRng = 9 + wks_Vars.Range("B20").Value

    With wks_Graphs
        If wks_Vars.Range("N24").Value = 1 + wks_M_List.Range("I" & intRng).Value And wks_M_List.Range("H" & intRng).Value = True Then
            Call Graph_DataTotal
        Else
            wks_Graphs.Range("G37:" & wks_Vars.Range("K4").Value & 41).Formula = "=SUMIFS(ForecastData!E:E,ForecastData!$A:$A,Vars!$AQ$3,ForecastData!$B:$B,Vars!$M$26,ForecastData!$C:$C,Graphs!$F$36,ForecastData!$D:$D,$F37)"
            .Range("G44:" & wks_Vars.Range("K4").Value & 48).Formula = "=SUMIFS(ForecastData!E:E,ForecastData!$A:$A,Vars!$AQ$3,ForecastData!$B:$B,Vars!$M$26,ForecastData!$C:$C,Graphs!$F$43,ForecastData!$D:$D,$F44)"
            .Range("G51:" & wks_Vars.Range("K4").Value & 55).Formula = "=SUMIFS(ForecastData!E:E,ForecastData!$A:$A,Vars!$AQ$3,ForecastData!$B:$B,Vars!$M$26,ForecastData!$C:$C,Graphs!$F$50,ForecastData!$D:$D,$F51)"
            .Range("G42:" & wks_Vars.Range("K4").Value & 42).Formula = "=IFERROR(G40/G37, """")"
            .Range("G49:" & wks_Vars.Range("K4").Value & 49).Formula = "=IFERROR(G47/G44, """")"
            .Range("G56:" & wks_Vars.Range("K4").Value & 56).Formula = "=IFERROR(G54/G51, """")"
            .Range("G37:" & wks_Vars.Range("K4").Value & 58).Value = .Range("G37:NB58").Value
        End If
        Call Graph_Type
        .Activate
    End With
End Function

Function Graph_DataTotal()
    With wks_Graphs.Range("G37:" & wks_Vars.Range("K4").Value & 40)
        .Formula = "=SUMIFS(ForecastData!E:E,ForecastData!$A:$A,Vars!$P$2,ForecastData!$C:$C,$F$36,ForecastData!$D:$D,$F37)"
        .Value = .Value
    End With
    With wks_Graphs.Range("G41:" & wks_Vars.Range("K4").Value & 41)
        .Formula = "=IFERROR(G40/G38,0)"
        .Value = .Value
    End With
    
    With wks_Graphs.Range("G44:" & wks_Vars.Range("K4").Value & 47)
        .Formula = "=SUMIFS(ForecastData!E:E,ForecastData!$A:$A,Vars!$P$2,ForecastData!$C:$C,$F$43,ForecastData!$D:$D,$F44)"
        .Value = .Value
    End With
    With wks_Graphs.Range("G48:" & wks_Vars.Range("K4").Value & 48)
        .Formula = "=IFERROR(G47/G45,0)"
        .Value = .Value
    End With

    With wks_Graphs.Range("G51:" & wks_Vars.Range("K4").Value & 54)
        .Formula = "=SUMIFS(ForecastData!E:E,ForecastData!$A:$A,Vars!$P$2,ForecastData!$C:$C,$F$50,ForecastData!$D:$D,$F51)"
        .Value = .Value
    End With
    With wks_Graphs.Range("G55:" & wks_Vars.Range("K4").Value & 55)
        .Formula = "=IFERROR(G54/G52,0)"
        .Value = .Value
    End With
End Function

Function Graph_Type()   'DD_GraphType
Dim intNum As Integer, intLoop As Integer
intNum = wks_Vars.Range("K6").Value
    With wks_Graphs
        .Activate
        .Range("A19:A25").EntireRow.Hidden = False
        If wks_Vars.Range("N21").Value = 1 Then
            .Range("G15:NB15").Formula = "=G$37"
            .Range("G16:NB16").Formula = "=G$44"
            .Range("G17:NB17").Formula = "=G$51"
            .ChartObjects("Graphs_Chart").Visible = True
            ActiveSheet.ChartObjects("Graphs_Chart").Activate
            ActiveChart.SetSourceData Source:=Range("Graphs!$F$15:$NB$17")
            ActiveChart.SeriesCollection(1).XValues = "=Graphs!$G$10:$NB$10"
        ElseIf wks_Vars.Range("N21").Value = 2 Then
            .Range("G15:NB15").Formula = "=G$39"
            .Range("G16:NB16").Formula = "=G$46"
            .Range("G17:NB17").Formula = "=G$53"
            .ChartObjects("Graphs_Chart").Visible = True
            ActiveSheet.ChartObjects("Graphs_Chart").Activate
            ActiveChart.SetSourceData Source:=Range("Graphs!$F$15:$NB$17")
            ActiveChart.SeriesCollection(1).XValues = "=Graphs!$G$10:$NB$10"
        ElseIf wks_Vars.Range("N21").Value = 3 Then
            .Range("G15:NB15").Formula = "=G40"
            .Range("G16:NB16").Formula = "=G47"
            .Range("G17:NB17").Formula = "=G54"
            .ChartObjects("Graphs_Chart").Visible = True
            ActiveSheet.ChartObjects("Graphs_Chart").Activate
            ActiveChart.SetSourceData Source:=Range("Graphs!$F$15:$NB$17")
            ActiveChart.SeriesCollection(1).XValues = "=Graphs!$G$10:$NB$10"
        ElseIf wks_Vars.Range("N21").Value = 4 Then
            .Range("G15:NB15").Formula = "=G38"
            .Range("G16:NB16").Formula = "=G45"
            .Range("G17:NB17").Formula = "=G52"
            .ChartObjects("Graphs_Chart").Visible = True
            ActiveSheet.ChartObjects("Graphs_Chart").Activate
            ActiveChart.SetSourceData Source:=Range("Graphs!$F$15:$NB$17")
            ActiveChart.SeriesCollection(1).XValues = "=Graphs!$G$10:$NB$10"
        End If
        
'        For intLoop = 1 To wks_Vars.Range("K8").Value
'            ActiveChart.SeriesCollection(1).Points(intLoop).Format.Line.ForeColor.RGB = RGB(238, 141, 42)
'            ActiveChart.SeriesCollection(2).Points(intLoop).Format.Line.ForeColor.RGB = RGB(238, 141, 42)
'            ActiveChart.SeriesCollection(3).Points(intLoop).Format.Line.ForeColor.RGB = RGB(238, 141, 42)
'        Next intLoop
'        For intLoop = 1 To intNum
'            ActiveChart.SeriesCollection(1).Points(intLoop).Format.Line.ForeColor.RGB = RGB(201, 201, 201)
'            ActiveChart.SeriesCollection(2).Points(intLoop).Format.Line.ForeColor.RGB = RGB(201, 201, 201)
'            ActiveChart.SeriesCollection(3).Points(intLoop).Format.Line.ForeColor.RGB = RGB(201, 201, 201)
'        Next intLoop
        
       
        .Range("G15:NB17").Value = .Range("G15:NB17").Value
        .Range("G15:NB17").Replace 0, "", xlWhole
        .Range("A35:A56").EntireRow.Hidden = True
        .Range("F14").Activate
        
    End With
End Function

