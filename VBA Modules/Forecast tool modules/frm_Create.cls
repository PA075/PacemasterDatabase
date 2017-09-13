VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Create 
   Caption         =   "Create Project"
   ClientHeight    =   5805
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   13080
   OleObjectBlob   =   "frm_Create.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Create"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim rs As Object
Dim strSQL As String

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_Products_Click()
    Dim intLoop As Integer
    Dim strMolecules As String
    strMolecules = ""
    For intLoop = 0 To lstMolecules.ListCount - 1
        If lstMolecules.Selected(intLoop) Then
            If strMolecules <> "" Then strMolecules = strMolecules & ","
            strMolecules = strMolecules & "'" & lstMolecules.List(intLoop) & "'"
        End If
    Next intLoop
    If strMolecules = "" Then
        MsgBox "No molecules selected", vbInformation + vbOKOnly, "PharmaACE"
        Exit Sub
    End If
    
    lstProducts.Clear
    strSQL = "SELECT DISTINCT Product FROM [NSPData$] WHERE Molecule IN (" & strMolecules & ")"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    On Error GoTo NoList
    rs.movefirst
    While Not rs.EOF
        lstProducts.AddItem rs.Fields(0).Value
        rs.movenext
    Wend
    rs.Close
    Set rs = Nothing
    Exit Sub
NoList:
    MsgBox "No Products Found", vbInformation + vbOKOnly, "PharmaACE"
End Sub

Private Sub cmd_SKU_Click()
    Dim intLoop As Integer
    Dim strProducts As String
    strProducts = ""
    For intLoop = 0 To lstProducts.ListCount - 1
        If lstProducts.Selected(intLoop) Then
            If strProducts <> "" Then strProducts = strProducts & ","
            strProducts = strProducts & "'" & lstProducts.List(intLoop) & "'"
        End If
    Next intLoop
    If strProducts = "" Then
        MsgBox "No Products selected", vbInformation + vbOKOnly, "PharmaACE"
        Exit Sub
    End If
    
    lstSKU.Clear
    strSQL = "SELECT DISTINCT [Form/Strength] FROM [NSPData$] WHERE Product IN (" & strProducts & ")"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    On Error GoTo NoList
    rs.movefirst
    While Not rs.EOF
        lstSKU.AddItem rs.Fields(0).Value
        rs.movenext
    Wend
    rs.Close
    Set rs = Nothing
    Exit Sub
NoList:
    MsgBox "No SKU Found", vbInformation + vbOKOnly, "PharmaACE"
End Sub

Private Sub UserForm_Activate()
    strSQL = "SELECT DISTINCT Molecule FROM [NSPData$]"
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    On Error GoTo NoList
    rs.movefirst
    While Not rs.EOF
        lstMolecules.AddItem rs.Fields(0).Value
        rs.movenext
    Wend
    rs.Close
    Set rs = Nothing
    Exit Sub
NoList:
    MsgBox "No Molecules Found", vbInformation + vbOKOnly, "PharmaACE"
End Sub

