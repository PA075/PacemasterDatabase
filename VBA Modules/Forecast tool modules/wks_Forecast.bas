VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "wks_Forecast"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit

Private Sub Worksheet_BeforeRightClick(ByVal Target As Range, Cancel As Boolean)
If Target.Address = "H166" Then
   Cancel = True
End If
End Sub
