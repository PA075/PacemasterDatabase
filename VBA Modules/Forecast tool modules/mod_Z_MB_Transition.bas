Attribute VB_Name = "mod_Z_MB_Transition"
Option Explicit

'/////////////////////////////////////////// Share Diffusion UDFs //////////////////////////////////////////////
Function MB_Progression(rType As Range, rStart As Range, rShr As Range, rTTP As Range, rLag As Range, rLaunch As Range, _
    rTime As Range, dInterval As Double, Optional rEvt As Range, Optional rEvtStart As Range) As Variant

'End '

Dim dType As Double, dStart As Double, dMax As Double, dTimeToMax As Double, dTimeInLag As Double, _
    dLaunch As Double, dMatch As Double, dIndex As Double
Dim vTimeInLag As Variant, vLaunch As Variant, vShr() As Variant, vSumShr() As Variant, vNormShr() As Variant, _
    vTime As Variant
Dim TotComp As Integer, TotTime As Integer, i As Integer, j As Integer

    TotComp = rShr.Rows.Count
    TotTime = rTime.Columns.Count

'ReDim dStart(1 To TotComp, 1 To TotTime)
'ReDim dMax(1 To TotComp, 1 To TotTime)
ReDim vShr(1 To TotComp, 1 To TotTime)
ReDim vSumShr(1 To TotTime)
ReDim vNormShr(1 To TotComp, 1 To TotTime)
    
    For j = 1 To TotTime
    
        For i = 1 To TotComp
        
            dType = rType(1, j)
            
            'Check for Event Inputs
            If j > 1 And Not IsEmpty(rEvt(1, j)) And rEvt(1, j) <> "Evt0" Then
            
                'Determine the time period when the current event begins
                dMatch = Application.WorksheetFunction.Match(rEvt(1, j), rEvtStart, 0)
                'Starting share for a competitor equals the share in the period before the event begins
                dStart = vShr(i, dMatch - 1)
                
            Else
                'Starting share equals the initial share entered by the user
                dStart = rStart(i)
            
            End If

            dMax = rShr(i, j)
            'dMax = rShr(i, j).Value
            dTimeToMax = rTTP(1, j)
            dTimeInLag = rLag(1, j)
            vLaunch = rLaunch(i, j)
            vTime = rTime(j)
            'vTime = rTime(j).Value
            
            vShr(i, j) = MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
            'vShr(i, j) = MB_Transition(dType, dStart(i, j), dMax(i, j), dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
            vSumShr(j) = vSumShr(j) + vShr(i, j)
            
        Next i
        
    Next j
    
    For j = 1 To TotTime
    
        For i = 1 To TotComp
            
            If vSumShr(j) = 0 Then
                vNormShr(i, j) = 0
            Else
                vNormShr(i, j) = vShr(i, j) / vSumShr(j)
            End If
            
        Next i
        
    Next j
    
    MB_Progression = vNormShr

End Function

Function OldMB_Progression(rType As Range, rStart As Range, rShr As Range, rTTP As Range, rLag As Range, rLaunch As Range, _
    rTime As Range, vInterval As Double) As Variant

Dim dType As Double, dStart As Double, dMax() As Double, dTimeToMax As Double, dTimeInLag As Double, _
    dLaunch As Double, dInterval As Double
Dim vTimeInLag As Variant, vLaunch As Variant, vShr() As Variant, vSumShr() As Variant, vNormShr() As Variant, _
    vTime As Variant
Dim TotComp As Integer, TotTime As Integer, i As Integer, j As Integer

    TotComp = rShr.Rows.Count
    TotTime = rTime.Columns.Count

