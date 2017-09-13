VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Overall 
   Caption         =   "OverAll Summary"
   ClientHeight    =   5475
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   18720
   OleObjectBlob   =   "frm_Overall.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Overall"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim rs As Object
Dim strSQL As String
Dim intLoop As Integer
Dim intCol As Double
Dim blnFlag As Boolean

Private Sub cmd_B_RA_Click()
    lstBrands.Clear
End Sub
Private Sub cmd_B_RS_Click()
    With lstBrands
        For intLoop = .ListCount - 1 To 0 Step -1
            If .Selected(intLoop) Then
                .RemoveItem (intLoop)
            End If
        Next intLoop
    End With
End Sub

Private Sub cmd_G_RA_Click()
    lstGenerics.Clear
End Sub
Private Sub cmd_G_RS_Click()
    With lstGenerics
        For intLoop = .ListCount - 1 To 0 Step -1
            If .Selected(intLoop) Then
                .RemoveItem (intLoop)
            End If
        Next intLoop
    End With
End Sub

Private Sub cmd_Brands_Click()
    With lstForms
        For intLoop = 0 To .ListCount - 1
            If .Selected(intLoop) And Left(.List(intLoop), 4) = "    " Then
                lstBrands.AddItem LTrim(.List(intLoop))
            End If
        Next intLoop
        
        For intLoop = .ListCount - 1 To 0 Step -1
            If .Selected(intLoop) Then
                .RemoveItem (intLoop)
            End If
        Next intLoop
    End With
End Sub

Private Sub cmd_Generics_Click()
    With lstForms
        For intLoop = 0 To .ListCount - 1
            If .Selected(intLoop) And Left(.List(intLoop), 4) = "    " Then
                lstGenerics.AddItem LTrim(.List(intLoop))
            End If
        Next intLoop
        
        For intLoop = .ListCount - 1 To 0 Step -1
            If .Selected(intLoop) Then
                .RemoveItem (intLoop)
            End If
        Next intLoop
    End With
End Sub

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_Forms_Click()
    lstForms.Clear
    For intLoop = 0 To lstMolecules.ListCount - 1
        If lstMolecules.Selected(intLoop) Then
            strSQL = "SELECT DISTINCT [Product] From"
            strSQL = strSQL & "(SELECT DISTINCT [Product] FROM [NSPData$] WHERE Molecule IN ('" & lstMolecules.List(intLoop) & "')"
            strSQL = strSQL & " UNION ALL "
            strSQL = strSQL & "SELECT DISTINCT [Product] FROM [NPAData$] WHERE Molecule IN ('" & lstMolecules.List(intLoop) & "')) ORDER BY 1"
            lstForms.AddItem lstMolecules.List(intLoop)
            Set rs = CreateObject("ADODB.RecordSet")
            rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
            On Error GoTo NoList
            rs.movefirst
            While Not rs.EOF
                lstForms.AddItem "    " & rs.Fields(0).Value
                rs.movenext
            Wend
            rs.Close
            Set rs = Nothing
        End If
    Next intLoop
NoList:
End Sub

Private Sub cmd_M_S_Click()
    With lstMolecules
        For intLoop = 0 To .ListCount - 1
            .Selected(intLoop) = True
        Next intLoop
    End With
End Sub
Private Sub cmd_M_U_Click()
    With lstMolecules
        For intLoop = 0 To .ListCount - 1
            .Selected(intLoop) = False
        Next intLoop
    End With
End Sub

Private Sub cmd_F_S_Click()
    If blnFlag = True Then Exit Sub
    blnFlag = True
    With lstForms
        For intLoop = 0 To .ListCount - 1
            .Selected(intLoop) = True
        Next intLoop
    End With
    blnFlag = False
End Sub
Private Sub cmd_F_U_Click()
    If blnFlag = True Then Exit Sub
    blnFlag = True
    With lstForms
        For intLoop = 0 To .ListCount - 1
            .Selected(intLoop) = False
        Next intLoop
    End With
    blnFlag = False
End Sub

