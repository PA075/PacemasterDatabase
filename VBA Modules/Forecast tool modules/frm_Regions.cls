VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Regions 
   Caption         =   "Market Definition"
   ClientHeight    =   6090
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   13590
   OleObjectBlob   =   "frm_Regions.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Regions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmd_Save_Click()

    Dim intRow As Integer, intCol As Integer, intCount As Integer
    intCount = 1
    For intCol = 7 To 16
        For intRow = 14 To 65
            wks_Region.Cells(intRow, intCol) = Me.Controls("CheckBox" & intCount).Value
            intCount = intCount + 1
        Next intRow
    Next intCol
        intRow = 13
        intCount = 1
    For intCol = 7 To 16
            wks_Region.Cells(intRow, intCol) = Me.Controls("txt_" & intCount).Value
            intCount = intCount + 1
    Next intCol

    Unload Me
End Sub

Private Sub scrl_Ctrys_Change()
    Call Country_Scroll
    txt_Dummy.SetFocus
End Sub

Private Sub UserForm_Initialize()
    Dim intRow As Integer, intCol As Integer, intCount As Integer
    For intRow = 14 To 65
        Me.Controls("TextBox" & intRow - 13).Text = wks_Region.Range("F" & intRow).Value
    Next intRow
    For intRow = 7 To 16
        Me.Controls("txt_" & intRow - 6).Text = wks_Region.Cells(13, intRow)
    Next intRow
    intCount = 1
    For intCol = 7 To 16
        For intRow = 14 To 65
            Me.Controls("CheckBox" & intCount).Value = wks_Region.Cells(intRow, intCol)
            intCount = intCount + 1
        Next intRow
    Next intCol
    scrl_Ctrys.Value = 0
    Call Country_Scroll
End Sub

Function Country_Scroll()
    Dim intLoop As Integer
    Dim intValue As Integer
    Dim intStart As Integer
    Dim intTop As Integer
    intValue = scrl_Ctrys.Value
    intStart = intValue + 1

    For intLoop = 1 To 52
        Me.Controls("TextBox" & intLoop).Visible = False
        Me.Controls("CheckBox" & intLoop).Visible = False
        Me.Controls("CheckBox" & intLoop + 52).Visible = False
        Me.Controls("CheckBox" & intLoop + 104).Visible = False
        Me.Controls("CheckBox" & intLoop + 156).Visible = False
        Me.Controls("CheckBox" & intLoop + 208).Visible = False
        Me.Controls("CheckBox" & intLoop + 260).Visible = False
        Me.Controls("CheckBox" & intLoop + 312).Visible = False
        Me.Controls("CheckBox" & intLoop + 364).Visible = False
        Me.Controls("CheckBox" & intLoop + 416).Visible = False
        Me.Controls("CheckBox" & intLoop + 468).Visible = False
    Next intLoop

    intTop = 66
    For intLoop = intStart To intStart + 9
        Me.Controls("TextBox" & intLoop).Visible = True
        Me.Controls("CheckBox" & intLoop).Visible = True
        Me.Controls("CheckBox" & intLoop + 52).Visible = True
        Me.Controls("CheckBox" & intLoop + 104).Visible = True
        Me.Controls("CheckBox" & intLoop + 156).Visible = True
        Me.Controls("CheckBox" & intLoop + 208).Visible = True
        Me.Controls("CheckBox" & intLoop + 260).Visible = True
        Me.Controls("CheckBox" & intLoop + 312).Visible = True
        Me.Controls("CheckBox" & intLoop + 364).Visible = True
        Me.Controls("CheckBox" & intLoop + 416).Visible = True
        Me.Controls("CheckBox" & intLoop + 468).Visible = True

        Me.Controls("TextBox" & intLoop).Top = intTop
        Me.Controls("CheckBox" & intLoop).Top = intTop
        Me.Controls("CheckBox" & intLoop + 52).Top = intTop
        Me.Controls("CheckBox" & intLoop + 104).Top = intTop
        Me.Controls("CheckBox" & intLoop + 156).Top = intTop
        Me.Controls("CheckBox" & intLoop + 208).Top = intTop
        Me.Controls("CheckBox" & intLoop + 260).Top = intTop
        Me.Controls("CheckBox" & intLoop + 312).Top = intTop
        Me.Controls("CheckBox" & intLoop + 364).Top = intTop
        Me.Controls("CheckBox" & intLoop + 416).Top = intTop
        Me.Controls("CheckBox" & intLoop + 468).Top = intTop

        Me.Controls("TextBox" & intLoop).Left = 12
        Me.Controls("CheckBox" & intLoop).Left = 132
        Me.Controls("CheckBox" & intLoop + 52).Left = 186
        Me.Controls("CheckBox" & intLoop + 104).Left = 240
        Me.Controls("CheckBox" & intLoop + 156).Left = 294
        Me.Controls("CheckBox" & intLoop + 208).Left = 348
        Me.Controls("CheckBox" & intLoop + 260).Left = 402
        Me.Controls("CheckBox" & intLoop + 312).Left = 456
        Me.Controls("CheckBox" & intLoop + 364).Left = 510
        Me.Controls("CheckBox" & intLoop + 416).Left = 564
        Me.Controls("CheckBox" & intLoop + 468).Left = 618

        intTop = intTop + 24
    Next intLoop
End Function

