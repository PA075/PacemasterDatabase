Attribute VB_Name = "mod_Charts"
Option Explicit

Function Analyst_ChartView()
    Application.ScreenUpdating = False
    wks_ForecastFlow.Shapes("grp_Chart").Visible = True
    wks_ForecastFlow.ChartObjects("Chart 7").Chart.SetSourceData Source:=wks_ForecastFlow.Range("$F$1035:" & wks_Vars.Range("J9").Value & "$1039")
    wks_ForecastFlow.Shapes("grp_Chart").Top = wks_ForecastFlow.Range("F1035").Top
    wks_ForecastFlow.Range("F1035").Activate
    Application.ScreenUpdating = True
End Function

Function Chart_For_Sections()
    Dim intLoop As Integer
    Dim intRow As Integer
    Dim intRow1 As Integer
    intRow = wks_Vars.Range("AS1").Value
    intRow1 = intRow
    Application.ScreenUpdating = False
    wks_ForecastFlow.Shapes("drp_Segments").Visible = msoTrue
    wks_ForecastFlow.Shapes("grp_Chart").Visible = True
    For intLoop = 1 To 15
        If wks_Vars.Range("AR1").Value = intLoop Then
            wks_ForecastFlow.ChartObjects("Chart 7").Chart.SetSourceData Source:=wks_ForecastFlow.Range("F" & intRow & ":" & wks_Vars.Range("AV1").Value & intRow + wks_Vars.Range("AT1").Value)
            wks_ForecastFlow.ChartObjects("Chart 7").Chart.FullSeriesCollection(1).XValues = "=Generic_Forecast!$G$6:$" & wks_Vars.Range("AV1").Value & "$6"
            wks_ForecastFlow.Shapes("grp_Chart").Top = wks_ForecastFlow.Range("F" & intRow1).Top
            wks_ForecastFlow.Shapes("drp_Segments").Top = wks_ForecastFlow.Range("F" & intRow1).Top
            wks_ForecastFlow.Range("F" & intRow).Activate
        End If
        intRow = intRow + wks_Vars.Range("AU1").Value
    Next intLoop
    Application.ScreenUpdating = True
End Function

Function Product_Units_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 1186
    wks_Vars.Range("AT1").Value = 4
    wks_Vars.Range("AU1").Value = 6
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J9").Value
    Call Chart_For_Sections
End Function
Function Trended_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 1278
    wks_Vars.Range("AT1").Value = 4
    wks_Vars.Range("AU1").Value = 6
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Compliance_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 1618
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Dosing_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 1787
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function DoT_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 1956
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Price_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 2294
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function MarketAccess_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 2463
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function GTN_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 2632
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function PlaceHolder_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 2801
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Patients_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 2968
    wks_Vars.Range("AT1").Value = 4
    wks_Vars.Range("AU1").Value = 6
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function ProductShares_Data_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 3077
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 34
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function ProductShares_Patients_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 3088
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 34
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Events_Patients_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 3601
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 34
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Output_Patients_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 4092
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Output_Units_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 4259
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Output_GrossRevenue_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 4426
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Output_NetRevenue_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 4593
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Probability_GrossRevenue_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 4929
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function Probability_NetRevenue_ChartView()
    wks_Vars.Range("AR1").Value = 1
    wks_Vars.Range("AS1").Value = 5096
    wks_Vars.Range("AT1").Value = 9
    wks_Vars.Range("AU1").Value = 11
    wks_Vars.Range("AV1").Value = wks_Vars.Range("J8").Value
    Call Chart_For_Sections
End Function
Function ChartHide1()
    Application.ScreenUpdating = False
    wks_ForecastFlow.Shapes("grp_Chart").Visible = False
    wks_ForecastFlow.Shapes("drp_Segments").Visible = msoFalse
    Application.ScreenUpdating = True
End Function