Private Sub cmd_OK_Click()
    Dim strMolecules As String
    Dim strBrands As String
    Dim strGenerics As String
    Dim blnMolecule As Boolean
Call Application_Events_Handler(False)
    With wks_IMSVars
        .Range("J:J").Clear
        .Range("M:M").Clear
        .Range("P:P").Clear
        .Range("S:S").Clear
        .Range("V:V").Clear
        
        .Range("G1").Value = chkRepack.Value
        
        blnMolecule = False
        
        strMolecules = ""
        intCol = 1
        For intLoop = 0 To lstMolecules.ListCount - 1
            If lstMolecules.Selected(intLoop) Then
                If strMolecules <> "" Then strMolecules = strMolecules & ","
                strMolecules = strMolecules & "'" & lstMolecules.List(intLoop) & "'"
                .Range("J" & intCol).Value = lstMolecules.List(intLoop)
                intCol = intCol + 1
            End If
        Next intLoop
        wks_OverAll.Shapes("shp_Molecules").TextFrame.Characters.Text = "Selected Molecules: " & Chr(10) & strMolecules
        wks_Strength.Shapes("shp_Molecules").TextFrame.Characters.Text = "Selected Molecules: " & Chr(10) & strMolecules
        wks_Competitors.Shapes("shp_Molecules").TextFrame.Characters.Text = "Selected Molecules: " & Chr(10) & strMolecules
        wks_Brand.Shapes("shp_Molecules").TextFrame.Characters.Text = "Selected Molecules: " & Chr(10) & strMolecules
        
        If intCol >= 2 Then blnMolecule = True
        
        strBrands = ""
        intCol = 1
        For intLoop = 0 To lstBrands.ListCount - 1
            If strBrands <> "" Then strBrands = strBrands & ","
            strBrands = strBrands & "'" & lstBrands.List(intLoop) & "'"
            .Range("M" & intCol).Value = lstBrands.List(intLoop)
            intCol = intCol + 1
        Next intLoop
        wks_OverAll.Shapes("shp_Brands").TextFrame.Characters.Text = "Selected Brands: " & Chr(10) & strBrands
        wks_Brand.Shapes("shp_Brands").TextFrame.Characters.Text = "Selected Brands: " & Chr(10) & strBrands
        
        strGenerics = ""
        intCol = 1
        For intLoop = 0 To lstGenerics.ListCount - 1
            If strGenerics <> "" Then strGenerics = strGenerics & ","
            strGenerics = strGenerics & "'" & lstGenerics.List(intLoop) & "'"
            .Range("P" & intCol).Value = lstGenerics.List(intLoop)
            intCol = intCol + 1
        Next intLoop
        wks_OverAll.Shapes("shp_Generics").TextFrame.Characters.Text = "Selected Generics: " & Chr(10) & strGenerics
        wks_Strength.Shapes("shp_Generics").TextFrame.Characters.Text = "Selected Generics: " & Chr(10) & strGenerics
        wks_Competitors.Shapes("shp_Generics").TextFrame.Characters.Text = "Selected Generics: " & Chr(10) & strGenerics
        wks_Brand.Shapes("shp_Generics").TextFrame.Characters.Text = "Selected Generics: " & Chr(10) & strGenerics
        
        If chkRepack.Value Then
            strSQL = "SELECT DISTINCT [Form/Strength] From"
            strSQL = strSQL & "(SELECT DISTINCT [Form/Strength] FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])"
            strSQL = strSQL & " UNION ALL "
            strSQL = strSQL & "SELECT DISTINCT [Form/Strength] FROM [NPAData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])) ORDER BY 1"
        Else
            strSQL = "SELECT DISTINCT [Form/Strength] From"
            strSQL = strSQL & "(SELECT DISTINCT [Form/Strength] FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ")"
            strSQL = strSQL & " UNION ALL "
            strSQL = strSQL & "SELECT DISTINCT [Form/Strength] FROM [NPAData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ")) ORDER BY 1"
        End If
        Set rs = CreateObject("ADODB.RecordSet")
        rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
        .Range("S1").CopyFromRecordset rs
        Set rs = Nothing
        
        If chkRepack.Value Then
            strSQL = "SELECT DISTINCT [Manufacturer] From"
            strSQL = strSQL & "(SELECT DISTINCT [Manufacturer] FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])"
            strSQL = strSQL & " UNION ALL "
            strSQL = strSQL & "SELECT DISTINCT [Manufacturer] FROM [NPAData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ") AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])) ORDER BY 1"
        Else
            strSQL = "SELECT DISTINCT [Manufacturer] From"
            strSQL = strSQL & "(SELECT DISTINCT [Manufacturer] FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ")"
            strSQL = strSQL & " UNION ALL "
            strSQL = strSQL & "SELECT DISTINCT [Manufacturer] FROM [NPAData$] WHERE Molecule IN (" & strMolecules & ") AND Product IN(" & strGenerics & ")) ORDER BY 1"
        End If
        Set rs = CreateObject("ADODB.RecordSet")
        rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
        .Range("V1").CopyFromRecordset rs
        Set rs = Nothing
    End With
    
    With wks_NSPData
        intCol = Application.WorksheetFunction.CountA(.Range("A:A"))
        .Range("AA2:AA" & intCol).Formula = "=ISERROR(MATCH(A2,IMSVars!J:J,0))"
        .Range("AB2:AB" & intCol).Formula = "=ISERROR(MATCH(D2,IMSVars!M:M,0))"
        .Range("AC2:AC" & intCol).Formula = "=ISERROR(MATCH(D2,IMSVars!P:P,0))"
        
        .Calculate
        
        .Range("AA2:AC" & intCol).Value = .Range("AA2:AC" & intCol).Value
    End With
    With wks_NPAData
        intCol = Application.WorksheetFunction.CountA(.Range("A:A"))
        .Range("AA2:AA" & intCol).Formula = "=ISERROR(MATCH(A2,IMSVars!J:J,0))"
        .Range("AB2:AB" & intCol).Formula = "=ISERROR(MATCH(D2,IMSVars!M:M,0))"
        .Range("AC2:AC" & intCol).Formula = "=ISERROR(MATCH(D2,IMSVars!P:P,0))"
        
        .Calculate
        
        .Range("AA2:AC" & intCol).Value = .Range("AA2:AC" & intCol).Value
    End With
    
    If blnMolecule Then
        Call Brand_Summary
    Else
        Call OverAll_Summary
    End If
