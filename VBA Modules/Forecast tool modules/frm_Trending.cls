VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Trending 
   Caption         =   "Market Share Trending"
   ClientHeight    =   5100
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   10950
   OleObjectBlob   =   "frm_Trending.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Trending"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmd_Run_Click()
    Dim intRow As Integer, intT As Integer
    Dim strType As String, strSheet As String
    If OptionButton1.Value = True Then
        intRow = 7
        strType = "Linear"
    ElseIf OptionButton2.Value = True Then
        intRow = 8
        strType = "Logarithmic"
    ElseIf OptionButton3.Value = True Then
        intRow = 9
        strType = "Inverse"
    ElseIf OptionButton4.Value = True Then
        intRow = 10
        strType = "Power"
    ElseIf OptionButton5.Value = True Then
        intRow = 11
        strType = "Exponential"
    ElseIf OptionButton6.Value = True Then
        intRow = 12
        strType = "S-Shape"
    Else
        MsgBox "Please select an option", vbInformation + vbOKOnly, "MNK"
        Exit Sub
    End If
   
    strSheet = "Generic_Forecast"
    
    wks_Trending1.Range("C" & intRow & ":NG" & intRow).Copy
    Sheets(strSheet).Range("G114").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
   
    wks_Forecast.Range("G114").Select
    
    Unload Me
End Sub

Private Sub UserForm_Activate()
    Dim objChart As Object
    Dim strFN As String, strPath As String
    Dim intLoop As Integer, intNext As Integer
    Application_Events_Handler (False)
    Call Show_Hide_Ctrls(False)
    DoEvents
    
    With wks_Trending1
        .Range("C4:FN4").ClearContents
        wks_Forecast.Range("G67:" & wks_Vars.Range("K2").Value & 67).Copy
        .Range("C4").PasteSpecial xlPasteValues
        'SECOND DATA POINT
            For intLoop = 1 To 360
                 If wks_Forecast.Cells(67, intLoop + 6).Value <> 0 Then
                     wks_Vars.Range("O6").Value = wks_Forecast.Cells(67, intLoop + 6).Address
                     wks_Vars.Range("O8").Value = intLoop + 2
                     Exit For
                 End If
            Next intLoop
            intNext = 1
            For intLoop = wks_Vars.Range("O8").Value To 360
                 .Cells(2, intLoop).Value = intNext
                 intNext = intNext + 1
            Next intLoop
            wks_Vars.Calculate
   
'Call Application_Events_Handler(False)
        .Range("C7:MX12").ClearContents
        .Range("C7").Formula = "=Apply_Curve($C$3:$" & wks_Vars.Range("H2").Value & "$3,$C$4:$" & wks_Vars.Range("H2").Value & "$4,C$2,$B7)"
        .Range("C7").Copy
        .Range("C7:" & wks_Vars.Range("H1").Value & "12").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        .Range("C7:MX12").Calculate
        .Range("C7:MX12").Value = .Range("C7:MX12").Value
        .Range("C7:MX12").NumberFormat = "0%"
        
        Set objChart = .ChartObjects("cht_Export")
        strFN = ThisWorkbook.Path & "\temp00000.GIF"
        On Error Resume Next
        Kill strFN
        On Error GoTo 0
        objChart.Chart.Export strFN, "GIF"
        With frm_Trending
            .imgChart.Picture = LoadPicture(strFN)
        End With
        On Error Resume Next
            Kill strFN
        On Error GoTo 0
    End With
    
    Call Show_Hide_Ctrls(True)
    DoEvents
    OptionButton2.Value = True
Application_Events_Handler (True)
End Sub

Function Show_Hide_Ctrls(blnValue As Boolean)
    imgChart.Visible = blnValue
    OptionButton1.Visible = blnValue
    OptionButton2.Visible = blnValue
    OptionButton3.Visible = blnValue
    OptionButton4.Visible = blnValue
    OptionButton5.Visible = blnValue
    OptionButton6.Visible = blnValue
    cmd_Run.Visible = blnValue
    
    Label1.Visible = Not blnValue
End Function

