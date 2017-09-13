Attribute VB_Name = "mod_IMSData"
Option Explicit
''--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
''IMPORT IMS DATA
''--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function Create_Forecast()
    frm_Create.Show
End Function

Function Excel_Connection_String(strFileName As String)
    If Application.Version = "16.0" Then
        Excel_Connection_String = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" & strFileName & ";Extended Properties=Excel 12.0 Macro"
    ElseIf Application.Version = "15.0" Then
        Excel_Connection_String = "Provider=Microsoft.ACE.OLEDB.15.0;Data Source=" & strFileName & ";Extended Properties=Excel 12.0 Macro"
    Else
        Excel_Connection_String = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & strFileName & ";Extended Properties=Excel 12.0 Macro"
    End If
End Function

Function Import_IMSData()
    Dim strFileName As String, strSQL As String
    Dim rs As Object
    Dim intCol As Integer
    
    strFileName = Select_File_From_Folder
    If strFileName = "" Then
        MsgBox "Please select a file", vbInformation + vbOKOnly, "PharmaACE"
        Exit Function
    End If
    
Call Application_Events_Handler(False)
    'NSP Data
    wks_NSPData.Cells.Clear
    strSQL = "SELECT * FROM [NSP_Units Data$]"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(strFileName)
    wks_NSPData.Range("A2").CopyFromRecordset rs
    For intCol = 0 To rs.Fields.Count - 1
        wks_NSPData.Cells(1, intCol + 1).Value = rs.Fields(intCol).Name
    Next intCol
    rs.Close
    Set rs = Nothing
    
    'NPA Data
    wks_NPAData.Cells.Clear
    strSQL = "SELECT * FROM [NPA_TRx Data$]"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(strFileName)
    wks_NPAData.Range("A2").CopyFromRecordset rs
    For intCol = 0 To rs.Fields.Count - 1
        wks_NPAData.Cells(1, intCol + 1).Value = rs.Fields(intCol).Name
    Next intCol
    rs.Close
    Set rs = Nothing
    
    'DATES
        wks_Unique.Range("A:B").Clear
        Call Unique_Values("A", "Month")
        intCol = Application.WorksheetFunction.CountA(wks_Unique.Range("A:A"))
        With wks_Unique.Range("B1:B" & intCol)
            .Formula = "=DATE(VALUE(LEFT(A1,4)),VALUE(RIGHT(A1,2)),1)"
            .Calculate
            .Value = .Value
        End With
        Call Sort_Data("A", "B", intCol)
    'MOLECULES
        wks_Unique.Range("J:J").Clear
        Call Unique_Values("J", "Molecule")
        intCol = Application.WorksheetFunction.CountA(wks_Unique.Range("J:J"))
        Call Sort_Data("J", "J", intCol)
        
    MsgBox "IMS Data loaded successfully", vbInformation + vbOKOnly, "PharmaACE"
Call Application_Events_Handler(True)
End Function

Function Unique_Values(strCol As String, strField As String)
    Dim strSQL As String
    Dim rs As Object
    Dim intCol As Integer
    
    strSQL = "SELECT DISTINCT [" & strField & "] From [NSPData$]"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    wks_Unique.Range(strCol & "1").CopyFromRecordset rs
    Set rs = Nothing
    'Count from NSP Data
    intCol = Application.WorksheetFunction.CountA(wks_Unique.Range(strCol & ":" & strCol))
    intCol = intCol + 1
    'FROM NPA Data
    strSQL = "SELECT DISTINCT [" & strField & "] From [NPAData$]"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    wks_Unique.Range(strCol & intCol).CopyFromRecordset rs
    Set rs = Nothing
    'REMOVE DUPLICATES
    intCol = Application.WorksheetFunction.CountA(wks_Unique.Range(strCol & ":" & strCol))
    wks_Unique.Range(strCol & "1:" & strCol & intCol).RemoveDuplicates Columns:=1, Header:=xlNo
End Function

Function Sort_Data(strStart As String, strEnd As String, intCol As Integer)
    With wks_Unique
        .Sort.SortFields.Clear
        .Sort.SortFields.Add Key:=wks_Unique.Range(strEnd & "1:" & strEnd & intCol), SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        With .Sort
            .SetRange wks_Unique.Range(strStart & "1:" & strEnd & intCol)
            .Header = xlGuess
            .MatchCase = False
            .Orientation = xlTopToBottom
            .SortMethod = xlPinYin
            .Apply
        End With
    End With
