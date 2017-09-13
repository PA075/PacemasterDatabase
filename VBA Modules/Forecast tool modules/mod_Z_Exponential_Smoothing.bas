Attribute VB_Name = "mod_Z_Exponential_Smoothing"
Option Explicit

Sub ForecastManager()
    Dim prow As Integer
    Application.Calculation = xlCalculationManual
    Application.ScreenUpdating = False
    Application.StatusBar = "Expert Prediction analysis is calculating... Please Wait."
    
    Dim Prod As String
    
    'Set up variables
    Prod = wks_Calculation.Range("C6").Value

    Call ExpSmoothing(wks_Calculation.Range("C6").Value)
       
'    Application.Calculate
    Application.ScreenUpdating = True
    Application.StatusBar = False
    Application.Calculation = xlCalculationAutomatic
    MsgBox "Forecasted Successfully"
    
End Sub
    
Sub ExpSmoothing(ByVal Prod As String)
    Dim i As Double
    Dim j As Double
    Dim k As Double
    Dim l As Double
    Dim Level As Double, Level1 As Double, Level2 As Double, Level3 As Double
    Dim Trend As Double, Trend1 As Double, Trend2 As Double, Trend3 As Double
    Dim Decay As Double, Decay1 As Double, Decay2 As Double, Decay3 As Double
    Dim Season As Double, Season1 As Double, Season2 As Double, Season3 As Double
    Dim imin As Double, imax As Double, jmin As Double, jmax As Double, kmin As Double, kmax As Double, lmin As Double, lmax As Double
    Dim Count As Integer
    Dim SearchStep1 As Double, SearchStep2 As Double, SearchStep3 As Double
    Dim OptMAPE As Double, OptMAPE1 As Double, OptMAPE2 As Double, OptMAPE3 As Double
    Dim MAPE As Double, Rsqr As Double
    Dim RowNum As Integer, RowNum1 As Integer
    
    'Set search step
    SearchStep1 = 0.1
    SearchStep2 = 0.05
    SearchStep3 = 0.01
    Count = 0
    Range("ProductName") = Prod
'    Application.Calculate
    RowNum = Range("ProdRowNum")
'    Application.Calculate
    
    '1st search of 3 local min
    i = 0
    j = 0
    k = 0.9
    l = 0
    Range("VariableRange").Cells(RowNum, 2) = i
    Range("VariableRange").Cells(RowNum, 3) = j
    Range("VariableRange").Cells(RowNum, 4) = k
    Range("VariableRange").Cells(RowNum, 5) = l
'    Application.Calculate
    OptMAPE1 = Range("VariableRange").Cells(RowNum, 7)
    
        For i = 0 To 1.001 Step SearchStep1
            For j = 0 To 1.001 Step SearchStep1
                For k = 0.9 To 1.001 Step SearchStep1
                    For l = 0 To 1.001 Step SearchStep1
                        Range("VariableRange").Cells(RowNum, 2) = i
                        Range("VariableRange").Cells(RowNum, 3) = j
                        Range("VariableRange").Cells(RowNum, 4) = k
                        Range("VariableRange").Cells(RowNum, 5) = l