Call Application_Events_Handler(True)
    Unload Me
End Sub

Private Sub lstForms_Change()
    Dim strProduct As String, intStart As Integer
    If blnFlag = True Then Exit Sub
    blnFlag = True
    intStart = lstForms.ListIndex
    strProduct = lstForms.List(intStart)
    If Left(strProduct, 4) <> "    " Then
        For intLoop = intStart + 1 To lstForms.ListCount - 1
            If Left(lstForms.List(intLoop), 4) <> "    " Then
                Exit For
            Else
                lstForms.Selected(intLoop) = lstForms.Selected(intStart)
            End If
        Next intLoop
    Else
        For intLoop = intStart - 1 To 0 Step -1
            If Left(lstForms.List(intLoop), 4) <> "    " Then
                If lstForms.Selected(intStart) = False Then
                    lstForms.Selected(intLoop) = False
                End If
                Exit For
            Else
                
            End If
        Next intLoop
    End If
    blnFlag = False
End Sub

Private Sub UserForm_Activate()
    intCol = Application.WorksheetFunction.CountA(wks_Unique.Range("J:J"))
    lstMolecules.Clear
    For intLoop = 1 To intCol
        lstMolecules.AddItem wks_Unique.Range("J" & intLoop).Value
    Next intLoop
    
    intCol = Application.WorksheetFunction.CountA(wks_Repack.Range("A:A"))
    lstRepack.Clear
    For intLoop = 2 To intCol
        lstRepack.AddItem wks_Repack.Range("A" & intLoop).Value
    Next intLoop
    lstRepack.Enabled = False
End Sub