End Function

Function Select_File_From_Folder()
    Dim intChoice As Integer
    Dim strPath As String
    
    Select_File_From_Folder = ""
    
    Select_File_From_Folder = Application.GetOpenFilename(FileFilter:="Excel Files (*.XLS*), *.XLS*", Title:="Select File To Be Opened")
    If Select_File_From_Folder = False Then Select_File_From_Folder = ""
End Function

''--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
''MAPPING DATA
''--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
''Function Mapping_Activate()
''    wks_IMSVars.Range("B1").Value = 1
''    Call Load_Mapping_Data("Molecule")
''    wks_Mapping.Activate
''End Function
''Function Mapping_Names()
''    If wks_IMSVars.Range("B1").Value = 1 Then
''        Call Load_Mapping_Data("Molecule")
''    ElseIf wks_IMSVars.Range("B1").Value = 2 Then
''        Call Load_Mapping_Data("Manufacturer")
''    ElseIf wks_IMSVars.Range("B1").Value = 3 Then
''        Call Load_Mapping_Data("Product")
''    ElseIf wks_IMSVars.Range("B1").Value = 4 Then
''        Call Load_Mapping_Data("Form/Strength")
''    End If
''End Function

''Function Load_Mapping_Data(strField As String)
''    Dim strSQL As String
''    Dim rs As Object
''    Dim intCol As Integer
''
''Call Application_Events_Handler(False)
''
''    With wks_Mapping
''        .Range("B4:C1000").Clear
''
''        strSQL = "SELECT DISTINCT [" & strField & "] FROM [NSPData$] ORDER BY 1"
''        Set rs = CreateObject("ADODB.RecordSet")
''        rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
''        .Range("B4").CopyFromRecordset rs
''        Set rs = Nothing
''
''        intCol = Application.WorksheetFunction.CountA(.Range("B4:B1000"))
''        If intCol > 0 Then
''            Call Format_Mapping(.Range("B4:C" & intCol + 3))
''            .Range("C4:C" & intCol + 3).Interior.Color = RGB(255, 255, 204)
''        End If
''    End With
''End Function

''Function Format_Mapping(rngData As Range)
''    With rngData
''        .Borders(xlDiagonalDown).LineStyle = xlNone
''        .Borders(xlDiagonalUp).LineStyle = xlNone
''        With .Borders(xlEdgeLeft)
''            .LineStyle = xlContinuous
''            .ColorIndex = 0
''            .TintAndShade = 0
''            .Weight = xlThin
''        End With
''        With .Borders(xlEdgeTop)
''            .LineStyle = xlContinuous
''            .ColorIndex = 0
''            .TintAndShade = 0
''            .Weight = xlThin
''        End With
''        With .Borders(xlEdgeBottom)
''            .LineStyle = xlContinuous
''            .ColorIndex = 0
''            .TintAndShade = 0
''            .Weight = xlThin
''        End With
''        With .Borders(xlEdgeRight)
''            .LineStyle = xlContinuous
''            .ColorIndex = 0
''            .TintAndShade = 0
''            .Weight = xlThin
''        End With
''        With .Borders(xlInsideVertical)
''            .LineStyle = xlContinuous
''            .ColorIndex = 0
''            .TintAndShade = 0
''            .Weight = xlThin
''        End With
''        With .Borders(xlInsideHorizontal)
''            .LineStyle = xlContinuous
''            .ColorIndex = 0
''            .TintAndShade = 0
''            .Weight = xlThin
''        End With
''    End With
''End Function

''Function Save_MappingData()
''    Dim intCol As Integer, intLoop As Integer
''    Dim strCol As String
''    intCol = Application.WorksheetFunction.CountA(wks_Mapping.Range("B4:B1000")) + 3
''Call Application_Events_Handler(False)
''    strCol = Choose(wks_IMSVars.Range("B1").Value, "A", "C", "D", "E")
''    For intLoop = 4 To intCol
''        If wks_Mapping.Range("C" & intLoop).Value <> "" Then
''            wks_NSPData.Range(strCol & ":" & strCol).Replace wks_Mapping.Range("B" & intLoop).Value, wks_Mapping.Range("C" & intLoop).Value, xlWhole
''        End If
''    Next intLoop
''    MsgBox "Data Updated", vbInformation + vbOKOnly, "PharmaACE"
''Call Application_Events_Handler(True)
''End Function

