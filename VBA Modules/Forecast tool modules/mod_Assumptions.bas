Attribute VB_Name = "mod_Assumptions"
Option Explicit

Function Forecast_Assumptions()
Call Application_Events_Handler(False)
    Call Product_Assumptions
Call Application_Events_Handler(True)
End Function
Function Ass_Drp_Down_Fill()
    Dim intLoop As Integer
    wks_forecast_Ass.Shapes("Ass_Drp_Down").Visible = msoTrue
    With wks_forecast_Ass.Shapes("Ass_Drp_Down").ControlFormat
        .RemoveAllItems
        For intLoop = 10 To wks_M_List.Range("C9").Value + 9
            If wks_M_List.Range("B" & intLoop).Value <> 0 Then
                .AddItem wks_M_List.Range("B" & intLoop).Value
            End If
        Next intLoop
        .LinkedCell = "Vars!$BL$3"
        .DropDownLines = 20
        wks_Vars.Range("BL3").Value = 1
    End With
End Function
Function Product_Assumptions()
    Dim intLoop As Integer
    Dim intRow As Integer
    wks_forecast_Ass.Range("E9:G25").ClearContents
    
    With wks_PL_Summary
        .Cells.Clear
        .Range("C4").Value = "Sections"
        .Range("D4").Value = "Scenario"
        wks_Forecast.Range("G10:IZ10").Copy
        .Range("E4").PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        .Range("E3").Formula = "=YEAR(E4)"
        .Range("E3").Copy
        .Range("E3:IX3").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
       .Range("B11").Value = "Total Market Revenue"
       .Range("B17").Value = "Product Extended Units"
       .Range("B23").Value = "Product Net Revenue"
       .Range("B8").Value = "Available Market Units"
       .Range("B26").Value = "WAC Price"
       .Range("C29").Value = "Market Units"
       .Range("C32").Value = "Market TRx"
    
       wks_Vars.Range("BM3:BN23").Copy
       .Range("C5").PasteSpecial xlPasteValues
       Application.CutCopyMode = False
       .Range("JZ4").Formula = "=Vars!$N$6"
       .Range("JY4").Formula = "=DATE(YEAR(JZ4),MONTH(JZ4)-1,DAY(JZ4))"
       .Range("JY4").Copy
       .Range("JX4:JO4").PasteSpecial xlPasteFormulas
       Application.CutCopyMode = False
       .Range("D5:D16").Copy
       .Range("D26").PasteSpecial xlPasteAll
       Application.CutCopyMode = False
    For intLoop = 1 To 20
        If wks_Vars.Range("BL3").Value = intLoop Then
            .Range("A5").Value = wks_Product_Details.Range("A" & intLoop + 1).Value
        End If
    Next intLoop
        .Range("E5").Formula = "=SUMIFS(ForecastData!C,ForecastData!C1,R5C1,ForecastData!C4,R5C3,ForecastData!C3,RC4)"
        .Range("E5").Copy
        .Range("E5:IX7").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E8").FormulaR1C1 = "=SUMIFS(ForecastData!C,ForecastData!C1,R5C1,ForecastData!C4,R8C2,ForecastData!C3,RC4)"
        .Range("E8").Copy
        .Range("E8:IX10").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E11").Formula = "=SUMIFS(HistoricalData!C[1],HistoricalData!C1,R5C1,HistoricalData!C3,RC4,HistoricalData!C5,R11C2)"
        .Range("E11").Copy
        .Range("E11:IX13").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E14").Formula = "=IFERROR(E17/E8,0)"
        .Range("E14").Copy
        .Range("E14:IX16").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E17").Formula = "=SUMIFS(ForecastData!C,ForecastData!C1,R5C1,ForecastData!C4,R17C2,ForecastData!C3,RC4)"
        .Range("E17").Copy
        .Range("E17:IX19").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E20").Formula = "=IFERROR(E23/E17,0)"
        .Range("E20").Copy
        .Range("E20:IX22").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E23").Formula = "=SUMIFS(ForecastData!C,ForecastData!C1,R5C1,ForecastData!C4,R23C2,ForecastData!C3,RC4)"
        .Range("E23").Copy
        .Range("E23:IX25").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E26").FormulaR1C1 = "=SUMIFS(ForecastData!C,ForecastData!C1,R5C1,ForecastData!C4,R26C2,ForecastData!C3,RC4)"
        .Range("E26").Copy
        .Range("E26:IX28").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
