Attribute VB_Name = "mod_format"
Option Explicit

Function Copy_Paste_Values(rngFrom As Range, rngTo As Range)
    rngFrom.Copy
    rngTo.PasteSpecial xlPasteValues
    Application.CutCopyMode = False
End Function

'Function Copy_Paste_Values(rngFrom As Range, rngTo As Range)
'    rngTo.Value = rngFrom.Value
'End Function

Sub Apply_Master_POS() 'For Probability of Success

    With wks_Forecast
        .Range("G153:NB153").Value = .Range("E153").Value
    End With
    
End Sub

Sub Apply_Master_GTN() 'For GTN

    With wks_Forecast
        .Range("G156:NB156").Value = .Range("E156").Value
    End With
    
End Sub

Sub Apply_Master_Split() 'For Split

    With wks_Forecast
        .Range("G172:NB186").Value = .Range("E172:E186").Value
    End With
    
End Sub

Sub Apply_Master_SKUprice() 'For SKUprice

    With wks_Forecast
        .Range("G206:NB220").Value = .Range("E206:E220").Value
    End With
    
End Sub

Sub Apply_Master_GTN2() 'For GTN2

    With wks_Forecast
        .Range("G223:NB237").Value = .Range("E223:E237").Value
    End With
    
End Sub

Sub Apply_Master_PreviousGNT() 'For Previous GTN

    With wks_Forecast
        .Range("G223:NB237").Value = .Range("G156").Value
    End With
    
End Sub

Function Projection_Trend()
Dim intRng As String, intI As Integer, intComp As Integer
Call Application_Events_Handler(False)
intRng = 9 + wks_Vars.Range("N2").Value
intComp = wks_M_List.Range("K" & intRng).Value
    
         With wks_Trending
            .Shapes("shpMaster16").Top = .Range("F332").Top
            .Activate
            .Range("A13:A70").EntireRow.Hidden = True
                        
            .Range("A13:A" & intComp + 13).EntireRow.Hidden = False
            .Range("A29:A32").EntireRow.Hidden = False
            .Range("A33:A" & intComp + 33).EntireRow.Hidden = False
            .Range("A50:A50").EntireRow.Hidden = False
            .Range("A51:A" & intComp + 51).EntireRow.Hidden = False
            .Range("A67:A70").EntireRow.Hidden = False
            .Range("F34:F48").Formula = "=IF(F14="""","""",F14)"
             
            If wks_M_List.Range("D" & intRng).Value = "Inline" Then
                .Range("A89:A326").EntireRow.Hidden = True
                .Range("A72:A88").EntireRow.Hidden = True
                wks_Trending.Shapes("Txt_trend31").Visible = True
                wks_Trending.Shapes("DD_Trend31").Visible = True
                
                wks_Trending.Shapes("Txt_trend32").Visible = True
                wks_Trending.Shapes("DD_Trend32").Visible = True
                wks_Trending.Shapes("shp_RefreshTrend").Visible = True
                
                For intI = 334 To 341
                    If wks_Trending.Range("E" & intI).Value = True Then
                        wks_Trending.Range("G343:NB343").Value = .Range("G" & intI & ":NB" & intI).Value
                        Exit For
                    End If
                Next intI
            ElseIf wks_M_List.Range("D" & intRng).Value = "Pipeline" Then
                .Range("A72:A326").EntireRow.Hidden = True
                .Range("A69:A70").EntireRow.Hidden = True
            End If
        End With
    
    Call Trend_Type16_new
    With wks_Trending
        .Range(wks_Vars.Range("L4").Value & 1 & ":NB1").EntireColumn.Hidden = True
        .Activate
    End With
Call Application_Events_Handler(True)
wks_Trending.Range("C10").Select
wks_Trending.Range("C12").Select
End Function

Function Events_Erosion()
''    wks_Event_After.Activate
End Function

Sub Apply_Master_Trend() 'For Trend
''    With wks_Trends
''        .Range("G16:NB16").Value = .Range("E16").Value
''    End With
End Sub

Function Forecast_Activate()
    wks_Forecast.Activate
End Function

