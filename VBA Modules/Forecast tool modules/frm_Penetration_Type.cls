VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Penetration_Type 
   Caption         =   "Penetration Type"
   ClientHeight    =   1260
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4410
   OleObjectBlob   =   "frm_Penetration_Type.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Penetration_Type"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CommandButton1_Click()
    Dim intType As Integer
    
    intType = Me.ComboBox1.ListIndex + 1
    
    Unload Me
    If intType = 1 Then
        wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
        wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1
    ElseIf intType = 3 Then
        wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 3
        wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
        frm_Trending.Show
    ElseIf intType = 2 Then
        wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 2
        wks_Forecast.Range("G114:NB114").Value = ""
        wks_Forecast.Range("G114:" & wks_Vars.Range("K2").Value & 114).Formula = "=G67"
        wks_Forecast.Range("" & wks_Vars.Range("L2").Value & 114 & ":NB114").Interior.Color = RGB(255, 255, 204)
    End If
End Sub

Private Sub CommandButton2_Click()
    Unload Me
End Sub

Private Sub UserForm_Activate()
    With Me.ComboBox1
        .AddItem "Uptake Calculation"
        .AddItem "Manual"
        If wks_Product_Details.Range("B" & wks_Vars1.Range("N1").Value + 1).Value = "Inline" Then .AddItem "Trending"
        If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
            .ListIndex = 0
        Else
            .ListIndex = wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value - 1
        End If
    End With
End Sub
