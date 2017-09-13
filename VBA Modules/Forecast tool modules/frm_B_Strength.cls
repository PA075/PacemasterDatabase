VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_B_Strength 
   Caption         =   "Strength Summary"
   ClientHeight    =   1125
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   3900
   OleObjectBlob   =   "frm_B_Strength.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_B_Strength"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim rs As Object
Dim strSQL As String
Dim intLoop As Integer
Dim intCol As Integer

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_OK_Click()
Call Application_Events_Handler(False)
    wks_IMSVars.Range("S:S").ClearContents
    If wks_IMSVars.Range("G1").Value Then
        strSQL = "SELECT DISTINCT [Form/Strength] From"
        strSQL = strSQL & "(SELECT DISTINCT [Form/Strength] FROM [NSPData$] WHERE Product ='" & cmb_Product.Text & "' AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])"
        strSQL = strSQL & " UNION ALL "
        strSQL = strSQL & "SELECT DISTINCT [Form/Strength] FROM [NPAData$] WHERE Product ='" & cmb_Product.Text & "' AND Manufacturer NOT IN (SELECT [Repackager] FROM [Repack$])) ORDER BY 1"
    Else
        strSQL = "SELECT DISTINCT [Form/Strength] From"
        strSQL = strSQL & "(SELECT DISTINCT [Form/Strength] FROM [NSPData$] WHERE Product ='" & cmb_Product.Text & "'"
        strSQL = strSQL & " UNION ALL "
        strSQL = strSQL & "SELECT DISTINCT [Form/Strength] FROM [NPAData$] WHERE Product ='" & cmb_Product.Text & "') ORDER BY 1"
    End If
    Set rs = CreateObject("ADODB.RecordSet")
    rs.Open strSQL, Excel_Connection_String(ThisWorkbook.FullName)
    wks_IMSVars.Range("S1").CopyFromRecordset rs
    Set rs = Nothing
    Call Brand_Strength_Summary
    wks_B_Strength.Activate
    wks_B_Strength.Range("A6").Select
Call Application_Events_Handler(True)
End Sub

Private Sub UserForm_Activate()
    intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("M:M"))
    For intLoop = 1 To intCol
        cmb_Product.AddItem wks_IMSVars.Range("M" & intLoop).Value
    Next intLoop
    intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("P:P"))
    For intLoop = 1 To intCol
        cmb_Product.AddItem wks_IMSVars.Range("P" & intLoop).Value
    Next intLoop
    cmb_Product.ListIndex = 0
End Sub

