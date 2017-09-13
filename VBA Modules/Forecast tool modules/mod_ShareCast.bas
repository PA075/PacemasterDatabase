Attribute VB_Name = "mod_ShareCast"
Option Explicit

Function Second_Min(rng As Range, Min_Value As Double)
    Dim intLoop As Integer
    Dim intValue As Double
    
    intValue = Application.WorksheetFunction.Max(rng)
    For intLoop = 1 To rng.Rows.Count
        If rng.Cells(intLoop, 1) > Min_Value And rng.Cells(intLoop, 1) < intValue Then
            intValue = rng.Cells(intLoop, 1)
        End If
    Next intLoop
    Second_Min = intValue
End Function

''---------------------------------------------------------------------------------------------------------------------------------------------
''ShareCast FUNCTION
''---------------------------------------------------------------------------------------------------------------------------------------------

Function ShareCast_New(dAttractionRate As Double, vLaunchTime As Variant, dStartRate As Double, dUptake As Double, _
    dTimeToPeak As Double, vTimeInLag As Variant, vTimePeriod As Variant, dTimeInterval As Double, dTimePeriodInterval As Variant) As Variant
    
    If Left(vLaunchTime, 1) = "Q" Then
        If Mid(vLaunchTime, 2, 1) = "1" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 1, 1)
        ElseIf Mid(vLaunchTime, 2, 1) = "2" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 4, 1)
        ElseIf Mid(vLaunchTime, 2, 1) = "3" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 7, 1)
        ElseIf Mid(vLaunchTime, 2, 1) = "4" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 10, 1)
        End If
    End If
    
    If Left(vTimePeriod, 1) = "Q" Then
        If Mid(vTimePeriod, 2, 1) = "1" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 1, 1)
        ElseIf Mid(vTimePeriod, 2, 1) = "2" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 4, 1)
        ElseIf Mid(vTimePeriod, 2, 1) = "3" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 7, 1)
        ElseIf Mid(vTimePeriod, 2, 1) = "4" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 10, 1)
        End If
    End If
    
    If dTimeInterval = 1 Then
        If IsNumeric(vLaunchTime) And vLaunchTime > vTimePeriod And Left(ActiveSheet.CodeName, 10) <> "wks_Single" And Left(ActiveSheet.CodeName, 6) <> "wks_O3" Then
            ShareCast_New = 0
            Exit Function
        ElseIf Year(vLaunchTime) > vTimePeriod And Left(ActiveSheet.CodeName, 10) <> "wks_Single" And Left(ActiveSheet.CodeName, 6) <> "wks_O3" Then
            ShareCast_New = 0
            Exit Function
        End If
    Else
        If vLaunchTime > vTimePeriod And Left(ActiveSheet.CodeName, 10) <> "wks_Single" And Left(ActiveSheet.CodeName, 6) <> "wks_O3" Then
            ShareCast_New = 0
            Exit Function
        End If
    End If
    
    If dUptake = 0 Then
        vTimeInLag = 0
    End If

    'LAG NEW FUNCTION
    Dim intDifference As Variant
    Dim intDifference2 As Variant
    Dim intStartPoint As Double
    Dim intEndPoint As Double
    Dim intThatPoint As Variant
    Dim intTemp As Variant
    Dim blnFlag As Boolean
    Dim intLag As Variant
    If vTimeInLag > 0 Then
        If dTimeInterval = 1 Then
            intDifference = vLaunchTime + vTimeInLag - 1
        ElseIf dTimeInterval = 4 Then
            intDifference = DateAdd("m", (vTimeInLag - 1) * 3, vLaunchTime)
        Else
            intDifference = DateAdd("m", vTimeInLag - 1, vLaunchTime)
        End If
        If intDifference >= vTimePeriod Then
            dUptake = 0
            vTimeInLag = 0
            blnFlag = True
        Else
            If dTimeInterval = 1 Then
                intDifference2 = intDifference + dTimeToPeak - vTimeInLag
            ElseIf dTimeInterval = 4 Then
                intDifference2 = DateAdd("m", (dTimeToPeak - vTimeInLag) * 3, intDifference)
            Else
                intDifference2 = DateAdd("m", (dTimeToPeak - vTimeInLag), intDifference)