''--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
''ANALYSIS
''--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Function Analysis_Sheet_Activate()
    frm_Overall.Show
''    wks_OverAll.Activate
End Function

Function OverAll_Summary()
    Dim intCol As Integer
    'OVERALL SUMMARY
    With wks_OverAll
        .Activate
        
        .Range("G102").Formula = "=SUMIFS(NSPData!$M:$M,NSPData!$AA:$AA,FALSE,NSPData!$AB:$AB,FALSE,NSPData!$J:$J,G$100)"
        .Range("G103").Formula = "=SUMIFS(NSPData!$M:$M,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100)"
        
        .Range("G106").Formula = "=SUMIFS(NSPData!$K:$K,NSPData!$AA:$AA,FALSE,NSPData!$AB:$AB,FALSE,NSPData!$J:$J,G$100)"
        .Range("G107").Formula = "=SUMIFS(NSPData!$K:$K,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100)"
        
        .Range("G110").Formula = "=SUMIFS(NPAData!$K:$K,NPAData!$AA:$AA,FALSE,NPAData!$AB:$AB,FALSE,NPAData!$J:$J,G$100)"
        .Range("G111").Formula = "=SUMIFS(NPAData!$K:$K,NPAData!$AA:$AA,FALSE,NPAData!$AC:$AC,FALSE,NPAData!$J:$J,G$100)"
        
        .Range("G114").Formula = "=IFERROR(G106/G102,0)"
        .Range("G115").Formula = "=IFERROR(G107/G103,0)"
        
        .Range("G102:G115").Copy
        .Range("G102:BZ115").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        
        .Calculate
        
        .Range("G102:BZ115").Value = .Range("G102:BZ115").Value
        
        .Range("G102:BZ115").Replace 0, "", xlWhole
        
        For intCol = 7 To 78
            If .Cells(103, intCol).Value <> "" Then
                If intCol = 7 Then
                    .Shapes("shp_Launch").TextFrame.Characters.Text = "First Generic Launch date on or before " & Format(.Cells(101, intCol), "MMM YYYY")
                Else
                    .Shapes("shp_Launch").TextFrame.Characters.Text = "First Generic Launch date: " & Format(.Cells(101, intCol), "MMM YYYY")
                End If
                Exit For
            End If
        Next intCol
        
        .Range("A6").Select
    End With
End Function

Function Strength_Summary_UserForm()
    frm_G_Strength.Show
End Function

Function Strength_Summary()
    Dim intCol As Integer, intLoop As Integer
    'STRENGTH LEVEL SUMMARY
    With wks_Strength
        .Activate
        
        .Range("E102:BZ167").ClearContents
        .Range("E102:BZ167").EntireRow.Hidden = False
        .Shapes("drp_SKU").ControlFormat.ListFillRange = ""
        
        .Range("E102:E116").Value = wks_IMSVars.Range("S1:S15").Value
        .Range("E119:E133").Value = wks_IMSVars.Range("S1:S15").Value
        .Range("E136:E150").Value = wks_IMSVars.Range("S1:S15").Value
        .Range("E153:E167").Value = wks_IMSVars.Range("S1:S15").Value
        
        .Range("F102:F116").Formula = "=IFERROR(RIGHT(E102,LEN(E102)-FIND("","",E102,1)),E102)"
        .Range("F102:F116").Value = .Range("F102:F116").Value
        .Range("F119:F133").Value = .Range("F102:F116").Value
        .Range("F136:F150").Value = .Range("F102:F116").Value
        .Range("F153:F167").Value = .Range("F102:F116").Value
        
        intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("S:S"))
        If intCol > 15 Then intCol = 15
        If intCol > 0 Then
            .Range("G102:G" & intCol + 101).Formula = "=SUMIFS(NSPData!$M:$M,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100,NSPData!$E:$E,$E102)"
            .Range("G119:G" & intCol + 118).Formula = "=SUMIFS(NSPData!$K:$K,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100,NSPData!$E:$E,$E102)"
            .Range("G136:G" & intCol + 135).Formula = "=SUMIFS(NPAData!$K:$K,NPAData!$AA:$AA,FALSE,NPAData!$AC:$AC,FALSE,NPAData!$J:$J,G$100,NPAData!$E:$E,$E102)"
            .Range("G153:G" & intCol + 152).Formula = "=IFERROR(G119/G102,0)"
            
            .Range("G102:G167").Copy
            .Range("G102:BZ167").PasteSpecial xlPasteFormulas
            Application.CutCopyMode = False
            
            .Calculate
            
            .Range("G102:BZ167").Value = .Range("G102:BZ167").Value
            
            .Range("G102:BZ167").Replace 0, "", xlWhole
            
            .Range("G" & intCol + 102 & ":G116").EntireRow.Hidden = True
            .Range("G" & intCol + 119 & ":G133").EntireRow.Hidden = True
            .Range("G" & intCol + 136 & ":G150").EntireRow.Hidden = True
            .Range("G" & intCol + 153 & ":G167").EntireRow.Hidden = True
            
            For intLoop = 7 To 78
                If .Cells(99, intLoop).Value = 0 Then
                    .Cells(99, intLoop).EntireColumn.Hidden = True
                Else
                    .Cells(99, intLoop).EntireColumn.Hidden = False
                End If
            Next intLoop
            .Shapes("drp_SKU").ControlFormat.ListFillRange = "Strength_Summary!F102:F" & intCol + 101
        End If
        
        .Range("CK100").Value = 1
        .Range("A6").Select
    End With
