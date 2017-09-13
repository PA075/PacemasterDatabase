Attribute VB_Name = "mod_Z_Trending"
Option Explicit
 
Dim intLoop As Integer
Dim Data_Count As Integer
 
Dim Min_Data As Variant
Dim Max_Data As Variant
Dim U As Variant
 
Dim arr_Y() As Variant
Dim arr_1() As Variant
Dim arr_X() As Variant
Dim arr_X_Power2() As Variant
Dim arr_X_Power3() As Variant
Dim arr_LN_X() As Variant
Dim arr_1_div_X() As Variant
Dim arr_LN_Y() As Variant
Dim arr_SST() As Variant
Dim arr_SST_Power() As Variant
Dim arr_Y_minus_Mean_of_LN_Y() As Variant
Dim arr_LN_Y_X() As Variant
 
Dim Mean_Y As Variant
Dim XRng_Lin() As Variant
Dim arr_B() As Variant
Dim SSE As Variant
Dim rSquare As Variant
Dim SSR As Variant
Dim F As Variant
 
Dim arr_ERR() As Variant
 
Dim arr_Calcs() As Variant
Dim arr_Difference() As Variant
Dim arr_Result() As Variant
 
Dim Seas_Months() As Variant
Dim Seas_MA() As Variant
Dim Seas_CMA() As Variant
Dim Seas_Err() As Variant
Dim Seas_Unadjusted() As Variant
Dim Seas_Adj_Factor As Variant
Dim Seas_Adjustment() As Variant
 
Function Apply_Curve(rngPeriod As Range, rngData As Range, intNumber As Integer, strType As String)
On Error GoTo ErrFound
    'DATA POINTS COUNT
    Data_Count = rngPeriod.Columns.Count
   
    ReDim arr_Y(0 To Data_Count - 1)
    ReDim arr_1(0 To Data_Count - 1)
    ReDim arr_X(0 To Data_Count - 1)
    ReDim arr_X_Power2(0 To Data_Count - 1)
    ReDim arr_X_Power3(0 To Data_Count - 1)
    ReDim arr_LN_X(0 To Data_Count - 1)
    ReDim arr_1_div_X(0 To Data_Count - 1)
    ReDim arr_LN_Y(0 To Data_Count - 1)
    ReDim arr_SST(0 To Data_Count - 1)
    ReDim arr_SST_Power(0 To Data_Count - 1)
    ReDim arr_Y_minus_Mean_of_LN_Y(0 To Data_Count - 1)
    ReDim arr_LN_Y_X(0 To Data_Count - 1)
   
    Min_Data = Application.WorksheetFunction.Min(rngData)
    If Min_Data = 0 Then Min_Data = 0.000001
    Max_Data = Application.WorksheetFunction.Max(rngData)
    U = Min_Data + Max_Data
   
    Mean_Y = Application.WorksheetFunction.Average(rngData)
   
    For intLoop = 1 To Data_Count
        If rngData.Cells(1, intLoop) = 0 Then
            arr_Y(intLoop - 1) = 0.000001
        Else
            arr_Y(intLoop - 1) = rngData.Cells(1, intLoop)
        End If
        arr_1(intLoop - 1) = 1
        arr_X(intLoop - 1) = intLoop
        arr_X_Power2(intLoop - 1) = intLoop ^ 2
        arr_X_Power3(intLoop - 1) = intLoop ^ 3
        arr_LN_X(intLoop - 1) = Application.WorksheetFunction.Ln(arr_X(intLoop - 1))
        arr_1_div_X(intLoop - 1) = 1 / arr_X(intLoop - 1)
        arr_LN_Y(intLoop - 1) = Application.WorksheetFunction.Ln(arr_Y(intLoop - 1))
        arr_SST(intLoop - 1) = (arr_Y(intLoop - 1) - Mean_Y) ^ 2
       
        arr_Y_minus_Mean_of_LN_Y(intLoop - 1) = Application.WorksheetFunction.Ln(arr_Y(intLoop - 1) - (Min_Data - 1))
        arr_LN_Y_X(intLoop - 1) = Application.WorksheetFunction.Ln(1 / arr_Y(intLoop - 1) - 1 / U)
    Next intLoop
    
    For intLoop = 1 To Data_Count
        arr_SST_Power(intLoop - 1) = (arr_LN_Y(intLoop - 1) - Application.WorksheetFunction.Average(arr_LN_Y)) ^ 2
    Next intLoop
   
    ReDim arr_ERR(0 To 500)
    ReDim arr_Calcs(0 To 500)
    ReDim arr_Difference(0 To 500)
    ReDim arr_Result(0 To 500)
   
    Apply_Curve = Trend_Calc(rngPeriod, rngData, intNumber, strType)
    Exit Function