''                intDifference2 = DateAdd("m", Round((dTimeToPeak - vTimeInLag) / 4, 0), intDifference)
            End If
            If intDifference2 >= vTimePeriod Then
                blnFlag = False
                If dTimeInterval = 1 Then
                    If vTimePeriod = intDifference + 1 Then blnFlag = True
                ElseIf dTimeInterval = 4 Then
                    If vTimePeriod = DateAdd("m", 3, intDifference) Then blnFlag = True
                Else
                    If vTimePeriod = DateAdd("m", 1, intDifference) Then blnFlag = True
                End If
                If blnFlag = False Then
                    If dTimeInterval = 12 Then
                        intStartPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, 0, dTimeToPeak / 12, 0, intDifference, dTimeInterval, True)
                        intEndPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak / 12, 0, intDifference2, dTimeInterval, True)
                        intThatPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak / 12, 0, vTimePeriod, dTimeInterval, True)
                    ElseIf dTimeInterval = 4 Then
                        intStartPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, 0, dTimeToPeak / 4, 0, intDifference, dTimeInterval, True)
                        intEndPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak / 4, 0, intDifference2, dTimeInterval, True)
                    Else
                        intStartPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, 0, dTimeToPeak, 0, intDifference, dTimeInterval, True)
                        intEndPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak, 0, intDifference2, dTimeInterval, True)
                    End If
                    
                    If vTimeInLag / dTimeToPeak >= 0.2 Then
                        If dTimeInterval = 1 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag), 0, vTimePeriod, dTimeInterval, False)
                        ElseIf dTimeInterval = 4 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 4, 0, vTimePeriod, dTimeInterval, False)
                        Else
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 12, 0, vTimePeriod, dTimeInterval, False)
                        End If
                    Else
                        If dTimeInterval = 1 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag), 0, vTimePeriod, dTimeInterval, True)
                        ElseIf dTimeInterval = 4 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 4, 0, vTimePeriod, dTimeInterval, True)
                        Else
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 12, 0, vTimePeriod, dTimeInterval, True)
                        End If
                    End If
                Else
                    If dTimeInterval = 12 Then
                        intStartPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, 0, dTimeToPeak / 12, 0, intDifference, dTimeInterval, True)
                        intEndPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak / 12, 0, intDifference2, dTimeInterval, True)
                        intThatPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak / 12, 0, vTimePeriod, dTimeInterval, True)
                    ElseIf dTimeInterval = 4 Then
                        intStartPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, 0, dTimeToPeak / 4, 0, intDifference, dTimeInterval, True)
                        intEndPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak / 4, 0, intDifference2, dTimeInterval, True)
                    Else
                        intStartPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, 0, dTimeToPeak, 0, intDifference, dTimeInterval, True)
                        intEndPoint = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak, 0, intDifference2, dTimeInterval, True)
                    End If
                    
                    If vTimeInLag / dTimeToPeak >= 0.2 Then
                        If dTimeInterval = 1 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag), 0, vTimePeriod + 1, dTimeInterval, False)
                        ElseIf dTimeInterval = 1 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 4, 0, DateAdd("m", 3, vTimePeriod), dTimeInterval, False)
                        Else
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 12, 0, DateAdd("m", 1, vTimePeriod), dTimeInterval, False)
                        End If
                    Else
                        If dTimeInterval = 1 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag), 0, vTimePeriod + 1, dTimeInterval, True)
                        ElseIf dTimeInterval = 4 Then
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 4, 0, DateAdd("m", 3, vTimePeriod), dTimeInterval, True)
                        Else
                            ShareCast_New = ShareCast(dAttractionRate, intDifference, intStartPoint, (dUptake + 10) / 2, (dTimeToPeak - vTimeInLag) / 12, 0, DateAdd("m", 1, vTimePeriod), dTimeInterval, True)
                        End If
                    End If
                    
                    ShareCast_New = (ShareCast_New + intStartPoint) / 2
                End If
                Exit Function
            Else
                vTimeInLag = 0
                blnFlag = True
            End If
        End If
    Else
        blnFlag = True
    End If
    
    If dTimeInterval = 12 Then
        dTimeToPeak = dTimeToPeak / 12
        If Not IsMissing(vTimeInLag) And Not IsEmpty(vTimeInLag) And vTimeInLag <> "" Then vTimeInLag = vTimeInLag / 12
    ElseIf dTimeInterval = 4 Then
        dTimeToPeak = dTimeToPeak / 4
        If Not IsMissing(vTimeInLag) And Not IsEmpty(vTimeInLag) And vTimeInLag <> "" Then vTimeInLag = vTimeInLag / 4
    End If
''    dTimeToPeak = dTimeToPeak * 24
    If Not IsMissing(vTimeInLag) And Not IsEmpty(vTimeInLag) And vTimeInLag <> "" Then
        If vTimeInLag >= dTimeToPeak Then
            vTimeInLag = dTimeToPeak - 0.00001
        End If
    End If
    
    ShareCast_New = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak, vTimeInLag, vTimePeriod, dTimeInterval, blnFlag)
    
    If ShareCast_New > 1 Then ShareCast_New = 1