End Function

Function Player_Summary_UserForm()
    Dim intCol As Integer, intLoop As Integer
    Dim strMolecules As String
    Dim strGenerics As String
    Dim strSKU As String
    Dim strSQL As String
    Dim rs As Object
    
    Call Application_Events_Handler(False)
    
    With wks_IMSVars
        .Range("V:V").Clear
        
        intCol = Application.WorksheetFunction.CountA(.Range("J:J"))
        strMolecules = ""
        For intLoop = 1 To intCol
            If strMolecules <> "" Then strMolecules = strMolecules & ","
            strMolecules = strMolecules & "'" & .Range("J" & intCol).Value & "'"
        Next intLoop
        
        intCol = Application.WorksheetFunction.CountA(.Range("P:P"))
        strGenerics = ""
        For intLoop = 1 To intCol
            If strGenerics <> "" Then strGenerics = strGenerics & ","
            strGenerics = strGenerics & "'" & .Range("P" & intCol).Value & "'"
        Next intLoop
        
        intCol = Application.WorksheetFunction.CountA(.Range("S:S"))
        strSKU = ""
        For intLoop = 1 To intCol
            If strSKU <> "" Then strSKU = strSKU & ","
            strSKU = strSKU & "'" & .Range("S" & intCol).Value & "'"
        Next intLoop
    End With
    
    If wks_IMSVars.Range("G1").Value Then
        strSQL = "SELECT DISTINCT [Manufacturer] From"
        strSQL = strSQL & "(SELECT DISTINCT [Manufacturer] FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND [Form/Strength] IN (" & strSKU & ") AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])"
        strSQL = strSQL & " UNION ALL "
        strSQL = strSQL & "SELECT DISTINCT [Manufacturer] FROM [NPAData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND [Form/Strength] IN (" & strSKU & ") AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])) ORDER BY 1"
    Else
        strSQL = "SELECT DISTINCT [Manufacturer] From"
        strSQL = strSQL & "(SELECT DISTINCT [Manufacturer] FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND [Form/Strength] IN (" & strSKU & ")"
        strSQL = strSQL & " UNION ALL "
        strSQL = strSQL & "SELECT DISTINCT [Manufacturer] FROM [NPAData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND [Form/Strength] IN (" & strSKU & ")) ORDER BY 1"
    End If
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    wks_IMSVars.Range("V1").CopyFromRecordset rs
    Set rs = Nothing
    Call Player_Summary
    Call Application_Events_Handler(True)
End Function

