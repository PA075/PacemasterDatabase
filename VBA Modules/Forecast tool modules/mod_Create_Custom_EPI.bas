Attribute VB_Name = "mod_Create_Custom_EPI"
Option Explicit

Dim intPopIndent As Integer
Dim intPrevIndent As Integer
Dim intDiagIndent As Integer
Dim intTrIndent As Integer
Dim intC1Indent As Integer
Dim intC2Indent As Integer
Dim intC3Indent As Integer
Dim intC4Indent As Integer
Dim intC5Indent As Integer
Dim intC6Indent As Integer

Dim intRow As Integer
Dim intTemp As Integer
Dim intSRow As Integer
Dim intPrevRow As Integer
Dim intDiagRow As Integer
Dim intTrRow As Integer
Dim intC1Row As Integer
Dim intC2Row As Integer
Dim intC3Row As Integer
Dim intC4Row As Integer
Dim intC5Row As Integer
Dim intC6Row As Integer

Dim intEPIRow As Integer

Function New_EPI_Sheet()
    Dim intCtry As Integer
    Dim intPopSegment As Integer
''Call Application_Events_Handler(False)
    With wks_ForecastFlow
        .Range("A10:RR985").Clear
        .Range("A10:RR985").EntireRow.Hidden = False
        .Range("G986:RR1000").Clear
        
        intRow = 10
        intEPIRow = 986
        For intCtry = 1 To 1
            .Range("E" & intRow).Value = wks_S.Range("D9").Value
            .Range("E" & intRow).Font.Bold = True
            intRow = intRow + 1
            'POPULATION
            .Range("F" & intRow).Value = wks_S.Range("D10").Value
            .Range("F" & intRow).IndentLevel = 0
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow)
            intTemp = intRow 'STORING POPULATION ROW
            If wks_S.Range("H10").Value = True And wks_S.Range("F10").Value = False Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
                intEPIRow = intEPIRow + 1
            End If
            intRow = intRow + 2
            If wks_S.Range("F10").Value = True Then
                .Range("F" & intRow & ":F" & intRow + wks_S.Range("G10").Value - 1).Value = wks_S.Range("P9:P" & wks_S.Range("G10").Value + 8).Value
                .Range("F" & intRow & ":F" & intRow + wks_S.Range("G10").Value - 1).IndentLevel = 1
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G10").Value - 1).NumberFormat = "0.0%"
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G10").Value - 1).Interior.Color = RGB(255, 255, 204)
                Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G10").Value - 1)
                intRow = intRow + wks_S.Range("G10").Value + 1
                
                .Range("F" & intRow & ":F" & intRow + wks_S.Range("G10").Value - 1).Value = wks_S.Range("P9:P" & wks_S.Range("G10").Value + 8).Value
                .Range("F" & intRow & ":F" & intRow + wks_S.Range("G10").Value - 1).IndentLevel = 1
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G10").Value - 1).NumberFormat = "#,##0"
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G10").Value - 1).Formula = "=G" & intRow - wks_S.Range("G10").Value - 1 & "*G$" & intTemp & ""
                
                If wks_S.Range("H10").Value = True Then
                    If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G10").Value - 1).Formula = "=G" & intRow
                    intEPIRow = intEPIRow + wks_S.Range("G10").Value
                End If
                
                Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G10").Value - 1)
                intRow = intRow + wks_S.Range("G10").Value + 1
                
                intPrevIndent = 2
                intSRow = intRow - wks_S.Range("G10").Value - 1
                For intPopSegment = 1 To wks_S.Range("G10").Value
                    .Range("F" & intRow).Value = wks_S.Range("P" & intPopSegment + 8).Value
                    .Range("F" & intRow).IndentLevel = 1
                    intRow = intRow + 1
                    Call Prevalence_Rows
                    intSRow = intSRow + 1
                Next intPopSegment
            Else
                intPrevIndent = 0
                intSRow = intTemp
                Call Prevalence_Rows
            End If
        Next intCtry
        .Range("A" & intRow & ":A1000").EntireRow.Hidden = True
        .Activate
    End With
