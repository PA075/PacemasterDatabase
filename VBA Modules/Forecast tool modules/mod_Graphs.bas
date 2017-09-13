Attribute VB_Name = "mod_Graphs"
Option Explicit

'=SUMIFS(OutputData!G:G,OutputData!$B:$B,Vars!$BV$2,OutputData!$C:$C,$F7,OutputData!$D:$D,Vars!$BV$4,OutputData!$F:$F,Vars!$BV$3)

Function Activate_GraphSheet()
    Call Application_Event_Handler(False)
    With wks_Graphs
        .Range("G7:RR9").ClearContents
        .Range("G7:RR9").EntireColumn.Hidden = False
        
        .Range("G7").Formula = "=SUMIFS(OutputData!G:G,OutputData!$B:$B,Vars!$BV$2,OutputData!$C:$C,$F7,OutputData!$D:$D,Vars!$BV$4,OutputData!$F:$F,Vars!$BV$3)"
        .Range("G7").Copy
        .Range("G7:" & wks_Vars.Range("J8").Value & "9").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        .Calculate
        .Range("G7:" & wks_Vars.Range("J8").Value & "9").Value = .Range("G7:" & wks_Vars.Range("J8").Value & "9").Value
        
        .Range(.Cells(1, wks_Vars.Range("J6").Value + 1), .Cells(1, 486)).EntireColumn.Hidden = True
        
        .Activate
        On Error Resume Next
        .Range("G7").Select
    End With
    Call Application_Event_Handler(True)
End Function

Function Graph_Product_Change()
    
End Function

Function Hide_All_Shapes_Graphs()
    With wks_Graphs
        .Shapes("shp_Country").Visible = msoFalse
        .Shapes("drp_Country").Visible = msoFalse
        
        .Shapes("shp_Products").Visible = msoFalse
        .Shapes("drp_Products").Visible = msoFalse
        
        .Shapes("shp_Parameter").Visible = msoFalse
        .Shapes("drp_Parameter").Visible = msoFalse
    End With
End Function