Function Player_Summary()
    Dim intCol As Integer, intLoop As Integer
    'PLAYER LEVEL SUMMARY
    With wks_Competitors
        .Activate
        
        .Range("E102:BZ167").ClearContents
        .Range("E102:BZ167").EntireRow.Hidden = False
        .Shapes("drp_Comp").ControlFormat.ListFillRange = ""
        
        .Range("E102:E116").Value = wks_IMSVars.Range("V1:V15").Value
        .Range("E119:E133").Value = wks_IMSVars.Range("V1:V15").Value
        .Range("E136:E150").Value = wks_IMSVars.Range("V1:V15").Value
        .Range("E153:E167").Value = wks_IMSVars.Range("V1:V15").Value
        
        .Range("F102:F116").Formula = wks_IMSVars.Range("V1:V15").Value
        .Range("F102:F116").Value = .Range("F102:F116").Value
        .Range("F119:F133").Value = .Range("F102:F116").Value
        .Range("F136:F150").Value = .Range("F102:F116").Value
        .Range("F153:F167").Value = .Range("F102:F116").Value
        
        intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("V:V"))
        If intCol > 15 Then intCol = 15
        If intCol > 0 Then
            .Range("G102:G" & intCol + 101).Formula = "=SUMIFS(NSPData!$M:$M,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100,NSPData!$C:$C,$E102)"
            .Range("G119:G" & intCol + 118).Formula = "=SUMIFS(NSPData!$K:$K,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100,NSPData!$C:$C,$E102)"
            .Range("G136:G" & intCol + 135).Formula = "=SUMIFS(NPAData!$K:$K,NPAData!$AA:$AA,FALSE,NPAData!$AC:$AC,FALSE,NPAData!$J:$J,G$100,NPAData!$C:$C,$E102)"
            .Range("G153:G" & intCol + 152).Formula = "=IFERROR(G119/G102,0)"
            
            .Range("G102:G167").Copy
            .Range("G102:BZ167").PasteSpecial xlPasteFormulas
            Application.CutCopyMode = False
            
            .Calculate
            
            .Range("G102:BZ167").Value = .Range("G102:BZ167").Value
            
            .Range("G102:BZ167").Replace 0, "", xlWhole
            
            .Range("G" & intCol + 102 & ":G116").EntireRow.Hidden = True
            .Range("G" & intCol + 119 & ":G133").EntireRow.Hidden = True
            .Range("G" & intCol + 136 & ":G150").EntireRow.Hidden = True
            .Range("G" & intCol + 153 & ":G167").EntireRow.Hidden = True
            
            For intLoop = 7 To 78
                If .Cells(99, intLoop).Value = 0 Then
                    .Cells(99, intLoop).EntireColumn.Hidden = True
                Else
                    .Cells(99, intLoop).EntireColumn.Hidden = False
                End If
            Next intLoop
            
            .Shapes("drp_Comp").ControlFormat.ListFillRange = "Comp_Summary!F102:F" & intCol + 101
        End If
        
        .Range("CK100").Value = 1
        .Range("A6").Select
    End With
End Function

Function Brand_Summary_UserForm()
    frm_G_Strength.Show
End Function

Function Brand_Summary()
    Dim intCol As Integer, intLoop As Integer
    'STRENGTH LEVEL SUMMARY
    With wks_Brand
        .Activate
        
        .Range("E102:BZ167").ClearContents
        .Range("E102:BZ167").EntireRow.Hidden = False
        .Shapes("drp_Molecule").ControlFormat.ListFillRange = ""
        
        .Range("E102:E116").Value = wks_IMSVars.Range("J1:J15").Value
        .Range("E119:E133").Value = wks_IMSVars.Range("J1:J15").Value
        .Range("E136:E150").Value = wks_IMSVars.Range("J1:J15").Value
        .Range("E153:E167").Value = wks_IMSVars.Range("J1:J15").Value
        
        .Range("F102:F116").Formula = wks_IMSVars.Range("J1:J15").Value
        .Range("F102:F116").Value = .Range("F102:F116").Value
        .Range("F119:F133").Value = .Range("F102:F116").Value
        .Range("F136:F150").Value = .Range("F102:F116").Value
        .Range("F153:F167").Value = .Range("F102:F116").Value
        
        intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("J:J"))
        If intCol > 15 Then intCol = 15
        If intCol > 0 Then
            .Range("G102:G" & intCol + 101).Formula = "=SUMIFS(NSPData!$M:$M,NSPData!$J:$J,G$100,NSPData!$A:$A,$E102)"
            .Range("G119:G" & intCol + 118).Formula = "=SUMIFS(NSPData!$K:$K,NSPData!$J:$J,G$100,NSPData!$A:$A,$E102)"
            .Range("G136:G" & intCol + 135).Formula = "=SUMIFS(NPAData!$K:$K,NPAData!$J:$J,G$100,NPAData!$A:$A,$E102)"
            .Range("G153:G" & intCol + 152).Formula = "=IFERROR(G119/G102,0)"
            
            .Range("G102:G167").Copy
            .Range("G102:BZ167").PasteSpecial xlPasteFormulas
            Application.CutCopyMode = False
            
            .Calculate
            
            .Range("G102:BZ167").Value = .Range("G102:BZ167").Value
            
            .Range("G102:BZ167").Replace 0, "", xlWhole
            
            .Range("G" & intCol + 102 & ":G116").EntireRow.Hidden = True
            .Range("G" & intCol + 119 & ":G133").EntireRow.Hidden = True
            .Range("G" & intCol + 136 & ":G150").EntireRow.Hidden = True
            .Range("G" & intCol + 153 & ":G167").EntireRow.Hidden = True
            
            For intLoop = 7 To 78
                If .Cells(99, intLoop).Value = 0 Then
                    .Cells(99, intLoop).EntireColumn.Hidden = True
                Else
                    .Cells(99, intLoop).EntireColumn.Hidden = False
                End If
            Next intLoop
            .Shapes("drp_Molecule").ControlFormat.ListFillRange = "Brand_Summary!F102:F" & intCol + 101
        End If
        
        .Range("CK100").Value = 1
        .Range("A6").Select
    End With