''        .Range("E5:IX25").Copy
''        .Range("E5:IX25").PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
        .Range("E5:IX34").NumberFormat = "0,0.0"
        
        .Range("A29").FormulaR1C1 = "=MATCH(R5C1,HistoricalData!C1,0)"
        .Range("A29").Font.Color = RGB(255, 255, 255)
        .Range("B29").Value = wks_Historical.Range("E" & wks_PL_Summary.Range("A29") + 32).Value
        .Range("E29").FormulaR1C1 = "=SUMIFS(HistoricalData!C[1],HistoricalData!C1,R5C1,HistoricalData!C4,R29C3,HistoricalData!C5,R29C2,HistoricalData!C3,RC4)"
        .Range("E29").Copy
        .Range("E29:IX31").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        .Range("E32").FormulaR1C1 = "=SUMIFS(HistoricalData!C[1],HistoricalData!C1,R5C1,HistoricalData!C4,R32C3,HistoricalData!C5,R29C2,HistoricalData!C3,RC4)"
        .Range("E32").Copy
        .Range("E32:IX34").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("JO5").Formula = "=HLOOKUP(JO$4,$C$4:$IX$34,2,0)"
        .Range("JO5").Copy
        .Range("JO5:JZ7").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
'        .Range("JO5:JZ7").Copy
'        .Range("JO5:JZ7").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("JO10").Formula = "=HLOOKUP(JO$4,$C$4:$IX$34,8,0)"
        .Range("JO10").Copy
        .Range("JO10:JZ10").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
