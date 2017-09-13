Attribute VB_Name = "mod_Vars"
Option Explicit

Function mod_Vars_Code()
    Dim intProduct As Integer
    Dim intSKU As Integer
    Dim intScenario As Integer
    Dim intRow As Integer
    Dim intLoop As Integer
    
    wks_Vars1.Range("A2:H1000").Clear
    
    intRow = 2
    For intProduct = 1 To wks_ProjectDetails.Range("J2").Value
        For intSKU = 1 To wks_Product_Details.Range("G" & intProduct + 1).Value
            For intScenario = 1 To wks_ProjectDetails.Range("K2").Value
                wks_Vars1.Range("B" & intRow).Value = wks_Product_Details.Range("A" & intProduct + 1).Value
                If wks_SKU_info.Cells(intSKU + 1, intProduct + 1).Value = "" Then
                    wks_Vars1.Range("C" & intRow).Value = "All"
                Else
                    wks_Vars1.Range("C" & intRow).Value = wks_SKU_info.Cells(intSKU + 1, intProduct + 1).Value
                End If
                wks_Vars1.Range("D" & intRow).Value = wks_Scenario.Range("B" & intScenario + 1).Value
                intRow = intRow + 1
            Next intScenario
        Next intSKU
    Next intProduct
    intRow = Application.WorksheetFunction.CountA(wks_Vars1.Range("B:B"))
    With wks_Vars1.Range("A2:A" & intRow)
        .Formula = "=B2&D2&C2"
        .Value = .Value
    End With
    
    With wks_Penetration_Type
        .Range("A2:A" & intRow).Value = wks_Vars1.Range("A2:A" & intRow).Value
        .Range("RU2:RW" & intRow).Value = wks_Vars1.Range("B2:D" & intRow).Value
    End With
    With wks_Assumptions
        .Range("A2:C" & intRow).Value = wks_Vars1.Range("B2:D" & intRow).Value
    End With
    
    With wks_Vars1.Range("E2:E" & intRow)
        .Formula = "=79*(ROW()-2)+2"
        .Value = .Value
    End With
    With wks_Vars1.Range("F2:F" & intRow)
        .Formula = "=16*(ROW()-2)+2"
        .Value = .Value
    End With
    With wks_Vars1.Range("G2:G" & intRow)
        .Formula = "=45*(ROW()-2)+2"
        .Value = .Value
    End With
    With wks_Vars1.Range("H2:H" & intRow)
        .Formula = "=16*(ROW()-2)+2"
        .Value = .Value
    End With
End Function