End Function

Function ShareCast_Old(dAttractionRate As Double, vLaunchTime As Variant, dStartRate As Double, dUptake As Double, _
    dTimeToPeak As Double, vTimeInLag As Variant, vTimePeriod As Variant, dTimeInterval As Double, dTimePeriodInterval As Variant) As Variant
    
    If Left(vLaunchTime, 1) = "Q" Then
        If Mid(vLaunchTime, 2, 1) = "1" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 1, 1)
        ElseIf Mid(vLaunchTime, 2, 1) = "2" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 4, 1)
        ElseIf Mid(vLaunchTime, 2, 1) = "3" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 7, 1)
        ElseIf Mid(vLaunchTime, 2, 1) = "4" Then
            vLaunchTime = DateSerial(Right(vLaunchTime, 4), 10, 1)
        End If
    End If
    
    If Left(vTimePeriod, 1) = "Q" Then
        If Mid(vTimePeriod, 2, 1) = "1" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 1, 1)
        ElseIf Mid(vTimePeriod, 2, 1) = "2" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 4, 1)
        ElseIf Mid(vTimePeriod, 2, 1) = "3" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 7, 1)
        ElseIf Mid(vTimePeriod, 2, 1) = "4" Then
            vTimePeriod = DateSerial(Right(vTimePeriod, 4), 10, 1)
        End If
    End If
    
    If dTimeInterval = 1 Then
        If IsNumeric(vLaunchTime) And vLaunchTime > vTimePeriod And Left(ActiveSheet.CodeName, 10) <> "wks_Single" And Left(ActiveSheet.CodeName, 6) <> "wks_O3" Then
            ShareCast_Old = 0
            Exit Function
        ElseIf Year(vLaunchTime) > vTimePeriod And Left(ActiveSheet.CodeName, 10) <> "wks_Single" And Left(ActiveSheet.CodeName, 6) <> "wks_O3" Then
            ShareCast_Old = 0
            Exit Function
        End If
    Else
        If vLaunchTime > vTimePeriod And Left(ActiveSheet.CodeName, 10) <> "wks_Single" And Left(ActiveSheet.CodeName, 6) <> "wks_O3" Then
            ShareCast_Old = 0
            Exit Function
        End If
    End If
    
    If dTimeInterval = 12 Then
        dTimeToPeak = dTimeToPeak / 12
        If Not IsMissing(vTimeInLag) And Not IsEmpty(vTimeInLag) Then vTimeInLag = vTimeInLag / 12
    ElseIf dTimeInterval = 4 Then
        dTimeToPeak = dTimeToPeak / 4
        If Not IsMissing(vTimeInLag) And Not IsEmpty(vTimeInLag) Then vTimeInLag = vTimeInLag / 4
    End If
''    dTimeToPeak = dTimeToPeak * 24
    If Not IsMissing(vTimeInLag) And Not IsEmpty(vTimeInLag) Then
        If vTimeInLag >= dTimeToPeak Then
            vTimeInLag = dTimeToPeak - 0.00001
        End If
    End If
    
    ShareCast_Old = ShareCast(dAttractionRate, vLaunchTime, dStartRate, dUptake, dTimeToPeak, vTimeInLag, vTimePeriod, dTimeInterval, True)
    If ShareCast_Old > 1 Then ShareCast_Old = 1
End Function

Function ShareCast(dAttractionRate As Double, vLaunchTime As Variant, dStartRate As Double, dUptake As Double, _
    dTimeToPeak As Double, vTimeInLag As Variant, vTimePeriod As Variant, dTimeInterval As Double, blnFlag As Boolean) As Variant
  
    On Error GoTo TimeIndexError
  
    Dim sPercentS_Shape As Double, sPercentRapid As Double
   ' Dim sPercentS_Shape As Single, sPercentRapid As Single
    Dim dTimeLag As Double
  
    ' force curve type limits
    If dUptake < 0 Then dUptake = 0
    If dUptake > 10 Then dUptake = 10
    
    ' test for pure S-shaped curve, use lag parameter
    If IsMissing(vTimeInLag) Or IsEmpty(vTimeInLag) Or vTimeInLag = "" Then 'Or vTimeInLag = 0
        dTimeLag = dTimeToPeak / 4
    Else
        dTimeLag = vTimeInLag
        If dTimeLag < 0 Then dTimeLag = 0
    End If

    ' calculate curve type weight
    
    sPercentS_Shape = 1 - (dUptake / 10)
    sPercentRapid = 1 - sPercentS_Shape
    
    If dTimeToPeak < 0 Then
        ShareCast = dStartRate
    Else
        ShareCast = sPercentS_Shape * SF_SCurve(dAttractionRate, vLaunchTime, dStartRate, dTimeToPeak, dTimeLag, vTimePeriod, dUptake, dTimeInterval, blnFlag) + _
                sPercentRapid * SF_RCurve(dAttractionRate, vLaunchTime, dStartRate, dTimeToPeak, vTimePeriod, dTimeInterval)
        'Uptake = (1 - dUptake) * SCurve(dAttractionRate, dTimeToPeak, dTimeToPeak / 4, vLaunchTime, vTimePeriod, dTimeInterval) + dUptake * FCurve(dAttractionRate, dTimeToPeak, vLaunchTime, vTimePeriod, dTimeInterval)
    End If
  
    Exit Function