'        .Range("JO10:JZ10").Value = .Range("JO10:JZ10").Value
        .Range("JO5:JZ14").NumberFormat = "0,0.0"
        .Range("JO12").Formula = "=HLOOKUP(JO$4,$C$4:$IX$34,26,0)"
        .Range("JO12").Copy
        .Range("JO12:JZ12").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("JO14").Formula = "=HLOOKUP(JO$4,$C$4:$IX$34,29,0)"
        .Range("JO14").Copy
        .Range("JO14:JZ14").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("KC5").Formula = "=SUM($JO$5:$JZ$5)/10^6"
        .Range("KC14").Formula = "=SUM($JO$14:$JZ$14)/10^6"
        .Range("E45").Formula = "=E3"
        .Range("F45").Formula = "=E45+1"
        .Range("F45").Copy
        .Range("G45:Z45").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("C4:D25").Copy
        .Range("C45").PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        
        .Range("E46").Formula = "=SUMIF($E$3:$IX$3,E$30,$E5:$IX5)"
        .Range("E46").Copy
        .Range("E46:Z60").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E64").Formula = "=SUMIF($E$3:$IX$3,E$30,$E23:$IX23)"
        .Range("E64").Copy
        .Range("E64:Z75").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("E61").Formula = "=IFERROR(E49/E43,0)"
        .Range("E61").Copy
        .Range("E61:Z63").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Range("D5:D25").Copy
        .Range("JK7").PasteSpecial xlPasteValues
        .Range("JK28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("C67").Value = "WAC Price"
        .Range("C70").Value = .Range("B29").Value
        .Range("D46:D60").Copy
        .Range("D67").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("JI5").Value = "Generic Erosion"
        .Range("JI6").Value = "Penetration"
        
        For intLoop = 2 To wks_Vars.Range("BK5").Value
            If wks_Events.Range("A" & intLoop).Value = wks_PL_Summary.Range("A5").Value And wks_Events.Range("E" & intLoop).Value = wks_PL_Summary.Range("JI5").Value Then
                wks_PL_Summary.Range("JJ5").Value = wks_Events.Range("K" & intLoop).Value
            End If
            If wks_Events.Range("A" & intLoop).Value = wks_PL_Summary.Range("A5").Value And wks_Events.Range("E" & intLoop).Value = wks_PL_Summary.Range("JI6").Value Then
                wks_PL_Summary.Range("JJ6").Value = wks_Events.Range("K" & intLoop).Value
            End If
        Next intLoop
        .Range("JJ7").FormulaR1C1 = "=SUMIFS(ForecastEvents!C10,ForecastEvents!C1,R5C1,ForecastEvents!C5,PL_MonthlySummary!R6C269,ForecastEvents!C3,RC271)"
        .Range("JJ7").Copy
        .Range("JJ7:JJ9").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        
        .Range("KC10").Formula = "=SUM($JO$10:$JZ$10)/10^6"
        .Range("KC12").Formula = "=SUM($JO$12:$JZ$12)/10^6"
        .Range("JJ10").Formula = "=IFERROR(Z43/Z34,0)"
        .Range("JJ11").Formula = "=IFERROR(Z44/Z35,0)"
        .Range("JJ12").Formula = "=IFERROR(Z45/Z36,0)"
        
        .Range("JI13").Value = "Net Price@Launch"
        .Range("JJ13").FormulaR1C1 = "=IFERROR(HLOOKUP(R6C270,R4C3:R34C258,17,0),0)"
        .Range("JJ14").FormulaR1C1 = "=IFERROR(HLOOKUP(R6C270,R4C3:R34C258,18,0),0)"
        .Range("JJ15").FormulaR1C1 = "=IFERROR(HLOOKUP(R6C270,R4C3:R34C258,19,0),0)"
        
        .Range("JI16").Value = "Net Price@Peak"
        .Range("JJ16").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,17,0),0)"
        .Range("JJ17").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,18,0),0)"
        .Range("JJ18").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,19,0),0)"
        
        .Range("JI19").Value = "Net Sales@Peak"
        .Range("JI22").Value = "Generic Market Volume"
        .Range("JI25").Value = "Company Volume"
        .Range("JI28").Value = "WAC Price@2016"
        .Range("JI31").Value = "WAC Price@Launch"
        .Range("JJ19").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,20,0)/10^6,0)"
        .Range("JJ20").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,21,0)/10^6,0)"
        .Range("JJ21").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,22,0)/10^6,0)"
        .Range("JJ22").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,5,0)/10^6,0)"
        .Range("JJ23").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,6,0)/10^6,0)"
        .Range("JJ24").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,7,0)/10^6,0)"
        .Range("JJ25").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,14,0)/10^6,0)"
        .Range("JJ26").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,15,0)/10^6,0)"
        .Range("JJ27").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270)+1,R45C3:R69C26,16,0)/10^6,0)"
        .Range("JJ28").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R5C270),R45C3:R69C26,23,0),0)"
        .Range("JJ29").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R5C270),R45C3:R69C26,24,0),0)"
        .Range("JJ30").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R5C270),R45C3:R69C26,25,0),0)"
        .Range("JJ31").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270),R45C3:R69C26,23,0),0)"
        .Range("JJ32").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270),R45C3:R69C26,24,0),0)"
        .Range("JJ33").FormulaR1C1 = "=IFERROR(HLOOKUP(YEAR(R6C270),R45C3:R69C26,25,0),0)"
        .Range("JJ34").Formula = "=IFERROR(HLOOKUP(YEAR($JJ$5),$C$45:$Z$69,17,0),0)"
        .Range("JJ35").Formula = "=IFERROR(HLOOKUP(YEAR($JJ$5),$C$45:$Z$69,18,0),0)"
        .Range("JJ36").Formula = "=IFERROR(HLOOKUP(YEAR($JJ$5),$C$45:$Z$69,19,0),0)"
    End With
    Call Put_Values_Ass
    Call Hide_Unhide_Ass
    wks_forecast_Ass.Activate