End Function

Function Brand_Strngth_Summary_UserForm()
    frm_B_Strength.Show
End Function

Function Brand_Strength_Summary()
    Dim intCol As Integer, intLoop As Integer
    'STRENGTH LEVEL SUMMARY
    With wks_B_Strength
        .Activate
        
        .Range("E102:BZ167").ClearContents
        .Range("E102:BZ167").EntireRow.Hidden = False
        .Shapes("drp_SKU").ControlFormat.ListFillRange = ""
        
        .Range("E102:E116").Value = wks_IMSVars.Range("S1:S15").Value
        .Range("E119:E133").Value = wks_IMSVars.Range("S1:S15").Value
        .Range("E136:E150").Value = wks_IMSVars.Range("S1:S15").Value
        .Range("E153:E167").Value = wks_IMSVars.Range("S1:S15").Value
        
        .Range("F102:F116").Formula = "=IFERROR(RIGHT(E102,LEN(E102)-FIND("","",E102,1)),E102)"
        .Range("F102:F116").Value = .Range("F102:F116").Value
        .Range("F119:F133").Value = .Range("F102:F116").Value
        .Range("F136:F150").Value = .Range("F102:F116").Value
        .Range("F153:F167").Value = .Range("F102:F116").Value
        
        intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("S:S"))
        If intCol > 15 Then intCol = 15
        If intCol > 0 Then
            .Range("G102:G" & intCol + 101).Formula = "=SUMIFS(NSPData!$M:$M,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100,NSPData!$E:$E,$E102)"
            .Range("G119:G" & intCol + 118).Formula = "=SUMIFS(NSPData!$K:$K,NSPData!$AA:$AA,FALSE,NSPData!$AC:$AC,FALSE,NSPData!$J:$J,G$100,NSPData!$E:$E,$E102)"
            .Range("G136:G" & intCol + 135).Formula = "=SUMIFS(NPAData!$K:$K,NPAData!$AA:$AA,FALSE,NPAData!$AC:$AC,FALSE,NPAData!$J:$J,G$100,NPAData!$E:$E,$E102)"
            .Range("G153:G" & intCol + 152).Formula = "=IFERROR(G119/G102,0)"
            
            .Range("G102:G167").Copy
            .Range("G102:BZ167").PasteSpecial xlPasteFormulas
            Application.CutCopyMode = False
            
            .Calculate
            
            .Range("G102:BZ167").Value = .Range("G102:BZ167").Value
            
            .Range("G102:BZ167").Replace 0, "", xlWhole
            
            .Range("G" & intCol + 102 & ":G116").EntireRow.Hidden = True
            .Range("G" & intCol + 119 & ":G133").EntireRow.Hidden = True
            .Range("G" & intCol + 136 & ":G150").EntireRow.Hidden = True
            .Range("G" & intCol + 153 & ":G167").EntireRow.Hidden = True
            
            For intLoop = 7 To 78
                If .Cells(99, intLoop).Value = 0 Then
                    .Cells(99, intLoop).EntireColumn.Hidden = True
                Else
                    .Cells(99, intLoop).EntireColumn.Hidden = False
                End If
            Next intLoop
            .Shapes("drp_SKU").ControlFormat.ListFillRange = "B_Strength_Summary!F102:F" & intCol + 101
        End If
        
        .Range("CK100").Value = 1
        .Range("A6").Select
    End With
End Function