ErrFound:
    Apply_Curve = 0
End Function
 
Function Trend_Calc(rngPeriod As Range, rngData As Range, intNumber As Integer, strType As String)
    If intNumber <= Data_Count Then
        Trend_Calc = rngData.Cells(1, intNumber)
        Exit Function
    End If
    ReDim XRng_Lin(0 To 1, 0 To Data_Count - 1)
    For intLoop = 1 To Data_Count
        XRng_Lin(0, intLoop - 1) = arr_1(intLoop - 1)
        If strType = "Linear" Then
            XRng_Lin(1, intLoop - 1) = arr_X(intLoop - 1)
        ElseIf strType = "Logarithmic" Then
            XRng_Lin(1, intLoop - 1) = arr_LN_X(intLoop - 1)
        ElseIf strType = "Inverse" Then
            XRng_Lin(1, intLoop - 1) = arr_1_div_X(intLoop - 1)
        ElseIf strType = "Power" Then
            XRng_Lin(1, intLoop - 1) = arr_LN_X(intLoop - 1)
        ElseIf strType = "Exponential" Then
            XRng_Lin(1, intLoop - 1) = arr_X(intLoop - 1)
        ElseIf strType = "S-Shape" Then
            XRng_Lin(1, intLoop - 1) = arr_1_div_X(intLoop - 1)
        End If
    Next intLoop
    ReDim arr_B(0 To 1)
    If strType = "Linear" Then
        arr_B = Application.WorksheetFunction.MMult((Application.WorksheetFunction.MInverse(Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(XRng_Lin)))), Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(arr_Y)))
    ElseIf strType = "Logarithmic" Then
        arr_B = Application.WorksheetFunction.MMult((Application.WorksheetFunction.MInverse(Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(XRng_Lin)))), Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(arr_Y)))
    ElseIf strType = "Inverse" Then
        arr_B = Application.WorksheetFunction.MMult((Application.WorksheetFunction.MInverse(Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(XRng_Lin)))), Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(arr_Y)))
    ElseIf strType = "Power" Then
        arr_B = Application.WorksheetFunction.MMult((Application.WorksheetFunction.MInverse(Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(XRng_Lin)))), Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(arr_LN_Y)))
    ElseIf strType = "Exponential" Then
        arr_B = Application.WorksheetFunction.MMult((Application.WorksheetFunction.MInverse(Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(XRng_Lin)))), Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(arr_LN_Y)))
    ElseIf strType = "S-Shape" Then
        arr_B = Application.WorksheetFunction.MMult((Application.WorksheetFunction.MInverse(Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(XRng_Lin)))), Application.WorksheetFunction.MMult(XRng_Lin, Application.WorksheetFunction.Transpose(arr_LN_Y)))
    End If
    arr_Difference(0) = 1
    For intLoop = 1 To 500
        If strType = "Linear" Then
            arr_Calcs(intLoop - 1) = arr_B(2, 1) * intLoop + arr_B(1, 1)
        ElseIf strType = "Logarithmic" Then
            arr_Calcs(intLoop - 1) = arr_B(2, 1) * Application.WorksheetFunction.Ln(intLoop) + arr_B(1, 1)
        ElseIf strType = "Inverse" Then
            arr_Calcs(intLoop - 1) = arr_B(2, 1) / intLoop + arr_B(1, 1)
        ElseIf strType = "Power" Then
            arr_Calcs(intLoop - 1) = arr_B(2, 1) * Application.WorksheetFunction.Ln(intLoop) + arr_B(1, 1)
        ElseIf strType = "Exponential" Then
            arr_Calcs(intLoop - 1) = arr_B(2, 1) * intLoop + arr_B(1, 1)
        ElseIf strType = "S-Shape" Then
            arr_Calcs(intLoop - 1) = arr_B(2, 1) / intLoop + arr_B(1, 1)
        End If
        If intLoop > 1 Then
            If arr_Calcs(intLoop - 2) = 0 Then
                arr_Difference(intLoop - 1) = 0
            Else
                If strType = "Power" Or strType = "Exponential" Or strType = "S-Shape" Then
                    arr_Difference(intLoop - 1) = Exp(arr_Calcs(intLoop - 1)) / Exp(arr_Calcs(intLoop - 2))
                Else
                    arr_Difference(intLoop - 1) = arr_Calcs(intLoop - 1) / arr_Calcs(intLoop - 2)
                End If
            End If
        End If
        If intLoop <= Data_Count Then
            arr_ERR(intLoop - 1) = (arr_Calcs(intLoop - 1) - arr_Y(intLoop - 1)) ^ 2
        Else
            arr_ERR(intLoop - 1) = 0
        End If
    Next intLoop
    For intLoop = 1 To Data_Count
        arr_Result(intLoop - 1) = rngData.Cells(1, intLoop)
    Next intLoop
    For intLoop = Data_Count + 1 To 500
        arr_Result(intLoop - 1) = arr_Result(intLoop - 2) * arr_Difference(intLoop - 1)
    Next intLoop
    If Data_Count >= 24 Then
        Call Seasonality(rngData)
        If intNumber Mod 12 = 0 Then
            Trend_Calc = arr_Result(intNumber - 1) * Seas_Adjustment(11)
        Else
           Trend_Calc = arr_Result(intNumber - 1) * Seas_Adjustment((intNumber Mod 12) - 1)
        End If
    Else
        Trend_Calc = arr_Result(intNumber - 1)
    End If