ReDim dMax(1 To TotComp, 1 To TotTime)
ReDim vShr(1 To TotComp, 1 To TotTime)
ReDim vSumShr(1 To TotTime)
ReDim vNormShr(1 To TotComp, 1 To TotTime)
    
    dType = rType.Value
    dTimeToMax = rTTP.Value
    dTimeInLag = rLag.Value
    dInterval = vInterval
    
    For j = 1 To TotTime
    
        vTime = rTime(1, j)
    
        For i = 1 To TotComp
        
            dStart = rStart(i)
            dMax(i, j) = rShr(i, j).Value
            vLaunch = rLaunch(i)
            vTime = rTime(j).Value
            
            vShr(i, j) = MB_Transition(dType, dStart, dMax(i, j), dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
            vSumShr(j) = vSumShr(j) + vShr(i, j)
            
        Next i
        
    Next j
    
    For j = 1 To TotTime
    
        For i = 1 To TotComp
            
            If vSumShr(j) = 0 Then
                vNormShr(i, j) = 0
            Else
                vNormShr(i, j) = vShr(i, j) / vSumShr(j)
            End If
            
        Next i
        
    Next j
    
    OldMB_Progression = vNormShr

End Function

Function MB_Evolution(rEvt As Range, rShr As Range, rLaunch As Range, rTime As Range, dInterval As Double, _
    PGNum As Integer) As Variant
    
Dim dType As Double, dStart As Double, dMax() As Double, dTimeToMax As Double, dLaunch As Double
Dim vTimeInLag As Variant, vLaunch As Variant, vEvtLaunch As Variant, vShr() As Variant, vSumShr() As Variant, _
    vNormShr() As Variant, vTime As Variant
Dim TotComp As Integer, TotTime As Integer, i As Integer, j As Integer
Dim sEvt As String

    TotComp = rShr.Rows.Count
    TotTime = rTime.Columns.Count

ReDim dMax(1 To TotComp, 1 To TotTime)
ReDim vShr(1 To TotComp, 1 To TotTime)
ReDim vSumShr(1 To TotTime)
ReDim vNormShr(1 To TotComp, 1 To TotTime)
    
    For j = 1 To TotTime
    
        sEvt = rEvt(j).Value
    
        For i = 1 To TotComp
        
            dMax(i, j) = rShr(i, j).Value
            vTime = rTime(j).Value
    
            If sEvt = "BL" Then
                
                dType = Range("uptk_BL_PG" & PGNum).Value
                dStart = Range("shrStart_Comp" & i & "_PG" & PGNum).Value
                dTimeToMax = Range("ttp_BL_PG" & PGNum).Value
                vTimeInLag = Range("lag_BL_PG" & PGNum).Value
                vLaunch = Int(rLaunch(i).Value)

            Else
            
                vEvtLaunch = Int(Range("lch_" & sEvt & "_PG" & PGNum).Value)
                
                If Int(rLaunch(i).Value) > vEvtLaunch Then
                
                    dType = Range("uptk_BL_PG" & PGNum).Value
                    dStart = Range("shrStart_Comp" & i & "_PG" & PGNum).Value
                    dTimeToMax = Range("ttp_BL_PG" & PGNum).Value
                    vTimeInLag = Range("lag_BL_PG" & PGNum).Value
                    vLaunch = Int(rLaunch(i).Value)
                
                Else
                
                    dType = Range("uptk_" & sEvt & "_PG" & PGNum).Value
                        
                    If j = 1 Then
                        dStart = Range("shrStart_Comp" & i & "_PG" & PGNum).Value
                    Else
                        If rEvt(j) <> rEvt(j - 1) Then
                            dStart = vShr(i, j - 1)
                        End If
                    End If
                    
                    dTimeToMax = Range("ttp_" & sEvt & "_PG" & PGNum).Value
                    vTimeInLag = Range("lag_" & sEvt & "_PG" & PGNum).Value
                    vLaunch = vEvtLaunch
                    
                End If
            
            End If
            
            vShr(i, j) = MB_Transition(dType, dStart, dMax(i, j), dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
            vSumShr(j) = vSumShr(j) + vShr(i, j)
            
        Next i
        
    Next j
    
    For j = 1 To TotTime
    
        For i = 1 To TotComp
            
            If vSumShr(j) = 0 Then
                vNormShr(i, j) = 0
            Else
                vNormShr(i, j) = vShr(i, j) / vSumShr(j)
            End If
            
        Next i
        
    Next j
    
    MB_Evolution = vNormShr

End Function

Function OldMB_Evolution(rEvt As Range, rShr As Range, rLaunch As Range, rTime As Range, dInterval As Double, _
    Optional SegNum As Integer, Optional PGNum As Integer, Optional GeoNum As Integer) As Variant
    
Dim dType As Double, dStart As Double, dMax() As Double, dTimeToMax As Double, dLaunch As Double
Dim vTimeInLag As Variant, vLaunch As Variant, vEvtLaunch As Variant, vShr() As Variant, vSumShr() As Variant, _
    vNormShr() As Variant, vTime As Variant
Dim TotComp As Integer, TotTime As Integer, i As Integer, j As Integer
Dim sEvt As String

    TotComp = rShr.Rows.Count
    TotTime = rTime.Columns.Count

ReDim dMax(1 To TotComp, 1 To TotTime)
ReDim vShr(1 To TotComp, 1 To TotTime)
ReDim vSumShr(1 To TotTime)
ReDim vNormShr(1 To TotComp, 1 To TotTime)
    
    For j = 1 To TotTime
    
        sEvt = rEvt(j).Value
    
        For i = 1 To TotComp
        
            dMax(i, j) = rShr(i, j).Value
            vTime = rTime(j).Value
    
            If sEvt = "BL" Then
                
                dType = Range("uptake_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                    & GeoNum).Value
                dStart = Range("dim_shrStart_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                    & GeoNum).Value
                dTimeToMax = Range("ttp_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                    & GeoNum).Value
                vTimeInLag = Range("lag_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                    & GeoNum).Value
                vLaunch = Int(rLaunch(i).Value)

            Else
            
                vEvtLaunch = Int(Range("timing_RA" & sEvt & "_Seg" & SegNum & "_G" & GeoNum).Value)
                
                If Int(rLaunch(i).Value) > vEvtLaunch Then
                
                    dType = Range("uptake_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                        & GeoNum).Value
                    dStart = Range("dim_shrStart_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                        & GeoNum).Value
                    dTimeToMax = Range("ttp_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                        & GeoNum).Value
                    vTimeInLag = Range("lag_Comp" & i & "_Seg" & SegNum & "_PG" & PGNum & "_G" _
                        & GeoNum).Value
                    vLaunch = Int(rLaunch(i).Value)
                
                Else
                
                    dType = Range("uptake_RA" & sEvt & "_Seg" & SegNum & "_G" & GeoNum).Value
                        
                    If j = 1 Then
                        dStart = Range("dim_shrStart_Comp" & i & "_Seg" & SegNum & "_G" & GeoNum).Value
                    Else
                        If rEvt(j) <> rEvt(j - 1) Then
                            dStart = vShr(i, j - 1)
                        End If
                    End If
                    
                    dTimeToMax = Range("ttp_RA" & sEvt & "_Seg" & SegNum & "_G" & GeoNum).Value
                    vTimeInLag = Range("lag_RA" & sEvt & "_Seg" & SegNum & "_G" & GeoNum).Value
                    vLaunch = vEvtLaunch
                    
                End If
            
            End If
            
            vShr(i, j) = MB_Transition(dType, dStart, dMax(i, j), dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
            vSumShr(j) = vSumShr(j) + vShr(i, j)
            
        Next i
        
    Next j
    
    For j = 1 To TotTime
    
        For i = 1 To TotComp
            
            If vSumShr(j) = 0 Then
                vNormShr(i, j) = 0
            Else
                vNormShr(i, j) = vShr(i, j) / vSumShr(j)
            End If
            
        Next i
        
    Next j
    
    OldMB_Evolution = vNormShr

End Function

Function MB_Transition(dType As Double, dStart As Double, dMax As Double, dTimeToMax As Double, vTimeInLag As Variant, _
    vLaunch As Variant, vTime As Variant, dInterval As Double) As Variant
  
    ' Developed by Living Analytics, LLC, 2009
  
    On Error GoTo MB_TimeIndexError
    
    If vTime < vLaunch Then
        MB_Transition = 0
        Exit Function
    End If
  
    Dim sPercentSCurve As Single, sPercentMB_RapidCurve As Single
    Dim dTimeLag As Double, intLoop As Integer
  
    ' force curve type limits
    If dType < 0 Then dType = 0
    If dType > 10 Then dType = 10
    
    ' test for pure S-shaped curve, use lag parameter
    If IsMissing(vTimeInLag) Or IsEmpty(vTimeInLag) Then  'or dType > 0
        dTimeLag = dTimeToMax / 4
    Else
        dTimeLag = vTimeInLag
    End If
  
    ' calculate curve type weight
    sPercentSCurve = 1 - (dType / 10)
    sPercentMB_RapidCurve = 1 - sPercentSCurve
    
    If dTimeToMax < 0 Then
        MB_Transition = dStart
    Else
        MB_Transition = sPercentSCurve * MB_S_ShapeCurve(dStart, dMax, dTimeToMax, dTimeLag, vLaunch, vTime, dInterval) + _
                sPercentMB_RapidCurve * MB_RapidCurve(dStart, dMax, dTimeToMax, vLaunch, vTime, dInterval)
      'Uptake = (1 - dType) * SCurve(dMax, dTimeToMax, dTimeToMax / 4, vLaunch, vTime, dInterval) + dType * FCurve(dMax, dTimeToMax, vLaunch, vTime, dInterval)
    End If
  
    Exit Function
MB_TimeIndexError:
    If Err.Number = 11 Then
        MB_Transition = "MB_TimeIndex Error"
    End If
  
End Function

Function MB_RapidCurve(dStart As Double, dMax As Double, dTimeToMax As Double, vLaunch As Variant, vTime As Variant, _
    dInterval As Double) As Double
  
    ' Developed by Living Analytics, LLC, 2009
  
    Dim dLaunch As Double, dTime As Double, dIncrement As Double, dSlo As Double
    Dim dLower As Double, dUpper As Double, dLowerLimit As Double, dUpperLimit As Double
  
    dLaunch = MB_TimeIndex(vLaunch)  ' Convert time and launch values to double precision values
    dTime = MB_TimeIndex(vTime)
  
    If dTimeToMax <= 0 Then
        MB_RapidCurve = MB_StepFunction(dStart, dMax, dLaunch, dTime, dInterval)
        Exit Function
    End If
  
    If dInterval = 0 Then ' Test for integral: if dInterval=0, the curve is evaluated at a point
        If dTime < dLaunch Then ' Evaluate the curve at a point
            MB_RapidCurve = 0
        Else
            dSlo = 3.50655789731998 / dTimeToMax '-3.50655789731998 comes from the Log(1-0.98) term in the TMax equation
            MB_RapidCurve = dMax * (1 - 1 / Exp(dSlo * (dTime - dLaunch)))
        End If
    Else
        dIncrement = MB_TimeIncrement(dInterval, dLaunch)
        dLower = Application.Max(dTime, dLaunch)
        dUpper = Application.Max(dTime + dIncrement, dLaunch)
        dSlo = Log(1 - 0.98) * -1 / dTimeToMax
        dSlo = 3.50655789731998 / dTimeToMax '-3.50655789731998 comes from the Log(1-0.98) term in the TMax equation
        dLowerLimit = (dMax - dStart) * (dLower + 1 / dSlo * Exp(-(dSlo * (dLower - dLaunch))))
        dUpperLimit = (dMax - dStart) * (dUpper + 1 / dSlo * Exp(-(dSlo * (dUpper - dLaunch))))
        
        MB_RapidCurve = dStart + (dUpperLimit - dLowerLimit) / dIncrement
    
    End If
  
End Function
Function MB_S_ShapeCurve(dStart As Double, dMax As Double, dTimeToMax As Double, dLag As Double, vLaunch As Variant, vTime As Variant, dInterval As Double) As Double
  
    ' Developed by Living Analytics, LLC, 2009
    
    Dim dLaunch As Double, dTime As Double, dIncrement As Double, dCon As Double, dSlo As Double
    Dim dLower As Double, dUpper As Double, dLowerLimit As Double, dUpperLimit As Double
    
    dLaunch = MB_TimeIndex(vLaunch)  ' Convert time and launch values to double precision values
    dTime = MB_TimeIndex(vTime)
    
    If dTimeToMax = dLag Or dTimeToMax = 0 Then
        If dTimeToMax < 0 Then dTimeToMax = 0
        MB_S_ShapeCurve = MB_StepFunction(dStart, dMax, dLaunch + dTimeToMax, dTime, dInterval)
        Exit Function
    End If
    
    
    If dInterval = 0 Then ' Test for integral: if dInterval=0, the curve is evaluated at a point
        If dTime < dLaunch Then ' Evaluate the curve at a point
            MB_S_ShapeCurve = 0
        Else
            dCon = 1 / (1 - dLag / dTimeToMax) * Log((1 / 0.15 - 1) / ((1 / 0.98 - 1) ^ (dLag / dTimeToMax)))
            dSlo = 1 / dTimeToMax * (Log(1 / 0.98 - 1) - dCon)
            MB_S_ShapeCurve = dMax / (1 + Exp(dCon + dSlo * (dTime - dLaunch)))
        End If
    Else
        dIncrement = MB_TimeIncrement(dInterval, dLaunch)
        dLower = Application.Max(dTime, dLaunch)  ' Evaluate the integral
        dUpper = Application.Max(dTime + dIncrement, dLaunch)
        dCon = 1 / (1 - dLag / dTimeToMax) * Log((1 / 0.15 - 1) / ((1 / 0.98 - 1) ^ (dLag / dTimeToMax)))
        dSlo = 1 / dTimeToMax * (Log(1 / 0.98 - 1) - dCon)
        dLowerLimit = (dMax - dStart) / dSlo * ((dCon + dSlo * (dLower - dLaunch)) - Log(1 + Exp(dCon + dSlo * (dLower - dLaunch))))
        dUpperLimit = (dMax - dStart) / dSlo * ((dCon + dSlo * (dUpper - dLaunch)) - Log(1 + Exp(dCon + dSlo * (dUpper - dLaunch))))
        
        MB_S_ShapeCurve = dStart + (dUpperLimit - dLowerLimit) / dIncrement
        
    End If
  
End Function

Function MB_TimeIndex(vTime As Variant) As Double
  
  If IsDate(vTime) Then
    'MB_TimeIndex = CDbl(Year(vTime) + (Month(vTime) - 1) / 12 + (Day(vTime) - 1) / 365)
    MB_TimeIndex = CDbl(vTime)
  Else
    If IsNumeric(vTime) Then
      MB_TimeIndex = CDbl(vTime)
    Else
        MB_TimeIndex = 1 / 0
    End If
  End If
End Function

Function MB_TimeIncrement(dInterval As Double, dLaunch As Double) As Double

    Select Case dInterval
        Case 1
            'If the interval is Year, then the increment is 1
            MB_TimeIncrement = 1
        Case 4
            'If the interval is Quarters, then the increment is 3, since there are 3 months in a Quarter
            MB_TimeIncrement = 3
        Case 12
            'If the increment is Months, then determine the exact number of days in the month of launch
            MB_TimeIncrement = Day(DateSerial(Year(dLaunch), Month(dLaunch) + 1, 1) - 1)
        Case Else
    End Select

End Function

Function MB_StepFunction(dStart As Double, dEnd As Double, dLaunch As Double, dTimeNow As Double, dInterval As Double) As Double
  Dim intCase As Integer
  
  If dTimeNow + dInterval <= dLaunch Then intCase = 1  ' Entire interval is before launch
  If dTimeNow >= dLaunch Then intCase = 2                ' Entire interval is after launch
  
  Select Case intCase
  Case 1
    MB_StepFunction = dStart * dInterval
  Case 2
    MB_StepFunction = dEnd * dInterval
  Case Else
    Dim dWeight As Double
    dWeight = (dLaunch - dTimeNow) / dInterval
    MB_StepFunction = dWeight * dStart + (1 - dWeight) * dEnd
  End Select
End Function


Function P_MB_Transition(dType As Double, dStart As Double, dMax As Double, dTimeToMax As Double, vTimeInLag As Variant, _
    vLaunch As Variant, vTime As Variant, dInterval As Double, dTypeofForecast As String) As Variant
    
On Error GoTo ErrFound
    Dim intLoop As Integer
    Dim dDay_1 As Variant, dMonth_1 As Variant, dYear_1 As Variant
    If dTypeofForecast = "Yearly" Then
        P_MB_Transition = 0
        P_MB_Transition = MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -1, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -2, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -3, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -4, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -5, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -6, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -7, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -8, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -9, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -10, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -11, vTime), dInterval)
        P_MB_Transition = P_MB_Transition / 12
    ElseIf dTypeofForecast = "Quarterly" Then
        P_MB_Transition = 0
        P_MB_Transition = MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -1, vTime), dInterval)
        P_MB_Transition = P_MB_Transition + MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, DateAdd("M", -2, vTime), dInterval)
        P_MB_Transition = P_MB_Transition / 3
    Else
        P_MB_Transition = MB_Transition(dType, dStart, dMax, dTimeToMax, vTimeInLag, vLaunch, vTime, dInterval)
    End If
    Exit Function
ErrFound:
    P_MB_Transition = 0
End Function



