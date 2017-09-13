Attribute VB_Name = "mod_Summary"
Option Explicit

Function Activate_Summary()
Dim i As Integer
Dim shpCaller As String
Application_Events_Handler (False)
 shpCaller = Application.Caller
    With wks_Vars
        .Range("B18").Value = .Range("AF2").Value
        .Range("B20").Value = .Range("AJ2").Value
        .Calculate
    End With
    'company combobox
    If shpCaller = "DD_Summary" Then
        With wks_Summary.Shapes("cb_Comp").ControlFormat
            .RemoveAllItems
            For i = 1 To wks_M_List.Range("K" & 9 + wks_Vars.Range("AF2").Value).Value
                .AddItem wks_Backup_Data.Range("E" & wks_Vars.Range("I22").Value + i - 1 + 100).Value
            Next i
            .DropDownLines = i - 1
            .ListIndex = 1
        End With
        Call SKU_Rnange_DropDwon
    End If
    
Application_Events_Handler (True)
End Function

Function DropDwon_Prod()
Dim strRng As String, intRng As Integer

    With wks_Summary
    
        intRng = wks_M_List.Range("C9").Value
        strRng = "Master_List!" & wks_M_List.Range(wks_M_List.Cells(10, 2), wks_M_List.Cells(9 + intRng, 2)).Address
        With wks_Summary.Shapes("DD_Summary").ControlFormat
            .ListFillRange = strRng
        End With
        
        wks_Vars.Range("AI2:AI50").ClearContents
        With wks_Summary.Shapes("cmb_Year").ControlFormat
            .RemoveAllItems
            For intRng = 0 To wks_M_List.Range("C7").Value - wks_M_List.Range("C5").Value
                .AddItem wks_M_List.Range("C5").Value + intRng
                wks_Vars.Range("AI" & intRng + 2).Value = wks_M_List.Range("C5").Value + intRng
            Next intRng
        End With
        With wks_Summary.Shapes("cb_Comp").ControlFormat
            .RemoveAllItems
            For intRng = 1 To wks_M_List.Range("K" & 10).Value
                .AddItem wks_Forecast.Range("F" & 13 + intRng).Value
            Next intRng
            '.DropDownLines = intRng - 1
            .ListIndex = 1
        End With
    End With
    
End Function

Function Activate_Summary_Sheet()
Dim i As Integer
Application_Events_Handler (False)
Call BackUp_data
    wks_Vars.Range("B18").Value = 1
    wks_Vars.Range("B20").Value = 2
    wks_Vars.Range("B22").Value = 3
    wks_Vars.Calculate
    Call DropDwon_Prod
    wks_Vars.Range("N29").Value = 1
        With wks_Summary.Shapes("cb_Comp").ControlFormat
            .RemoveAllItems
            For i = 1 To wks_M_List.Range("K" & 9 + wks_Vars.Range("AF2").Value).Value
                .AddItem wks_Backup_Data.Range("E" & wks_Vars.Range("I22").Value + i - 1 + 100).Value
            Next i
            .DropDownLines = i - 1
            .ListIndex = 1
        End With
        Call SKU_Rnange_DropDwon
    Call Activate_Summary
    wks_Summary.Activate
Application_Events_Handler (True)
End Function
