VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Assumptions 
   Caption         =   "Assumptions"
   ClientHeight    =   6990
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   7800
   OleObjectBlob   =   "frm_Assumptions.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Assumptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_Save_Click()
    Dim intRow As Integer
    
    intRow = wks_Vars.Range("CD11").Value
    
    wks_Assumptions.Range("D" & intRow).Value = TextBox1.Text
    wks_Assumptions.Range("D" & intRow + 1).Value = TextBox2.Text
    wks_Assumptions.Range("D" & intRow + 2).Value = TextBox3.Text
    wks_Assumptions.Range("D" & intRow + 3).Value = TextBox4.Text
    wks_Assumptions.Range("D" & intRow + 4).Value = TextBox5.Text
    wks_Assumptions.Range("D" & intRow + 5).Value = TextBox6.Text
    wks_Assumptions.Range("D" & intRow + 6).Value = TextBox7.Text
    wks_Assumptions.Range("D" & intRow + 7).Value = TextBox8.Text
    wks_Assumptions.Range("D" & intRow + 8).Value = TextBox9.Text
    wks_Assumptions.Range("D" & intRow + 9).Value = TextBox10.Text
    wks_Assumptions.Range("D" & intRow + 10).Value = TextBox11.Text
    
    wks_Assumptions.Range("C" & intRow).Value = "Epidemiology"
    wks_Assumptions.Range("C" & intRow + 1).Value = "Historical Data"
    wks_Assumptions.Range("C" & intRow + 2).Value = "Compliance"
    wks_Assumptions.Range("C" & intRow + 3).Value = "Dosing"
    wks_Assumptions.Range("C" & intRow + 4).Value = "DoT"
    wks_Assumptions.Range("C" & intRow + 5).Value = "Pricing"
    wks_Assumptions.Range("C" & intRow + 6).Value = "Market Access"
    wks_Assumptions.Range("C" & intRow + 7).Value = "GTN"
    wks_Assumptions.Range("C" & intRow + 8).Value = "Patients and Product Shares"
    wks_Assumptions.Range("C" & intRow + 9).Value = "Events"
    wks_Assumptions.Range("C" & intRow + 10).Value = "Prob. Adjustment"
End Sub

Private Sub UserForm_Activate()
    Dim intRow As Integer
    
    intRow = wks_Vars.Range("CD11").Value
    
    TextBox1.Text = wks_Assumptions.Range("D" & intRow).Value
    TextBox2.Text = wks_Assumptions.Range("D" & intRow + 1).Value
    TextBox3.Text = wks_Assumptions.Range("D" & intRow + 2).Value
    TextBox4.Text = wks_Assumptions.Range("D" & intRow + 3).Value
    TextBox5.Text = wks_Assumptions.Range("D" & intRow + 4).Value
    TextBox6.Text = wks_Assumptions.Range("D" & intRow + 5).Value
    TextBox7.Text = wks_Assumptions.Range("D" & intRow + 6).Value
    TextBox8.Text = wks_Assumptions.Range("D" & intRow + 7).Value
    TextBox9.Text = wks_Assumptions.Range("D" & intRow + 8).Value
    TextBox10.Text = wks_Assumptions.Range("D" & intRow + 9).Value
    TextBox11.Text = wks_Assumptions.Range("D" & intRow + 10).Value
    
    lbl_Country.Caption = wks_Vars.Range("V4").Value
    lbl_Scenario.Caption = wks_Vars.Range("V5").Value
End Sub