End Function
Function Put_Values_Ass()
    With wks_forecast_Ass
        .Range("F9").Value = Format(wks_PL_Summary.Range("KC5").Value, "#,##0.0") & " M"
        .Range("F10").Value = Format(wks_PL_Summary.Range("KC14").Value, "#,##0.0") & " M"
        .Range("F11").Value = Format(wks_PL_Summary.Range("KC12").Value, "$ #,##0.0") & " M"
        .Range("F12").Value = Format(wks_PL_Summary.Range("KC10").Value, "$ #,##0.0") & " M"
        .Range("E18").Value = Format(wks_PL_Summary.Range("JJ8").Value / 100, "0.00%")
        .Range("F18").Value = Format(wks_PL_Summary.Range("JJ7").Value / 100, "0.00%")
        .Range("G18").Value = Format(wks_PL_Summary.Range("JJ9").Value / 100, "0.00%")
        .Range("E19").Value = Format(wks_PL_Summary.Range("JJ11").Value / 100, "0.00%")
        .Range("F19").Value = Format(wks_PL_Summary.Range("JJ10").Value / 100, "0.00%")
        .Range("G19").Value = Format(wks_PL_Summary.Range("JJ12").Value / 100, "0.00%")
        .Range("E13:G14").Value = wks_PL_Summary.Range("JJ5").Value
        .Range("E17:G17").Value = wks_PL_Summary.Range("JJ6").Value
        .Range("E26").Value = Format(wks_PL_Summary.Range("JJ14").Value, "$ #,##0.00")
        .Range("F26").Value = Format(wks_PL_Summary.Range("JJ13").Value, "$ #,##0.00")
        .Range("G26").Value = Format(wks_PL_Summary.Range("JJ15").Value, "$ #,##0.00")
        .Range("E27").Value = Format(wks_PL_Summary.Range("JJ17").Value, "$ #,##0.00")
        .Range("F27").Value = Format(wks_PL_Summary.Range("JJ16").Value, "$ #,##0.00")
        .Range("G27").Value = Format(wks_PL_Summary.Range("JJ18").Value, "$ #,##0.00")
        .Range("E28").Value = Format(wks_PL_Summary.Range("JJ20").Value, "$ #,##0.00") & " M"
        .Range("F28").Value = Format(wks_PL_Summary.Range("JJ19").Value, "$ #,##0.00") & " M"
        .Range("G28").Value = Format(wks_PL_Summary.Range("JJ21").Value, "$ #,##0.00") & " M"
        .Range("E16").Value = Format(wks_PL_Summary.Range("JJ23").Value, "#,##0.00") & " M"
        .Range("F16").Value = Format(wks_PL_Summary.Range("JJ22").Value, "#,##0.00") & " M"
        .Range("G16").Value = Format(wks_PL_Summary.Range("JJ24").Value, "#,##0.00") & " M"
        .Range("E20").Value = Format(wks_PL_Summary.Range("JJ26").Value, "#,##0.00") & " M"
        .Range("F20").Value = Format(wks_PL_Summary.Range("JJ25").Value, "#,##0.00") & " M"
        .Range("G20").Value = Format(wks_PL_Summary.Range("JJ27").Value, "#,##0.00") & " M"
        .Range("E22").Value = Format(wks_PL_Summary.Range("JJ29").Value, "$ #,##0.00")
        .Range("F22").Value = Format(wks_PL_Summary.Range("JJ28").Value, "$ #,##0.00")
        .Range("G22").Value = Format(wks_PL_Summary.Range("JJ30").Value, "$ #,##0.00")
        .Range("E23").Value = Format(wks_PL_Summary.Range("JJ32").Value, "$ #,##0.00")
        .Range("F23").Value = Format(wks_PL_Summary.Range("JJ31").Value, "$ #,##0.00")
        .Range("G23").Value = Format(wks_PL_Summary.Range("JJ33").Value, "$ #,##0.00")
        .Range("E21").Value = Format(wks_PL_Summary.Range("JJ35").Value, "$ #,##0.00")
        .Range("F21").Value = Format(wks_PL_Summary.Range("JJ34").Value, "$ #,##0.00")
        .Range("G21").Value = Format(wks_PL_Summary.Range("JJ36").Value, "$ #,##0.00")
        
    End With
End Function

Function Hide_Unhide_Ass()
    Dim intLoop As Integer
    wks_forecast_Ass.Range("D9:G28").EntireRow.Hidden = False
    For intLoop = 10 To wks_M_List.Range("C9").Value + 9
        If wks_M_List.Range("B" & intLoop).Value = wks_PL_Summary.Range("A5").Value And wks_M_List.Range("D" & intLoop).Value = "Inline" Then
            wks_forecast_Ass.Range("D9:G28").EntireRow.Hidden = False
        
         ElseIf wks_M_List.Range("B" & intLoop).Value = wks_PL_Summary.Range("A5").Value And wks_M_List.Range("D" & intLoop).Value = "Pipeline" Then
                wks_forecast_Ass.Range("D10:G11").EntireRow.Hidden = True
                wks_forecast_Ass.Range("D21").EntireRow.Hidden = True
        End If
    Next intLoop
End Function