End Function

Function Prevalence_Rows()
    Dim intPrevSegment As Integer
    With wks_ForecastFlow
        'PREVALENCE
        .Range("F" & intRow).Value = wks_S.Range("D11").Value
        .Range("F" & intRow).IndentLevel = intPrevIndent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
        intRow = intRow + 1
        .Range("F" & intRow).Value = wks_S.Range("D11").Value & " - Patients"
        .Range("F" & intRow).IndentLevel = intPrevIndent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intSRow
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
        intTemp = intRow 'STORING PREVALENCE ROW
        If wks_S.Range("H11").Value = True And wks_S.Range("F11").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F11").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G11").Value - 1).Value = wks_S.Range("Q9:Q" & wks_S.Range("G11").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G11").Value - 1).IndentLevel = intPrevIndent + 1
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G11").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G11").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G11").Value - 1)
            intRow = intRow + wks_S.Range("G11").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G11").Value - 1).Value = wks_S.Range("Q9:Q" & wks_S.Range("G11").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G11").Value - 1).IndentLevel = intPrevIndent + 1
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G11").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G11").Value - 1).Formula = "=G" & intRow - wks_S.Range("G11").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H11").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G11").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G11").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G11").Value - 1)
            intRow = intRow + wks_S.Range("G11").Value + 1
            
            If wks_S.Range("D12").Value <> 0 Then
                intDiagIndent = intPrevIndent + 2
                intPrevRow = intRow - wks_S.Range("G11").Value - 1
                For intPrevSegment = 1 To wks_S.Range("G11").Value
                    .Range("F" & intRow).Value = wks_S.Range("Q" & intPrevSegment + 8).Value
                    .Range("F" & intRow).IndentLevel = intPrevIndent + 1
                    intRow = intRow + 1
                    Call Diagnosis_Rows
                    intPrevRow = intPrevRow + 1
                Next intPrevSegment
            End If
        Else
            If wks_S.Range("D12").Value <> 0 Then
                intDiagIndent = intPrevIndent
                intPrevRow = intTemp
                Call Diagnosis_Rows
            End If
        End If
    End With
End Function

Function Diagnosis_Rows()
    Dim intDiagSegment As Integer
    With wks_ForecastFlow
        'DIAGNOSIS
        .Range("F" & intRow).Value = wks_S.Range("D12").Value
        .Range("F" & intRow).IndentLevel = intDiagIndent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
        intRow = intRow + 1
        .Range("F" & intRow).Value = wks_S.Range("D12").Value & " - Patients"
        .Range("F" & intRow).IndentLevel = intDiagIndent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intPrevRow
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
        intTemp = intRow 'STORING DIAGNOSIS ROW
        If wks_S.Range("H12").Value = True And wks_S.Range("F12").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
            
        If wks_S.Range("F12").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G12").Value - 1).Value = wks_S.Range("R9:R" & wks_S.Range("G12").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G12").Value - 1).IndentLevel = intDiagIndent + 1
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G12").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G12").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G12").Value - 1)
            intRow = intRow + wks_S.Range("G12").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G12").Value - 1).Value = wks_S.Range("R9:R" & wks_S.Range("G12").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G12").Value - 1).IndentLevel = intDiagIndent + 1
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G12").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G12").Value - 1).Formula = "=G" & intRow - wks_S.Range("G12").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H12").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G12").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G12").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G12").Value - 1)
            intRow = intRow + wks_S.Range("G12").Value + 1
            
            If wks_S.Range("D13").Value <> 0 Then
                intTrIndent = intDiagIndent + 2
                intDiagRow = intRow - wks_S.Range("G12").Value - 1
                For intDiagSegment = 1 To wks_S.Range("G12").Value
                    .Range("F" & intRow).Value = wks_S.Range("R" & intDiagSegment + 8).Value
                    .Range("F" & intRow).IndentLevel = intDiagIndent + 1
                    intRow = intRow + 1
                    Call Treatment_Rows
                    intDiagRow = intDiagRow + 1
                Next intDiagSegment
            End If
        Else
            If wks_S.Range("D13").Value <> 0 Then
                intTrIndent = intDiagIndent
                intDiagRow = intTemp
                Call Treatment_Rows
            End If
        End If
    End With