Function Save_ContinueEvents()        'For Events
Dim intRang As Integer, intI As Integer
Call Application_Events_Handler(False)
intRang = 9 + wks_Vars.Range("N2").Value
        Call Copy_Paste_Values(wks_Trending.Range("G349:" & wks_Vars.Range("K4").Value & "349"), wks_Forecast.Range("G91:" & wks_Vars.Range("K4").Value & "91"))
    ''        wks_Forecast.Range("G110:NB110").Value = wks_Trending.Range("G370:NB370").Value
        wks_Forecast.Activate
'    End If
Call Application_Events_Handler(True)
End Function

Function Save_Continue()            'For Trend
''Dim intRng As Integer, intI As Integer
''intRng = 9 + wks_Vars.Range("N2").Value
''    wks_M_List.Range("E" & intRng).Value = wks_Trends.Range("F11").Value
''        If wks_Vars.Range("N26").Value = 1 Then
''            wks_Forecast.Range("G110:NB110").Value = wks_Trending.Range("G79:NB79").Value
''        Else
''            For intI = 79 To 86
''                If wks_Trending.Range("E" & intI).Value = True Then
''                    Call Copy_Paste_Values(wks_Trends.Range("G" & intI & ":NB" & intI), wks_Forecast.Range("G110:NB110"))
''''                    wks_Forecast.Range("G92:NB92").Value = wks_Trends.Range("G" & intI & ":NB" & intI).Value
''                End If
''            Next intI
''        End If
''        Call Copy_Paste_Values(wks_Trending.Range("G364:NB368"), wks_Trending.Range("G364:NB368"))
''        Call Copy_Paste_Values(wks_Trending.Range("G370:NB370"), wks_Forecast.Range("G110:NB110"))
''''        wks_Trending.Range("G364:NB368").Value = wks_Trending.Range("G364:NB368").Value
''''        wks_Forecast.Range("G110:NB110").Value = wks_Trending.Range("G370:NB370").Value
''    wks_Forecast.Activate
End Function

Function Trends_ApplyCurve_Formula()
'Apply_Curve($G$10:$CC$10,Generic_Forecast!$G$65:$CC$65,G$9,$F19)
''    wks_Trends.Range("G18:NB24").Formula = "=Apply_Curve($G$10:$" & wks_Vars.Range("K2").Value & "10,Generic_Forecast!$G$65:$" & wks_Vars.Range("K2").Value & "65,G$9,$F19)"
''    Call Copy_Paste_Values(wks_Trends.Range("G18:NB24"), wks_Trends.Range("G18:NB24"))
''    wks_Trends.Range("G18:NB24").Value = wks_Trends.Range("G18:NB24").Value
End Function

Function Data_Clear()
    With wks_Forecast
        .Range("F14:NB28").ClearContents
        .Range("G32:NB46").ClearContents
        .Range("G70:NB84").ClearContents
        .Range("G113:K113").ClearContents
        .Range("G91:NB91").ClearContents
        .Range("G150:NB150").ClearContents
        .Range("G153:NB153").ClearContents
        .Range("G156:NB156").ClearContents
        .Range("G172:NB186").ClearContents
        .Range("F172:F186").ClearContents
        .Range("G206:NB220").ClearContents
        .Range("F121:M130").ClearContents
        .Range("G241:NB244").ClearContents
        
        .Range("G70:NB85").ClearContents
        .Range("G65:NB65").ClearContents
        .Range("F50:NB65").ClearContents
        .Range("F50:NB64").ClearContents
        .Range("G29:NB29").ClearContents
        .Range("G47:NB47").ClearContents
        .Range("G85:NB85").ClearContents
        
        .Range("G95:M99").ClearContents
    End With
    
    wks_Trending.Range("G357:M361").ClearContents
    wks_Trending.Range("G34:NB48").ClearContents
    wks_Trending.Range("G333:NB341").ClearContents
    wks_Trending.Range("G347:NB347").ClearContents
    
    wks_Price.Range("G41:NB41").ClearContents
    
    wks_Events.Range("A2:XA100000").Clear
    wks_Backup_Data.Range("A2:RT100000").Clear
    wks_Historical.Range("A2:RT100000").Clear
    wks_PackData.Range("A2:RT100000").Clear
    wks_Vars.Range("A26:D41").Clear
    
    wks_Penetration_Type.Range("A2:RY2000").Clear
    wks_Assumptions.Range("A2:E2000").Clear
    wks_Indication.Range("A2:A500").Clear
    wks_Scenario.Range("A2:B6").Clear
    wks_NewSKU.Range("A2:C2000").Clear
    
    With wks_Consolidator
        .Range("H15:ABF4444").Clear
    End With
    
    wks_M_List.Range("B2:L59").ClearContents
    wks_SKU_info.Range("B2:AY16").ClearContents
    
    wks_ProjectDetails.Range("A2:L2").ClearContents
    wks_Product_Details.Range("A2:J100").ClearContents
End Function

Function Event_Erosion()
    Dim intRng As Integer, intCell As Integer
    Call Application_Events_Handler(False)
    With wks_Forecast
    intCell = 9 + wks_Vars.Range("N2").Value
    intRng = wks_Vars.Range("Q7").Value - 1
        .Range("A94:A108").EntireRow.Hidden = True
'        .Shapes("shp_Show_Evented_Units").Visible = msoFalse
'        .Shapes("TrendChart_events").Visible = msoFalse
            If intRng <> 0 Then
'                .Shapes("shp_Show_Evented_Units").Visible = msoTrue
                .Range("A94:A" & intRng + 94).EntireRow.Hidden = False
                .Range("A102:A" & intRng + 101).EntireRow.Hidden = False
                .Range("A100:A101").EntireRow.Hidden = False
                .Range("F95").Value = "Brand Event"
                .Range("F96").Value = "Generic Erosion"
                .Range("A107:A108").EntireRow.Hidden = False
                If wks_M_List.Range("G" & intCell).Value = "Market" Then
                    .Range("G102:NB106").Formula = "=IF($G95=""On"",IF(Generic_Forecast!G$10<$L95,0,P_MB_Transition($I95,$J95,$K95,$M95*24,,$L95,Generic_Forecast!G$10,12,""Monthly"")),0)*IF($H95=""Positive"",1,-1)"
                End If
                .Range("G102:NB106").Formula = "=IF($G95=""On"",IF(Generic_Forecast!G$10<$L95,0,P_MB_Transition($I95,$J95,$K95,$M95*24,,$L95,Generic_Forecast!G$10,12,""Monthly"")),0)*IF($H95=""Positive"",1,-1)"
    '            .Range("G364:NB368").Value = .Range("G364:NB368").Value
            End If
    End With
   Call Application_Events_Handler(True)
End Function
Function Event_Erosion_actual()
    Dim intRng As Integer, intCell As Integer
'    Call Application_Events_Handler(False)
    With wks_Forecast
    intCell = 9 + wks_Vars.Range("N2").Value
    intRng = wks_Vars.Range("Q7").Value - 1
        .Range("A94:A108").EntireRow.Hidden = True
'        .Shapes("shp_Show_Evented_Units").Visible = msoFalse
'        .Shapes("TrendChart_events").Visible = msoFalse
            If intRng <> 0 Then
'                .Shapes("shp_Show_Evented_Units").Visible = msoTrue
                .Range("A94:A" & intRng + 94).EntireRow.Hidden = False
                .Range("A102:A" & intRng + 101).EntireRow.Hidden = False
                .Range("A100:A101").EntireRow.Hidden = False
                .Range("F95").Value = "Brand Event"
                .Range("F96").Value = "Generic Erosion"
                .Range("A107:A108").EntireRow.Hidden = False
                If wks_M_List.Range("G" & intCell).Value = "Market" Then
                    .Range("G102:NB106").Formula = "=IF($G95=""On"",IF(Generic_Forecast!G$10<$L95,0,P_MB_Transition($I95,$J95,$K95,$M95*24,,$L95,Generic_Forecast!G$10,12,""Monthly"")),0)*IF($H95=""Positive"",1,-1)"
                End If
                .Range("G102:NB106").Formula = "=IF($G95=""On"",IF(Generic_Forecast!G$10<$L95,0,P_MB_Transition($I95,$J95,$K95,$M95*24,,$L95,Generic_Forecast!G$10,12,""Monthly"")),0)*IF($H95=""Positive"",1,-1)"
    '            .Range("G364:NB368").Value = .Range("G364:NB368").Value
            End If
    End With
'   Call Application_Events_Handler(True)
End Function

Function No_Events()
    Dim intRng As Integer
    Application.ScreenUpdating = False
    intRng = wks_Vars.Range("Q8").Value - 1
        wks_Forecast.Range("A119:A144").EntireRow.Hidden = True
        If intRng <> 0 Then
            wks_Forecast.Range("A119:A" & intRng + 120).EntireRow.Hidden = False
            wks_Forecast.Range("A131:A" & intRng + 132).EntireRow.Hidden = False
            wks_Forecast.Range("A143:A146").EntireRow.Hidden = False
        ElseIf intRng = 0 Then
            wks_Forecast.Range("A143:A144").EntireRow.Hidden = True
    ''        wks_Forecast.Range("A145:A145").EntireRow.Hidden = True
        End If
    Application.ScreenUpdating = True
End Function
Function No_Events_Actual()
    Dim intRng As Integer
'    Application.ScreenUpdating = False
    intRng = wks_Vars.Range("Q8").Value - 1
        wks_Forecast.Range("A119:A144").EntireRow.Hidden = True
        If intRng <> 0 Then
            wks_Forecast.Range("A119:A" & intRng + 120).EntireRow.Hidden = False
            wks_Forecast.Range("A131:A" & intRng + 132).EntireRow.Hidden = False
            wks_Forecast.Range("A143:A146").EntireRow.Hidden = False
        ElseIf intRng = 0 Then
            wks_Forecast.Range("A143:A144").EntireRow.Hidden = True
    ''        wks_Forecast.Range("A145:A145").EntireRow.Hidden = True
        End If
'    Application.ScreenUpdating = True
End Function

Function No_Packs()
    Dim intRng2 As Integer
    Application.ScreenUpdating = False
    intRng2 = wks_Vars.Range("Q9").Value - 1
      wks_Forecast.Range("A170:A260").EntireRow.Hidden = True
    If intRng2 > 0 Then
        With wks_Forecast
            .Range("A170:A" & intRng2 + 171).EntireRow.Hidden = False
            .Range("A187:A" & intRng2 + 188).EntireRow.Hidden = False
            .Range("A204:A" & intRng2 + 205).EntireRow.Hidden = False
            .Range("A221:A" & intRng2 + 222).EntireRow.Hidden = False
            .Range("A238:A" & intRng2 + 239).EntireRow.Hidden = False
             wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = msoCTrue
             wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = msoFalse
              wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = msoFalse
            .Range("G240:NB254").Formula = "=G223*G206*G189"
            .Range("F206:F220").Formula = "=F189"
            .Range("F223:F237").Formula = "=F206"
            .Range("F240:F254").Formula = "=F223"
        End With
    Else
        wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = msoFalse
        wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = msoFalse
        wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = msoFalse
        wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = msoFalse
    End If
    Application.ScreenUpdating = True
End Function
Function No_Packs_Actual()
    Dim intRng2 As Integer
'    Application.ScreenUpdating = False
    intRng2 = wks_Vars.Range("Q9").Value - 1
      wks_Forecast.Range("A170:A260").EntireRow.Hidden = True
      If intRng2 > 0 Then
        With wks_Forecast
            .Range("A170:A" & intRng2 + 171).EntireRow.Hidden = False
            .Range("A187:A" & intRng2 + 188).EntireRow.Hidden = False
            .Range("A204:A" & intRng2 + 205).EntireRow.Hidden = False
            .Range("A221:A" & intRng2 + 222).EntireRow.Hidden = False
            .Range("A238:A" & intRng2 + 239).EntireRow.Hidden = False
             wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = msoTrue
             wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = msoFalse
              wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = msoFalse
            .Range("G240:NB254").Formula = "=G223*G206*G189"
            .Range("F206:F220").Formula = "=F189"
            .Range("F223:F237").Formula = "=F206"
            .Range("F240:F254").Formula = "=F223"
        End With
       End If
'    Application.ScreenUpdating = True
End Function


