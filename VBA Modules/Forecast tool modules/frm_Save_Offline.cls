VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Save_Offline 
   Caption         =   "Save Forecast"
   ClientHeight    =   1875
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   5085
   OleObjectBlob   =   "frm_Save_Offline.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Save_Offline"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_Save_Click()
    If txt_Save.Text = "" Then
        MsgBox "Project name cannot be empty", vbInformation + vbOKOnly, "PharmaACE"
        Exit Sub
    End If
    Call Save_Offline_Version_Forecast
    Unload Me
End Sub

Private Sub UserForm_Activate()
    txt_Save.Text = wks_Vars.Range("A2").Value
    opt_Major.Value = True
End Sub