End Function

Function Treatment_Rows()
    Dim intTrSegment As Integer
    With wks_ForecastFlow
        'TREATMENT
        .Range("F" & intRow).Value = wks_S.Range("D13").Value
        .Range("F" & intRow).IndentLevel = intTrIndent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
        intRow = intRow + 1
        .Range("F" & intRow).Value = wks_S.Range("D13").Value & " - Patients"
        .Range("F" & intRow).IndentLevel = intTrIndent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intDiagRow
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
        intTemp = intRow 'STORING TREATMENT ROW
        If wks_S.Range("H13").Value = True And wks_S.Range("F13").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        
        If wks_S.Range("F13").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G13").Value - 1).Value = wks_S.Range("S9:S" & wks_S.Range("G13").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G13").Value - 1).IndentLevel = intTrIndent + 1
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G13").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G13").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G13").Value - 1)
            intRow = intRow + wks_S.Range("G13").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G13").Value - 1).Value = wks_S.Range("S9:S" & wks_S.Range("G13").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G13").Value - 1).IndentLevel = intTrIndent + 1
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G13").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G13").Value - 1).Formula = "=G" & intRow - wks_S.Range("G13").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H13").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G13").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G13").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G13").Value - 1)
            intRow = intRow + wks_S.Range("G13").Value + 1
            
            If wks_S.Range("D14").Value <> 0 Then
                intC1Indent = intTrIndent + 2
                intTrRow = intRow - wks_S.Range("G13").Value - 1
                For intTrSegment = 1 To wks_S.Range("G13").Value
                    .Range("F" & intRow).Value = wks_S.Range("S" & intTrSegment + 8).Value
                    .Range("F" & intRow).IndentLevel = intTrIndent + 1
                    intRow = intRow + 1
                    Call Custom_1_Rows
                    intTrRow = intTrRow + 1
                Next intTrSegment
            End If
        Else
            If wks_S.Range("D14").Value <> 0 Then
                intC1Indent = intTrIndent + 1
                intTrRow = intTemp
                Call Custom_1_Rows
            End If
        End If
    End With
End Function

Function Custom_1_Rows()
    Dim intC1Segment As Integer
    With wks_ForecastFlow
        'CUSTOM 1
        .Range("F" & intRow).Value = wks_S.Range("D14").Value
        .Range("F" & intRow).IndentLevel = intC1Indent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Value = 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow).EntireRow.Hidden = True
        intRow = intRow + 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intTrRow
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow & ":A" & intRow + 1).EntireRow.Hidden = True
        intTemp = intRow 'STORING CUSTOM 1 ROW
        If wks_S.Range("H14").Value = True And wks_S.Range("F14").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F14").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G14").Value - 1).Value = wks_S.Range("T9:T" & wks_S.Range("G14").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G14").Value - 1).IndentLevel = intC1Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G14").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G14").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G14").Value - 1)
            intRow = intRow + wks_S.Range("G14").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G14").Value - 1).Value = wks_S.Range("T9:T" & wks_S.Range("G14").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G14").Value - 1).IndentLevel = intC1Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G14").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G14").Value - 1).Formula = "=G" & intRow - wks_S.Range("G14").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H14").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G14").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G14").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G14").Value - 1)
            intRow = intRow + wks_S.Range("G14").Value + 1
            
            If wks_S.Range("D15").Value <> 0 Then
                intC2Indent = intC1Indent + 1
                intC1Row = intRow - wks_S.Range("G14").Value - 1
                For intC1Segment = 1 To wks_S.Range("G14").Value
                    .Range("F" & intRow).Value = wks_S.Range("T" & intC1Segment + 8).Value
                    .Range("F" & intRow).IndentLevel = intC1Indent + 1
                    intRow = intRow + 1
                    Call Custom_2_Rows
                    intC1Row = intC1Row + 1
                Next intC1Segment
            End If
        Else
            If wks_S.Range("D15").Value <> 0 Then
                intC2Indent = intC1Indent + 1
                intC1Row = intTemp
                Call Custom_2_Rows
            End If
        End If
    End With