'                        Application.Calculate
                        MAPE = Range("VariableRange").Cells(RowNum, 7)
                        If MAPE < OptMAPE1 Then
                            OptMAPE3 = OptMAPE2
                            Level3 = Level2
                            Trend3 = Trend2
                            Decay3 = Decay2
                            Season3 = Season2
                            OptMAPE2 = OptMAPE1
                            Level2 = Level1
                            Trend2 = Trend1
                            Decay2 = Decay1
                            Season2 = Season1
                            OptMAPE1 = MAPE
                            Level1 = i
                            Trend1 = j
                            Decay1 = k
                            Season1 = l
                        End If
                    Next l
                Next k
            Next j
        Next i
        '2nd search of 1st local min
        OptMAPE = OptMAPE1
        Rsqr = Range("VariableRange").Cells(RowNum, 8)
        imin = WorksheetFunction.Max(Level1 - SearchStep2, 0)
        imax = WorksheetFunction.Min(Level1 + SearchStep2 + 0.001, 1.001)
        jmin = WorksheetFunction.Max(Trend1 - SearchStep2, 0)
        jmax = WorksheetFunction.Min(Trend1 + SearchStep2 + 0.001, 1.001)
        kmin = WorksheetFunction.Max(Decay1 - SearchStep2, 0)
        kmax = WorksheetFunction.Min(Decay1 + SearchStep2 + 0.001, 1.001)
        lmin = WorksheetFunction.Max(Season1 - SearchStep2, 0)
        lmax = WorksheetFunction.Min(Season1 + SearchStep2 + 0.001, 1.001)
        For i = imin To imax Step SearchStep2
            For j = jmin To jmax Step SearchStep2
                For k = kmin To kmax Step SearchStep2
                    For l = lmin To lmax Step SearchStep2
                        Range("VariableRange").Cells(RowNum, 2) = i
                        Range("VariableRange").Cells(RowNum, 3) = j
                        Range("VariableRange").Cells(RowNum, 4) = k
                        Range("VariableRange").Cells(RowNum, 5) = l
                        Application.Calculate
                        MAPE = Range("VariableRange").Cells(RowNum, 7)
                        If MAPE <= OptMAPE Then
                            OptMAPE = MAPE
                            Rsqr = Range("VariableRange").Cells(RowNum, 8)
                            Level = i
                            Trend = j
                            Decay = k
                            Season = l
                        End If
                    Next l
                Next k
            Next j
        Next i
        '2nd search of 2nd local min
        OptMAPE = OptMAPE1
        imin = WorksheetFunction.Max(Level2 - SearchStep2, 0)
        imax = WorksheetFunction.Min(Level2 + SearchStep2 + 0.001, 1.001)
        jmin = WorksheetFunction.Max(Trend2 - SearchStep2, 0)
        jmax = WorksheetFunction.Min(Trend2 + SearchStep2 + 0.001, 1.001)
        kmin = WorksheetFunction.Max(Decay2 - SearchStep2, 0)
        kmax = WorksheetFunction.Min(Decay2 + SearchStep2 + 0.001, 1.001)
        lmin = WorksheetFunction.Max(Season2 - SearchStep2, 0)
        lmax = WorksheetFunction.Min(Season2 + SearchStep2 + 0.001, 1.001)
        For i = imin To imax Step SearchStep2
            For j = jmin To jmax Step SearchStep2
                For k = kmin To kmax Step SearchStep2
                    For l = lmin To lmax Step SearchStep2
                        Range("VariableRange").Cells(RowNum, 2) = i
                        Range("VariableRange").Cells(RowNum, 3) = j
                        Range("VariableRange").Cells(RowNum, 4) = k
                        Range("VariableRange").Cells(RowNum, 5) = l
                        Application.Calculate
                        MAPE = Range("VariableRange").Cells(RowNum, 7)
                        If MAPE <= OptMAPE Then
                            OptMAPE = MAPE
                            Rsqr = Range("VariableRange").Cells(RowNum, 8)
                            Level = i
                            Trend = j
                            Decay = k
                            Season = l
                        End If
                    Next l
                Next k
            Next j
        Next i
        '2nd search of 3rd local min
        OptMAPE = OptMAPE1
        imin = WorksheetFunction.Max(Level3 - SearchStep2, 0)
        imax = WorksheetFunction.Min(Level3 + SearchStep2 + 0.001, 1.001)
        jmin = WorksheetFunction.Max(Trend3 - SearchStep2, 0)
        jmax = WorksheetFunction.Min(Trend3 + SearchStep2 + 0.001, 1.001)
        kmin = WorksheetFunction.Max(Decay3 - SearchStep2, 0)
        kmax = WorksheetFunction.Min(Decay3 + SearchStep2 + 0.001, 1.001)
        lmin = WorksheetFunction.Max(Season3 - SearchStep2, 0)
        lmax = WorksheetFunction.Min(Season3 + SearchStep2 + 0.001, 1.001)
        For i = imin To imax Step SearchStep2
            For j = jmin To jmax Step SearchStep2
                For k = kmin To kmax Step SearchStep2
                    For l = lmin To lmax Step SearchStep2
                        Range("VariableRange").Cells(RowNum, 2) = i
                        Range("VariableRange").Cells(RowNum, 3) = j
                        Range("VariableRange").Cells(RowNum, 4) = k
                        Range("VariableRange").Cells(RowNum, 5) = l
                        Application.Calculate
                        MAPE = Range("VariableRange").Cells(RowNum, 7)
                        If MAPE <= OptMAPE Then
                            OptMAPE = MAPE
                            Rsqr = Range("VariableRange").Cells(RowNum, 8)
                            Level = i
                            Trend = j
                            Decay = k
                            Season = l
                        End If
                    Next l
                Next k
            Next j
        Next i
        '3rd search of 1 final min
        imin = WorksheetFunction.Max(Level - 0.04, 0)
        imax = WorksheetFunction.Min(Level + 0.04 + 0.001, 1.001)
        jmin = WorksheetFunction.Max(Trend - 0.04, 0)
        jmax = WorksheetFunction.Min(Trend + 0.04 + 0.001, 1.001)
        kmin = WorksheetFunction.Max(Decay - 0.04, 0)
        kmax = WorksheetFunction.Min(Decay + 0.04 + 0.001, 1.001)
        lmin = WorksheetFunction.Max(Season - 0.04, 0)
        lmax = WorksheetFunction.Min(Season + 0.04 + 0.001, 1.001)
        For i = imin To imax Step SearchStep3
            For j = jmin To jmax Step SearchStep3
                For k = kmin To kmax Step SearchStep3
                    For l = lmin To lmax Step SearchStep3
                        Range("VariableRange").Cells(RowNum, 2) = i
                        Range("VariableRange").Cells(RowNum, 3) = j
                        Range("VariableRange").Cells(RowNum, 4) = k
                        Range("VariableRange").Cells(RowNum, 5) = l
                        Application.Calculate
                        MAPE = Range("VariableRange").Cells(RowNum, 7)
                        If MAPE <= OptMAPE Then
                            OptMAPE = MAPE
                            Rsqr = Range("VariableRange").Cells(RowNum, 8)
                            Level = i
                            Trend = j
                            Decay = k
                            Season = l
                        End If
                    Next l
                Next k
            Next j
        Next i
        
        Range("VariableRange").Cells(RowNum, 2) = Level
        Range("VariableRange").Cells(RowNum, 3) = Trend
        Range("VariableRange").Cells(RowNum, 4) = Decay
        Range("VariableRange").Cells(RowNum, 5) = Season
        
        Range("ResetVariableRange").Cells(RowNum, 2) = Level
        Range("ResetVariableRange").Cells(RowNum, 3) = Trend
        Range("ResetVariableRange").Cells(RowNum, 4) = Decay
        Range("ResetVariableRange").Cells(RowNum, 5) = Season
        Range("ResetVariableRange").Cells(RowNum, 7) = OptMAPE
        Range("ResetVariableRange").Cells(RowNum, 8) = Rsqr

End Sub

Sub ResetExpertValues()
    Dim i As Integer
    i = 1
    Range("VariableRange").Cells(i, 2) = Range("ResetVariableRange").Cells(i, 2)
    Range("VariableRange").Cells(i, 3) = Range("ResetVariableRange").Cells(i, 3)
    Range("VariableRange").Cells(i, 4) = Range("ResetVariableRange").Cells(i, 4)
    Range("VariableRange").Cells(i, 5) = Range("ResetVariableRange").Cells(i, 5)

    Application.Calculate
End Sub

Sub ClearAll()
    Range(Range("market_TRxRange").Cells(1, 2), Range("market_TRxRange").Cells(20, 241)).ClearContents
    Range(Range("VariableRange").Cells(1, 2), Range("VariableRange").Cells(20, 5)).ClearContents
    Range(Range("ResetVariableRange").Cells(1, 2), Range("ResetVariableRange").Cells(20, 8)).ClearContents
    Application.Calculate
End Sub

