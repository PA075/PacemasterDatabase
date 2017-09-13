VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "wks_Consolidator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit

Private Sub Worksheet_Calculate()
    ActiveSheet.ScrollArea = ""
    wks_Consolidator.ScrollArea = ""
End Sub

Private Sub Worksheet_Change(ByVal Target As Range)
    ActiveSheet.ScrollArea = ""
    
End Sub