End Function

Function Custom_2_Rows()
   Dim intC2Segment As Integer
    With wks_ForecastFlow
        'CUSTOM 2
        .Range("F" & intRow).Value = wks_S.Range("D15").Value
        .Range("F" & intRow).IndentLevel = intC2Indent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Value = 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow).EntireRow.Hidden = True
        intRow = intRow + 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intC1Row
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow & ":A" & intRow + 1).EntireRow.Hidden = True
        intTemp = intRow 'STORING CUSTOM 2 ROW
        If wks_S.Range("H15").Value = True And wks_S.Range("F15").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F15").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G15").Value - 1).Value = wks_S.Range("U9:U" & wks_S.Range("G15").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G15").Value - 1).IndentLevel = intC2Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G15").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G15").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G15").Value - 1)
            intRow = intRow + wks_S.Range("G15").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G15").Value - 1).Value = wks_S.Range("U9:U" & wks_S.Range("G15").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G15").Value - 1).IndentLevel = intC2Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G15").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G15").Value - 1).Formula = "=G" & intRow - wks_S.Range("G15").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H15").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G15").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G15").Value
            End If
                
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G15").Value - 1)
            intRow = intRow + wks_S.Range("G15").Value + 1
            
            If wks_S.Range("D16").Value <> 0 Then
                intC3Indent = intC2Indent + 1
                intC2Row = intRow - wks_S.Range("G15").Value - 1
                For intC2Segment = 1 To wks_S.Range("G15").Value
                    .Range("F" & intRow).Value = wks_S.Range("U" & intC2Segment + 8).Value
                    .Range("F" & intRow).IndentLevel = intC2Indent + 1
                    intRow = intRow + 1
                    Call Custom_3_Rows
                    intC2Row = intC2Row + 1
                Next intC2Segment
            End If
        Else
            If wks_S.Range("D16").Value <> 0 Then
                intC3Indent = intC2Indent + 1
                intC2Row = intTemp
                Call Custom_3_Rows
            End If
        End If
    End With
End Function

Function Custom_3_Rows()
    Dim intC3Segment As Integer
    With wks_ForecastFlow
        'CUSTOM 3
        .Range("F" & intRow).Value = wks_S.Range("D16").Value
        .Range("F" & intRow).IndentLevel = intC3Indent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Value = 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow).EntireRow.Hidden = True
        intRow = intRow + 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intC2Row
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow & ":A" & intRow + 1).EntireRow.Hidden = True
        intTemp = intRow 'STORING CUSTOM 3 ROW
        If wks_S.Range("H16").Value = True And wks_S.Range("F16").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F16").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G16").Value - 1).Value = wks_S.Range("V9:V" & wks_S.Range("G16").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G16").Value - 1).IndentLevel = intC3Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G16").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G16").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G16").Value - 1)
            intRow = intRow + wks_S.Range("G16").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G16").Value - 1).Value = wks_S.Range("V9:V" & wks_S.Range("G16").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G16").Value - 1).IndentLevel = intC3Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G16").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G16").Value - 1).Formula = "=G" & intRow - wks_S.Range("G16").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H16").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G16").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G16").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G16").Value - 1)
            intRow = intRow + wks_S.Range("G16").Value + 1
            
            If wks_S.Range("D17").Value <> 0 Then
                intC4Indent = intC3Indent + 1
                intC3Row = intRow - wks_S.Range("G16").Value - 1
                For intC3Segment = 1 To wks_S.Range("G16").Value
                    .Range("F" & intRow).Value = wks_S.Range("V" & intC3Segment + 8).Value
                    .Range("F" & intRow).IndentLevel = intC3Indent + 1
                    intRow = intRow + 1
                    Call Custom_4_Rows
                    intC3Row = intC3Row + 1
                Next intC3Segment
            End If
        Else
            If wks_S.Range("D17").Value <> 0 Then
                intC4Indent = intC3Indent + 1
                intC3Row = intTemp
                Call Custom_4_Rows
            End If
        End If
    End With
