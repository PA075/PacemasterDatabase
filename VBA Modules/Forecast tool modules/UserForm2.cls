VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm2 
   Caption         =   "UserForm2"
   ClientHeight    =   5025
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   14865
   OleObjectBlob   =   "UserForm2.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "UserForm2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub Image_Close_Click()
    Call Hide_Unhide_Ctrls("", "", "")
End Sub

'-------------------------------------------------------------------------------------------
'HELP MESSAGES
'-------------------------------------------------------------------------------------------
Private Sub Image11_Click()
    Call Hide_Unhide_Ctrls("FairShare", "Fair Share Capture", "Image11")
End Sub
Private Sub Image12_Click()
    Call Hide_Unhide_Ctrls("Sourced", "Sourced Share Capture", "Image12")
End Sub
Private Sub Image13_Click()
    Call Hide_Unhide_Ctrls("Steady", "Steady State Dynamics", "Image13")
End Sub
Private Sub Image14_Click()
    Call Hide_Unhide_Ctrls("Sequence", "Sequential Share Dynamics", "Image14")
End Sub
Private Sub Image15_Click()
    Call Hide_Unhide_Ctrls("Steal", "Share Steal", "Image15")
End Sub

'-------------------------------------------------------------------------------------------
'SECTION SELECTION
'-------------------------------------------------------------------------------------------
Private Sub lbl_2_Click()
    Call Change_Label_Text("lbl_2")
End Sub
Private Sub lbl_3_Click()
    Call Change_Label_Text("lbl_3")
End Sub
Private Sub lbl_4_Click()
    Call Change_Label_Text("lbl_4")
End Sub
Private Sub lbl_5_Click()
    Call Change_Label_Text("lbl_5")
End Sub
Private Sub lbl_6_Click()
    Call Change_Label_Text("lbl_6")
End Sub
Private Sub lbl_7_Click()
    Call Change_Label_Text("lbl_7")
End Sub

Function Change_Label_Text(ctrl_Name As String)
    lbl_2.Caption = ""
    lbl_3.Caption = ""
    lbl_4.Caption = ""
    lbl_5.Caption = ""
    lbl_6.Caption = ""
    
    lbl_2.BorderStyle = fmBorderStyleSingle
    lbl_2.BackColor = &HFFFFFF
    lbl_3.BorderStyle = fmBorderStyleSingle
    lbl_3.BackColor = &HFFFFFF
    lbl_4.BorderStyle = fmBorderStyleSingle
    lbl_4.BackColor = &HFFFFFF
    lbl_5.BorderStyle = fmBorderStyleSingle
    lbl_5.BackColor = &HFFFFFF
    lbl_6.BorderStyle = fmBorderStyleSingle
    lbl_6.BackColor = &HFFFFFF
    
    Me.Controls(ctrl_Name).Caption = "P"
    Me.Controls(ctrl_Name).BorderStyle = fmBorderStyleSingle
    Me.Controls(ctrl_Name).BackColor = &H8000&
    Me.Controls(ctrl_Name).ForeColor = &HFFFFFF
End Function



Private Sub UserForm_Activate()
    Call Hide_Unhide_Ctrls("FairShare", "Fair Share Capture", "Image11")
    Call Change_Label_Text("lbl_2")
End Sub

Function Hide_Unhide_Ctrls(strImage As String, strCaption As String, strHelp As String)
    Analog.Visible = False
    Event_Impact.Visible = False
    Single_Product.Visible = False
    FairShare.Visible = False
    Sequence.Visible = False
    Sourced.Visible = False
    Steady.Visible = False
    Steal.Visible = False
    
    lbl_Header.Visible = False
    Image_Close.Visible = False
    
    Image11.Visible = True
    Image12.Visible = True
    Image13.Visible = True
    Image14.Visible = True
    Image15.Visible = True
    
    Me.Controls(strHelp).Visible = False
    Image16.Top = Me.Controls(strHelp).Top - 3
    If strImage <> "" Then
        Me.Controls(strImage).Visible = True
        lbl_Header.Visible = True
        lbl_Header.Caption = strCaption
''        Image_Close.Visible = True
        
''        lbl_Header.Left = 2
''        lbl_Header.Top = 84
''
''        Me.Controls(strImage).Left = 10
''        Me.Controls(strImage).Top = 120
''
''        Image_Close.Left = 50
''        Image_Close.Top = 84
    End If
End Function

