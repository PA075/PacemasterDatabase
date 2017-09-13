VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_G_Strength 
   Caption         =   "Strength Selection"
   ClientHeight    =   5475
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   4035
   OleObjectBlob   =   "frm_G_Strength.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_G_Strength"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim intLoop As Integer, intCol As Integer

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_M_S_Click()
    For intLoop = 0 To lstSKU.ListCount - 1
        lstSKU.Selected(intLoop) = True
    Next intLoop
End Sub

Private Sub cmd_M_U_Click()
    For intLoop = 0 To lstSKU.ListCount - 1
        lstSKU.Selected(intLoop) = False
    Next intLoop
End Sub

Private Sub cmd_OK_Click()
    intCol = 0
    For intLoop = 0 To lstSKU.ListCount - 1
        If lstSKU.Selected(intLoop) Then intCol = intCol + 1
    Next intLoop
    
    If intCol = 0 Then
        MsgBox "Please select atleast one Strength", vbInformation + vbOKOnly, "PharmaACE"
        Exit Sub
    End If
    
    Call Application_Events_Handler(False)
    wks_IMSVars.Range("S:S").Clear
    intCol = 1
    For intLoop = 0 To lstSKU.ListCount - 1
        If lstSKU.Selected(intLoop) Then
            wks_IMSVars.Range("S" & intCol).Value = lstSKU.List(intLoop)
            intCol = intCol + 1
        End If
    Next intLoop
    Call Strength_Summary
    Call Application_Events_Handler(True)
    Unload Me
End Sub

Private Sub UserForm_Activate()
    intCol = Application.WorksheetFunction.CountA(wks_IMSVars.Range("S:S"))
    For intLoop = 1 To intCol
        lstSKU.AddItem wks_IMSVars.Range("S" & intLoop).Value
    Next intLoop
End Sub