End Function

Function Custom_4_Rows()
    Dim intC4Segment As Integer
    With wks_ForecastFlow
        'CUSTOM 4
        .Range("F" & intRow).Value = wks_S.Range("D17").Value
        .Range("F" & intRow).IndentLevel = intC4Indent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Value = 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow).EntireRow.Hidden = True
        intRow = intRow + 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intC3Row
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow & ":A" & intRow + 1).EntireRow.Hidden = True
        intTemp = intRow 'STORING CUSTOM 4 ROW
        If wks_S.Range("H17").Value = True And wks_S.Range("F17").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F17").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G17").Value - 1).Value = wks_S.Range("W9:W" & wks_S.Range("G17").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G17").Value - 1).IndentLevel = intC4Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G17").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G17").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G17").Value - 1)
            intRow = intRow + wks_S.Range("G17").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G17").Value - 1).Value = wks_S.Range("W9:W" & wks_S.Range("G17").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G17").Value - 1).IndentLevel = intC4Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G17").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G17").Value - 1).Formula = "=G" & intRow - wks_S.Range("G17").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H17").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G17").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G17").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G17").Value - 1)
            intRow = intRow + wks_S.Range("G17").Value + 1
            
            If wks_S.Range("D18").Value <> 0 Then
                intC5Indent = intC4Indent + 1
                intC4Row = intRow - wks_S.Range("G17").Value - 1
                For intC4Segment = 1 To wks_S.Range("G17").Value
                    .Range("F" & intRow).Value = wks_S.Range("W" & intC4Segment + 8).Value
                    .Range("F" & intRow).IndentLevel = intC4Indent + 1
                    intRow = intRow + 1
                    Call Custom_5_Rows
                    intC4Row = intC4Row + 1
                Next intC4Segment
            End If
        Else
            If wks_S.Range("D18").Value <> 0 Then
                intC5Indent = intC4Indent + 1
                intC4Row = intTemp
                Call Custom_5_Rows
            End If
        End If
    End With
End Function
Function Custom_5_Rows()
    Dim intC5Segment As Integer
    With wks_ForecastFlow
        'CUSTOM 4
        .Range("F" & intRow).Value = wks_S.Range("D118").Value
        .Range("F" & intRow).IndentLevel = intC5Indent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Value = 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow).EntireRow.Hidden = True
        intRow = intRow + 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intC4Row
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow & ":A" & intRow + 1).EntireRow.Hidden = True
        intTemp = intRow 'STORING CUSTOM 4 ROW
        If wks_S.Range("H18").Value = True And wks_S.Range("F18").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F18").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G18").Value - 1).Value = wks_S.Range("W9:W" & wks_S.Range("G18").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G18").Value - 1).IndentLevel = intC5Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G18").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G18").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G18").Value - 1)
            intRow = intRow + wks_S.Range("G18").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G18").Value - 1).Value = wks_S.Range("W9:W" & wks_S.Range("G18").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G18").Value - 1).IndentLevel = intC5Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G18").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G18").Value - 1).Formula = "=G" & intRow - wks_S.Range("G18").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H18").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G18").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G18").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G18").Value - 1)
            intRow = intRow + wks_S.Range("G18").Value + 1
            
            If wks_S.Range("D19").Value <> 0 Then
                intC6Indent = intC5Indent + 1
                intC5Row = intRow - wks_S.Range("G18").Value - 1
                For intC5Segment = 1 To wks_S.Range("G18").Value
                    .Range("F" & intRow).Value = wks_S.Range("W" & intC5Segment + 8).Value
                    .Range("F" & intRow).IndentLevel = intC5Indent + 1
                    intRow = intRow + 1
                    Call Custom_6_Rows
                    intC5Row = intC5Row + 1
                Next intC5Segment
            End If
        Else
            If wks_S.Range("D19").Value <> 0 Then
                intC6Indent = intC5Indent + 1
                intC5Row = intTemp
                Call Custom_6_Rows
            End If
        End If
    End With