TimeIndexError:
    If Err.Number = 11 Then
        ShareCast = "TimeIndex Error"
    End If
  
End Function

Function SF_RCurve(dAttractionRate As Double, vLaunchTime As Variant, dStartRate As Double, dTimeToPeak As Double, vTimePeriod As Variant, _
    dTimeInterval As Double) As Double
  
    ' Developed by Living Analytics, LLC, 2009
  
    Dim dLaunch As Double, dTime As Double, dIncrement As Double, dSlo As Double
    Dim dLower As Double, dUpper As Double, dLowerLimit As Double, dUpperLimit As Double
    Dim dAsymp As Double
  
    dLaunch = SF_TimeIndex(vLaunchTime)  ' Convert time and launch values to double precision values
    dTime = SF_TimeIndex(vTimePeriod)
    
    dAsymp = 0.9975
    
    If dTimeToPeak <= 0 Then
        SF_RCurve = SF_StepFunction(dAttractionRate, dStartRate, dLaunch, dTime, dTimeInterval)
        Exit Function
    End If
  
    If dTimeInterval = 0 Then ' Test for integral: if dInterval=0, the curve is evaluated at a point
        If dTime < dLaunch Then ' Evaluate the curve at a point
            SF_RCurve = 0
        Else
            dSlo = 3.50655789731998 / dTimeToPeak '-3.50655789731998 comes from the Log(1-0.9975) term in the TMax equation
            SF_RCurve = dAttractionRate * (1 - 1 / Exp(dSlo * (dTime - dLaunch)))
        End If
    Else
        dIncrement = SF_TimeIncrement(dTimeInterval, vTimePeriod)
        dLower = Application.Max(dTime, dLaunch)
        dUpper = Application.Max(dTime + dIncrement, dLaunch)
        dSlo = Log(1 - dAsymp) * -1 / dTimeToPeak
''        dSlo = 3.50655789731998 / dTimeToPeak '-3.50655789731998 comes from the Log(1-0.9975) term in the TMax equation
        dLowerLimit = (dAttractionRate - dStartRate) * (dLower + 1 / dSlo * Exp(-(dSlo * (dLower - dLaunch))))
        dUpperLimit = (dAttractionRate - dStartRate) * (dUpper + 1 / dSlo * Exp(-(dSlo * (dUpper - dLaunch))))
        
        SF_RCurve = dStartRate + (dUpperLimit - dLowerLimit) / dIncrement
    End If
  