End Function
 
Function Seasonality(rngData As Range)
    Dim Seas_Temp1 As Variant, Seas_Temp2 As Variant, intTemp As Integer
   
    ReDim Seas_Months(0 To Data_Count - 1)
    ReDim Seas_MA(0 To Data_Count - 1)
    ReDim Seas_CMA(0 To Data_Count - 1)
    ReDim Seas_Err(0 To Data_Count - 1)
    ReDim Seas_Unadjusted(0 To 11)
    ReDim Seas_Adjustment(0 To 11)
    ReDim Seas_Temp1(0 To 11)
    ReDim Seas_Temp2(0 To 11)
   
    For intLoop = 1 To Data_Count
        Seas_Months(intLoop - 1) = intLoop Mod 12
        If Seas_Months(intLoop - 1) = 0 Then Seas_Months(intLoop - 1) = 12
        Seas_MA(intLoop - 1) = ""
        Seas_CMA(intLoop - 1) = ""
        Seas_Err(intLoop - 1) = ""
    Next intLoop
   
    For intLoop = 1 To Data_Count
        If intLoop >= 6 And intLoop <= Data_Count - 6 Then
            Seas_MA(intLoop - 1) = Application.WorksheetFunction.Average(rngData.Cells(1, intLoop - 5), _
                                                                        rngData.Cells(1, intLoop - 4), _
                                                                        rngData.Cells(1, intLoop - 3), _
                                                                        rngData.Cells(1, intLoop - 2), _
                                                                        rngData.Cells(1, intLoop - 1), _
                                                                        rngData.Cells(1, intLoop), _
                                                                        rngData.Cells(1, intLoop + 1), _
                                                                        rngData.Cells(1, intLoop + 2), _
                                                                        rngData.Cells(1, intLoop + 3), _
                                                                        rngData.Cells(1, intLoop + 4), _
                                                                        rngData.Cells(1, intLoop + 5), _
                                                                        rngData.Cells(1, intLoop + 6))
           
        End If
        If intLoop >= 7 And intLoop <= Data_Count - 6 Then
            Seas_CMA(intLoop - 1) = Application.WorksheetFunction.Average(Seas_MA(intLoop - 1), Seas_MA(intLoop - 2))
            If Seas_CMA(intLoop - 1) <> 0 Then
                Seas_Err(intLoop - 1) = rngData.Cells(1, intLoop) / Seas_CMA(intLoop - 1)
            End If
        End If
    Next intLoop
   
    For intLoop = 1 To 12
        Seas_Temp1(intLoop - 1) = 0
        Seas_Temp2(intLoop - 1) = 0
    Next intLoop
   
    For intLoop = 1 To Data_Count
        intTemp = intLoop Mod 12
        If intTemp = 0 Then intTemp = 12
        intTemp = intTemp - 1
       
        If Seas_Err(intLoop - 1) <> "" Then Seas_Temp1(intTemp) = Seas_Temp1(intTemp) + Seas_Err(intLoop - 1)
        If Seas_CMA(intLoop - 1) <> "" And Seas_Err(intLoop - 1) <> "" And Seas_Err(intLoop - 1) > 0 Then
            Seas_Temp2(intTemp) = Seas_Temp2(intTemp) + 1
        End If
    Next intLoop
   
    For intLoop = 1 To 12
        If Seas_Temp2(intLoop - 1) <> 0 Then Seas_Unadjusted(intLoop - 1) = Seas_Temp1(intLoop - 1) / Seas_Temp2(intLoop - 1)
    Next intLoop
   
    Seas_Adj_Factor = 12 / Application.WorksheetFunction.Sum(Seas_Unadjusted)
    For intLoop = 1 To 12
        Seas_Adjustment(intLoop - 1) = Seas_Unadjusted(intLoop - 1) * Seas_Adj_Factor
    Next intLoop
   
End Function

