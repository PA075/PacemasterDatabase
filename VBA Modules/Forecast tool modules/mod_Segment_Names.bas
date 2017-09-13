Attribute VB_Name = "mod_Segment_Names"
Option Explicit

Function Segment_Names()
    Dim intLoop1 As Integer
    Dim intLoop2 As Integer, intCount2 As Integer
    Dim intLoop3 As Integer, intCount3 As Integer
    Dim intLoop4 As Integer, intCount4 As Integer
    Dim intLoop5 As Integer, intCount5 As Integer
    Dim intLoop6 As Integer, intCount6 As Integer
    Dim intLoop7 As Integer, intCount7 As Integer
    Dim intRow As Integer, intCount8 As Integer
    Dim intLoop8 As Integer, intCount9 As Integer
    Dim intLoop9 As Integer, intCount10 As Integer
    Dim intLoop10 As Integer, intCount11 As Integer
    Dim strSegment As String
    Dim intCount As Integer
   
    wks_Vars.Range("AC:AC").ClearContents
    intRow = 2
    For intLoop1 = 1 To wks_Vars.Range("AF2").Value
        If wks_Vars.Range("AE3").Value Then
            intCount2 = wks_Vars.Range("AF3").Value
        Else
            intCount2 = 1
        End If
        For intLoop2 = 1 To intCount2
            If wks_Vars.Range("AE4").Value Then
                intCount3 = wks_Vars.Range("AF4").Value
            Else
                intCount3 = 1
            End If
            For intLoop3 = 1 To intCount3
                If wks_Vars.Range("AE5").Value Then
                    intCount4 = wks_Vars.Range("AF5").Value
                Else
                    intCount4 = 1
                End If
                For intLoop4 = 1 To intCount4
                    If wks_Vars.Range("AE6").Value Then
                        intCount5 = wks_Vars.Range("AF6").Value
                    Else
                        intCount5 = 1
                    End If
                    For intLoop5 = 1 To intCount5
                        If wks_Vars.Range("AE7").Value Then
                            intCount6 = wks_Vars.Range("AF7").Value
                        Else
                            intCount6 = 1
                        End If
                        For intLoop6 = 1 To intCount6
                            If wks_Vars.Range("AE8").Value Then
                                intCount7 = wks_Vars.Range("AF8").Value
                            Else
                                intCount7 = 1
                            End If
                            For intLoop7 = 1 To intCount7
                                If wks_Vars.Range("AE9").Value Then
                                    intCount8 = wks_Vars.Range("AF9").Value
                                Else
                                    intCount8 = 1
                                End If
                                For intLoop8 = 1 To intCount8
                                    If wks_Vars.Range("AE10").Value Then
                                        intCount9 = wks_Vars.Range("AF10").Value
                                    Else
                                        intCount9 = 1
                                    End If
                                    For intLoop9 = 1 To intCount9
                                        If wks_Vars.Range("AE11").Value Then
                                            intCount10 = wks_Vars.Range("AF11").Value
                                        Else
                                            intCount10 = 1
                                        End If
                                        For intLoop10 = 1 To intCount10
                                            If wks_Vars.Range("AE12").Value Then
                                                intCount11 = wks_Vars.Range("AF12").Value
                                            Else
                                                intCount11 = 1
                                            End If
                                             strSegment = ""
                                             strSegment = strSegment & wks_Vars.Cells(2, 32 + intLoop1)
                                             If wks_Vars.Cells(3, 32 + intLoop2) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(3, 32 + intLoop2)
                                             If wks_Vars.Cells(4, 32 + intLoop3) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(4, 32 + intLoop3)
                                             If wks_Vars.Cells(5, 32 + intLoop4) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(5, 32 + intLoop4)
                                             If wks_Vars.Cells(6, 32 + intLoop5) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(6, 32 + intLoop5)
                                             If wks_Vars.Cells(7, 32 + intLoop6) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(7, 32 + intLoop6)
                                             If wks_Vars.Cells(8, 32 + intLoop7) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(8, 32 + intLoop7)
                                             If wks_Vars.Cells(9, 32 + intLoop8) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(9, 32 + intLoop8)
                                             If wks_Vars.Cells(10, 32 + intLoop9) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(10, 32 + intLoop9)
                                             If wks_Vars.Cells(11, 32 + intLoop10) <> "" Then strSegment = strSegment & "-" & wks_Vars.Cells(11, 32 + intLoop10)
                                             wks_Vars.Range("AC" & intRow).Value = strSegment
                                             intRow = intRow + 1
                                        Next intLoop10
                                    Next intLoop9
                                Next intLoop8
                            Next intLoop7
                        Next intLoop6
                    Next intLoop5
                Next intLoop4
            Next intLoop3
        Next intLoop2
    Next intLoop1
    
    intCount = Application.WorksheetFunction.CountA(wks_Vars.Range("AC:AC"))
    If intCount = 0 Then
        wks_Vars.Range("AC2").Value = wks_Vars.Range("AD" & wks_Vars.Range("AM1").Value + 1).Value
    End If
    If intCount = 0 Then
        intCount = 1
    ElseIf intCount > 15 Then
        intCount = 15
    End If
    wks_Trending.Shapes("drp_Segment").ControlFormat.ListFillRange = "Vars!$AC$2:$AC$" & intCount + 1
End Function

Function Product_Names()
    Dim intLoop As Integer
    Dim intRow As Integer
    With wks_Vars
        .Range("Z:Z").ClearContents
        .Range("Z2").Value = "All"
        intRow = 3
        For intLoop = 1 To .Range("M1").Value
            .Range("Z" & intRow).Value = .Range("L" & intLoop + 2).Value
            intRow = intRow + 1
        Next intLoop
        For intLoop = 1 To .Range("R1").Value
            .Range("Z" & intRow).Value = .Range("Q" & intLoop + 2).Value
            intRow = intRow + 1
        Next intLoop
    End With
End Function