End Function
Function SF_SCurve(dAttractionRate As Double, vLaunchTime As Variant, dStartRate As Double, dTimeToPeak As Double, dLag As Double, vTimePeriod As Variant, dUptake As Variant, dTimeInterval As Double, blnFlag As Boolean) As Double
    ' Developed by Living Analytics, LLC, 2009
    
    Dim dLaunch As Double, dTime As Double, dIncrement As Double, dCon As Double, dSlo As Double
    Dim dLower As Double, dUpper As Double, dLowerLimit As Double, dUpperLimit As Double
    Dim dAsymp As Double
    
    dLaunch = SF_TimeIndex(vLaunchTime)  ' Convert time and launch values to double precision values
    dTime = SF_TimeIndex(vTimePeriod)
    dAsymp = 0.9975
    
    If dTimeToPeak = dLag Or dTimeToPeak = 0 Then
        If dTimeToPeak < 0 Then dTimeToPeak = 0
        SF_SCurve = SF_StepFunction(dAttractionRate, dStartRate, dLaunch + dTimeToPeak, dTime, dTimeInterval)
        Exit Function
    End If
    
    If dTimeInterval = 0 Then ' Test for integral: if dInterval=0, the curve is evaluated at a point
        If dTime < dLaunch Then ' Evaluate the curve at a point
            SF_SCurve = 0
        Else
            dCon = 1 / (1 - dLag / dTimeToPeak) * Log((1 / 0.15 - 1) / ((1 / dAsymp - 1) ^ (dLag / dTimeToPeak)))
            dSlo = 1 / dTimeToPeak * (Log(1 / dAsymp - 1) - dCon)
            SF_SCurve = dAttractionRate / (1 + Exp(dCon + dSlo * (dTime - dLaunch)))
        End If
    Else
        dIncrement = SF_TimeIncrement(dTimeInterval, vTimePeriod)
        dLower = Application.Max(dTime, dLaunch)  ' Evaluate the integral
        dUpper = Application.Max(dTime + dIncrement, dLaunch)
        If blnFlag = False Then
            dCon = 1 / (1 - dLag / dTimeToPeak) * Log((1 / (0.07 + (dUptake / 100)) - 1) / ((1 / dAsymp - 1) ^ (dLag / dTimeToPeak)))
        Else
            dCon = 1 / (1 - dLag / dTimeToPeak) * Log((1 / (0.01 + (dUptake / 100)) - 1) / ((1 / dAsymp - 1) ^ (dLag / dTimeToPeak)))
        End If
        dSlo = 1 / dTimeToPeak * (Log(1 / dAsymp - 1) - dCon)
        dLowerLimit = (dAttractionRate - dStartRate) / dSlo * ((dCon + dSlo * (dLower - dLaunch)) - Log(1 + Exp(dCon + dSlo * (dLower - dLaunch))))
        dUpperLimit = (dAttractionRate - dStartRate) / dSlo * ((dCon + dSlo * (dUpper - dLaunch)) - Log(1 + Exp(dCon + dSlo * (dUpper - dLaunch))))
        
        SF_SCurve = dStartRate + (dUpperLimit - dLowerLimit) / dIncrement
    End If
  
End Function

Function SF_TimeIndex(vTimePeriod As Variant) As Double
'Dim intmonthday As Integer, intI As Integer
  If IsDate(vTimePeriod) Then
    'TimeIndex = Year(vTimePeriod) + (Month(vTimePeriod) - 1) / 12
    SF_TimeIndex = CDbl(Year(vTimePeriod) + (Month(vTimePeriod) - 1) / 12 + (Day(vTimePeriod) - 1) / 365)
    'intmonthday = Application.WorksheetFunction.Choose((Month(vTimePeriod)), 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334)
    'TimeIndex = CDbl(Year(vTimePeriod) + (intmonthday + (Day(vTimePeriod) - 1)) / 365)
''    SF_TimeIndex = CDbl(vTimePeriod)
  Else
    If IsNumeric(vTimePeriod) Then
      SF_TimeIndex = CDbl(vTimePeriod)
    Else
        SF_TimeIndex = 1 / 0
    End If
  End If
End Function

Function SF_TimeIncrement(dTimeInterval As Double, vTimePeriod As Variant) As Double

    Select Case dTimeInterval
        Case 1
            'If the interval is Year, then the increment is 1
            SF_TimeIncrement = 1
        Case 4
            'If the interval is Quarters, then the increment is 3, since there are 3 months in a Quarter
            SF_TimeIncrement = Day(DateSerial(Year(vTimePeriod), Month(vTimePeriod) + 1, 1) - 1) / 365
        Case 12
            'If the increment is Months, then determine the exact number of days in the month of launch
            'TimeIncrement = 1
             SF_TimeIncrement = Day(DateSerial(Year(vTimePeriod), Month(vTimePeriod) + 1, 1) - 1) / 365
        Case Else
    End Select

End Function

Function SF_StepFunction(dStartRate As Double, dEnd As Double, dLaunch As Double, dTimeNow As Double, dTimeInterval As Double) As Double
  Dim intCase As Integer
  
  If dTimeNow + dTimeInterval <= dLaunch Then intCase = 1  ' Entire interval is before launch
  If dTimeNow >= dLaunch Then intCase = 2                ' Entire interval is after launch
  
  Select Case intCase
    Case 1
      SF_StepFunction = dStartRate * dTimeInterval
    Case 2
      SF_StepFunction = dEnd * dTimeInterval
    Case Else
      Dim dWeight As Double
      dWeight = (dLaunch - dTimeNow) / dTimeInterval
      SF_StepFunction = dWeight * dStartRate + (1 - dWeight) * dEnd
  End Select
End Function