End Function

Function Custom_6_Rows()
    Dim intC5Segment As Integer
    With wks_ForecastFlow
        'CUSTOM 5
        .Range("F" & intRow).Value = wks_S.Range("D19").Value
        .Range("F" & intRow).IndentLevel = intC6Indent
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "0.0%"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Value = 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Interior.Color = RGB(255, 255, 204)
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow).EntireRow.Hidden = True
        intRow = intRow + 1
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).NumberFormat = "#,##0"
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow).Formula = "=G" & intRow - 1 & "*G" & intC5Row
        Call Format_Borders_New_EPI_Sheet(intRow, intRow)
''        .Range("A" & intRow & ":A" & intRow + 1).EntireRow.Hidden = True
        intTemp = intRow 'STORING CUSTOM 5 ROW
        If wks_S.Range("H19").Value = True And wks_S.Range("F19").Value = False Then
            If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow).Formula = "=G" & intRow
            intEPIRow = intEPIRow + 1
        End If
        intRow = intRow + 2
        If wks_S.Range("F19").Value = True Then
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G19").Value - 1).Value = wks_S.Range("X9:X" & wks_S.Range("G19").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G19").Value - 1).IndentLevel = intC6Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G19").Value - 1).NumberFormat = "0.0%"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G19").Value - 1).Interior.Color = RGB(255, 255, 204)
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G19").Value - 1)
            intRow = intRow + wks_S.Range("G19").Value + 1
            
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G19").Value - 1).Value = wks_S.Range("X9:X" & wks_S.Range("G19").Value + 8).Value
            .Range("F" & intRow & ":F" & intRow + wks_S.Range("G19").Value - 1).IndentLevel = intC6Indent
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G19").Value - 1).NumberFormat = "#,##0"
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + wks_S.Range("G19").Value - 1).Formula = "=G" & intRow - wks_S.Range("G19").Value - 1 & "*G$" & intTemp & ""
            
            If wks_S.Range("H19").Value = True Then
                If intEPIRow < 1001 Then .Range("G" & intEPIRow & ":" & wks_Vars.Range("J8").Value & intEPIRow + wks_S.Range("G19").Value - 1).Formula = "=G" & intRow
                intEPIRow = intEPIRow + wks_S.Range("G19").Value
            End If
            
            Call Format_Borders_New_EPI_Sheet(intRow, intRow + wks_S.Range("G19").Value - 1)
            intRow = intRow + wks_S.Range("G19").Value + 1
        End If
    End With
End Function

Function Format_Borders_New_EPI_Sheet(intStart As Integer, intEnd As Integer)
    Dim strRange As String
    strRange = "F" & intStart & ":" & wks_Vars.Range("J8").Value & intEnd
    With wks_ForecastFlow.Range(strRange)
        .Borders(xlDiagonalDown).LineStyle = xlNone
        .Borders(xlDiagonalUp).LineStyle = xlNone
        With .Borders(xlEdgeLeft)
            .LineStyle = xlDot
            .ThemeColor = 1
            .TintAndShade = -0.149906918546098
            .Weight = xlThin
        End With
        With .Borders(xlEdgeTop)
            .LineStyle = xlDot
            .ThemeColor = 1
            .TintAndShade = -0.149906918546098
            .Weight = xlThin
        End With
        With .Borders(xlEdgeBottom)
            .LineStyle = xlDot
            .ThemeColor = 1
            .TintAndShade = -0.149906918546098
            .Weight = xlThin
        End With
        With .Borders(xlEdgeRight)
            .LineStyle = xlDot
            .ThemeColor = 1
            .TintAndShade = -0.149906918546098
            .Weight = xlThin
        End With
        With .Borders(xlInsideVertical)
            .LineStyle = xlDot
            .ThemeColor = 1
            .TintAndShade = -0.149906918546098
            .Weight = xlThin
        End With
        With .Borders(xlInsideHorizontal)
            .LineStyle = xlDot
            .ThemeColor = 1
            .TintAndShade = -0.149906918546098
            .Weight = xlThin
        End With
    End With
End Function


