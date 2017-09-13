Attribute VB_Name = "BDL_PipeLine"
Option Explicit

Function Create_BDL_Pipeline_Volume()
    Call BDL_Pipeline_Hide_Unhide
    Call BDL_Pipeline_Formula
End Function

Function BDL_Pipeline_Hide_Unhide()
Dim intRng As Integer, intComp As Integer
Dim intLoop As Integer
intRng = 9 + wks_Vars.Range("N2").Value
intComp = wks_M_List.Range("K" & intRng).Value
    With wks_Forecast
        .Range("A11:A260").EntireRow.Hidden = False
        .Range("A13:A86").EntireRow.Hidden = True
'        .Range("F50:NB64").Interior.Color = RGB(255, 255, 255)
'        .Range("G14:NB28").Interior.Color = RGB(255, 255, 255)
'        .Range("G70:NB84").Interior.Color = RGB(255, 255, 255)
            For intLoop = 1 To 15
                .Shapes("chk_" & intLoop).Visible = False
            Next intLoop
''            For intLoop = 1 To intComp
''                .Shapes("chk_" & intLoop).Visible = True
''            Next intLoop
            If wks_M_List.Range("B8").Value = "Units" Then
                .Range("A49:A" & intComp + 49).EntireRow.Hidden = False
                .Range("A65:A68").EntireRow.Hidden = False
                .Range("A69:A" & intComp + 69).EntireRow.Hidden = False
                .Range("A85:A88").EntireRow.Hidden = False
'                .Range("G50:NB64").ClearContents
                .Range("F50:" & wks_Vars.Range("K2").Value & "64").Interior.Color = RGB(255, 255, 204)
                .Range("F65:NB65").Interior.Color = RGB(255, 255, 255)
'                .Range("G14:" & wks_Vars.Range("K4").Value & "28").Interior.Color = RGB(255, 255, 204)
'                 .Range("G70:" & wks_Vars.Range("K4").Value & "84").Interior.Color = RGB(255, 255, 204)
            Else
                .Range("A13:A" & intComp + 13).EntireRow.Hidden = False
                .Range("A29:A30").EntireRow.Hidden = False
                .Range("A31:A" & intComp + 31).EntireRow.Hidden = False
                .Range("A47:A48").EntireRow.Hidden = False
                .Range("A49:A" & intComp + 49).EntireRow.Hidden = False
                .Range("A65:A68").EntireRow.Hidden = False
                .Range("A69:A" & intComp + 69).EntireRow.Hidden = False
                .Range("A85:A86").EntireRow.Hidden = False
                .Range("F50:F64").Formula = "=IF(F32="""","""",F32)"
                .Range("G50:NB64").Formula = "=G14*G32"
                .Range("F50:NB65").Interior.Color = RGB(255, 255, 255)
                .Range("G14:" & wks_Vars.Range("K2").Value & "28").Interior.Color = RGB(255, 255, 204)
                 .Range("G70:" & wks_Vars.Range("K2").Value & "84").Interior.Color = RGB(255, 255, 204)
            End If
        
'        .Range("A47:A47").EntireRow.Hidden = True
        .Range("A66:A67").EntireRow.Hidden = True
        .Range("A86:A87").EntireRow.Hidden = True
        .Range("A90:A90").EntireRow.Hidden = True
'
'        If wks_M_List.Range("G" & intRng).Value = "Market" Then
'            .Range("A92:A92").EntireRow.Hidden = False
'            .Range("A110:A110").EntireRow.Hidden = False
'            .Range("A94:A109").EntireRow.Hidden = True
'            ''.Range("G115:NB115").Formula = "=G114*G91"
'        Else
'            .Range("A92:A92").EntireRow.Hidden = True
'            .Range("A94:A110").EntireRow.Hidden = True
'            ''.Range("F95:F109").Formula = "=IF(F70="""","""",F70)"
'            '.Range("G115:NB115").Formula = "=G114*SUM(G95:G109)"
'        End If
        .Range("F65").Value = "Total Market Units"
        .Range("F29").Value = "Total Market TRx"
        .Range("F85").Value = "Total Market Revenue"
        .Range("A120:A145").EntireRow.Hidden = True
        .Range("A171:A260").EntireRow.Hidden = True
        .Range("A92:A92").EntireRow.Hidden = True
        .Range("A110:A110").EntireRow.Hidden = False
'        .Range("E29").Interior.Color = RGB(225, 225, 225)
'        .Range("E85").Interior.Color = RGB(225, 225, 225)
    End With
    
    wks_Vars.Range("Q8").Value = 0
    wks_Vars.Range("Q9").Value = 0
    
End Function

Function BDL_Pipeline_Formula()  'Apply curve formula's
    With wks_Forecast
        .Range("G29:NB29").Formula = "=SUM(G$14:G$28)"
        .Range("G47:NB47").Formula = "=SUM(G$32:G$46)"
        .Range("G65:NB65").Formula = "=SUM(G$50:G$64)"
        .Range("G85:NB85").Formula = "=SUM(G$70:G$84)"
        .Range("G114:NB114").Formula = "=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
'        .Range("G115:NB115").Formula = "=G114*G110"
        .Range("F32:F46").Formula = "=IF(F14="""","""",F14)"
        .Range("F70:F84").Formula = "=IF(F50="""","""",F50)"
        .Range("A47:A47").EntireRow.Hidden = True
        .Range("G29:NB29").Interior.Color = RGB(255, 255, 255)
        .Range("G47:NB47").Interior.Color = RGB(255, 255, 255)
        .Range("G85:NB85").Interior.Color = RGB(255, 255, 255)
        .Range("G144:NB144").Formula = "=G142*G108"
    End With
End Function
