VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Create_Forecast 
   ClientHeight    =   6660
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   17700
   OleObjectBlob   =   "frm_Create_Forecast.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Create_Forecast"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim intLoop As Integer

Private Sub chk_1_Click()
    Call Segment_1_Selection
End Sub
Private Sub chk_2_Click()
    Call Segment_2_Selection
End Sub
Private Sub chk_3_Click()
    Call Segment_3_Selection
End Sub
Private Sub chk_4_Click()
    Call Segment_4_Selection
End Sub
Private Sub chk_5_Click()
    Call Segment_5_Selection
End Sub
Private Sub chk_6_Click()
    Call Segment_6_Selection
End Sub
Private Sub chk_7_Click()
    Call Segment_7_Selection
End Sub
Private Sub chk_8_Click()
    Call Segment_8_Selection
End Sub
Private Sub chk_9_Click()
    Call Segment_9_Selection
End Sub
Private Sub chk_10_Click()
    Call Segment_10_Selection
End Sub

Private Sub cmb_Inline_Change()
    Call Inline_Segment_Selection
End Sub

Private Sub cmb_Levels_Change()
    txt_Param_1.Enabled = False
    txt_Param_2.Enabled = False
    txt_Param_3.Enabled = False
    txt_Param_4.Enabled = False
    txt_Param_5.Enabled = False
    txt_Param_6.Enabled = False
    txt_Param_7.Enabled = False
    txt_Param_8.Enabled = False
    txt_Param_9.Enabled = False
    txt_Param_10.Enabled = False
    
    txt_Param_1.BackColor = &HE0E0E0
    txt_Param_2.BackColor = &HE0E0E0
    txt_Param_3.BackColor = &HE0E0E0
    txt_Param_4.BackColor = &HE0E0E0
    txt_Param_5.BackColor = &HE0E0E0
    txt_Param_6.BackColor = &HE0E0E0
    txt_Param_7.BackColor = &HE0E0E0
    txt_Param_8.BackColor = &HE0E0E0
    txt_Param_9.BackColor = &HE0E0E0
    txt_Param_10.BackColor = &HE0E0E0
    
    chk_1.Enabled = False
    chk_2.Enabled = False
    chk_3.Enabled = False
    chk_4.Enabled = False
    chk_5.Enabled = False
    chk_6.Enabled = False
    chk_7.Enabled = False
    chk_8.Enabled = False
    chk_9.Enabled = False
    chk_10.Enabled = False
    
    cmb_S_1.Enabled = False
    cmb_S_2.Enabled = False
    cmb_S_3.Enabled = False
    cmb_S_4.Enabled = False
    cmb_S_5.Enabled = False
    cmb_S_6.Enabled = False
    cmb_S_7.Enabled = False
    cmb_S_8.Enabled = False
    cmb_S_9.Enabled = False
    cmb_S_10.Enabled = False
    
    If cmb_Levels.Value >= 1 Then
        txt_Param_1.Enabled = True
        txt_Param_1.BackColor = &HC0FFFF
        chk_1.Enabled = True
        cmb_S_1.Enabled = True
    
        Call Segment_1_Selection
    End If
    If cmb_Levels.Value >= 2 Then
        txt_Param_2.Enabled = True
        txt_Param_2.BackColor = &HC0FFFF
        chk_2.Enabled = True
        cmb_S_2.Enabled = True
        
        Call Segment_2_Selection
    End If
    If cmb_Levels.Value >= 3 Then
        txt_Param_3.Enabled = True
        txt_Param_3.BackColor = &HC0FFFF
        chk_3.Enabled = True
        cmb_S_3.Enabled = True
        
        Call Segment_3_Selection
    End If
    If cmb_Levels.Value >= 4 Then
        txt_Param_4.Enabled = True
        txt_Param_4.BackColor = &HC0FFFF
        chk_4.Enabled = True
        cmb_S_4.Enabled = True
        
        Call Segment_4_Selection
    End If
    If cmb_Levels.Value >= 5 Then
        txt_Param_5.Enabled = True
        txt_Param_5.BackColor = &HC0FFFF
        chk_5.Enabled = True
        cmb_S_5.Enabled = True
        
        Call Segment_5_Selection
    End If
    If cmb_Levels.Value >= 6 Then
        txt_Param_6.Enabled = True
        txt_Param_6.BackColor = &HC0FFFF
        chk_6.Enabled = True
        cmb_S_6.Enabled = True
        
        Call Segment_6_Selection
    End If
    If cmb_Levels.Value >= 7 Then
        txt_Param_7.Enabled = True
        txt_Param_7.BackColor = &HC0FFFF
        chk_7.Enabled = True
        cmb_S_7.Enabled = True
        
        Call Segment_7_Selection
    End If
    If cmb_Levels.Value >= 8 Then
        txt_Param_8.Enabled = True
        txt_Param_8.BackColor = &HC0FFFF
        chk_8.Enabled = True
        cmb_S_8.Enabled = True
        
        Call Segment_8_Selection
    End If
    If cmb_Levels.Value >= 9 Then
        txt_Param_9.Enabled = True
        txt_Param_9.BackColor = &HC0FFFF
        chk_9.Enabled = True
        cmb_S_9.Enabled = True
        
        Call Segment_9_Selection
    End If
    If cmb_Levels.Value >= 10 Then
        txt_Param_10.Enabled = True
        txt_Param_10.BackColor = &HC0FFFF
        chk_10.Enabled = True
        cmb_S_10.Enabled = True
        
        Call Segment_10_Selection
    End If
End Sub

Private Sub cmb_Pipeline_Change()
    Call Pipeline_Segment_Selection
End Sub

Private Sub cmb_S_1_Change()
    Call Segment_1_Selection
End Sub
Private Sub cmb_S_2_Change()
    Call Segment_2_Selection
End Sub
Private Sub cmb_S_3_Change()
    Call Segment_3_Selection
End Sub
Private Sub cmb_S_4_Change()
    Call Segment_4_Selection
End Sub
Private Sub cmb_S_5_Change()
    Call Segment_5_Selection
End Sub
Private Sub cmb_S_6_Change()
    Call Segment_6_Selection
End Sub
Private Sub cmb_S_7_Change()
    Call Segment_7_Selection
End Sub
Private Sub cmb_S_8_Change()
    Call Segment_8_Selection
End Sub
Private Sub cmb_S_9_Change()
    Call Segment_9_Selection
End Sub
Private Sub cmb_S_10_Change()
    Call Segment_10_Selection
End Sub

Private Sub cmb_Start_Year_Change()
    Dim intI As Integer
    cmb_Till_Year.Clear
    cmb_End_Year.Clear
    
    For intI = cmb_Start_Year.Text To 2016
        cmb_Till_Year.AddItem intI
    Next intI
    cmb_Till_Year.ListIndex = cmb_Till_Year.ListCount - 1
    
    For intI = cmb_Start_Year.Text + 9 To cmb_Start_Year.Text + 35
        cmb_End_Year.AddItem intI
    Next intI
    cmb_End_Year.ListIndex = 0
End Sub

Private Sub cmb_Till_Year_Change()
    cmb_Till_Month.Clear
    If cmb_Till_Year.Text = Year(Now()) Then
        If Month(Now()) > 1 Then cmb_Till_Month.AddItem "Jan"
        If Month(Now()) > 2 Then cmb_Till_Month.AddItem "Feb"
        If Month(Now()) > 3 Then cmb_Till_Month.AddItem "Mar"
        If Month(Now()) > 4 Then cmb_Till_Month.AddItem "Apr"
        If Month(Now()) > 5 Then cmb_Till_Month.AddItem "May"
        If Month(Now()) > 6 Then cmb_Till_Month.AddItem "Jun"
        If Month(Now()) > 7 Then cmb_Till_Month.AddItem "Jul"
        If Month(Now()) > 8 Then cmb_Till_Month.AddItem "Aug"
        If Month(Now()) > 9 Then cmb_Till_Month.AddItem "Sep"
        If Month(Now()) > 10 Then cmb_Till_Month.AddItem "Oct"
        If Month(Now()) > 11 Then cmb_Till_Month.AddItem "Nov"
        If Month(Now()) >= 12 Then cmb_Till_Month.AddItem "Dec"
        cmb_Till_Month.ListIndex = cmb_Till_Month.ListCount - 1
    Else
        cmb_Till_Month.AddItem "Jan"
        cmb_Till_Month.AddItem "Feb"
        cmb_Till_Month.AddItem "Mar"
        cmb_Till_Month.AddItem "Apr"
        cmb_Till_Month.AddItem "May"
        cmb_Till_Month.AddItem "Jun"
        cmb_Till_Month.AddItem "Jul"
        cmb_Till_Month.AddItem "Aug"
        cmb_Till_Month.AddItem "Sep"
        cmb_Till_Month.AddItem "Oct"
        cmb_Till_Month.AddItem "Nov"
        cmb_Till_Month.AddItem "Dec"
        
        cmb_Till_Month.ListIndex = 11
    End If
End Sub

Private Sub cmd_Create_Click()
Dim intRegionCtry As Integer, intRow As Integer
Call Application_Event_Handler(False)
    Call Clear_All_Sheets
    wks_Vars.Range("A2").Clear
    With wks_Vars
        'PROJECT DETAILS
        .Range("A2").Value = txt_Project_Name.Text
        wks_M_List.Range("B2").Formula = "=Vars!A2"
        .Range("C2").Value = Val(cmb_Start_Year.Text)
        If opt_Monthly.Value Then
            .Range("B2").Value = cmb_Start_Month.Text
            .Range("F2").Value = cmb_Till_Month.Text
        Else
            .Range("B2").Value = "Dec"
            .Range("F2").Value = "Dec"
        End If
        .Range("G2").Value = Val(cmb_Till_Year.Text)
        .Range("D2").Value = "Dec"
        .Range("E2").Value = Val(cmb_End_Year.Text)
        .Range("I2").Value = opt_Monthly.Value
        'INLINE PRODUCTS
        .Range("M1").Value = Val(cmb_Inline.Text)
        .Range("L3").Value = txt_I_1.Text
        .Range("L4").Value = txt_I_2.Text
        .Range("L5").Value = txt_I_3.Text
        .Range("L6").Value = txt_I_4.Text
        .Range("L7").Value = txt_I_5.Text
        .Range("M3").Value = cmb_I_Launch_1.Text
        .Range("M4").Value = cmb_I_Launch_2.Text
        .Range("M5").Value = cmb_I_Launch_3.Text
        .Range("M6").Value = cmb_I_Launch_4.Text
        .Range("M7").Value = cmb_I_Launch_5.Text
        .Range("N3").Value = cmb_I_Expiry_1.Text
        .Range("N4").Value = cmb_I_Expiry_2.Text
        .Range("N5").Value = cmb_I_Expiry_3.Text
        .Range("N6").Value = cmb_I_Expiry_4.Text
        .Range("N7").Value = cmb_I_Expiry_5.Text
        .Range("O3").Value = chk_I_1.Value
        .Range("O4").Value = chk_I_2.Value
        .Range("O5").Value = chk_I_3.Value
        .Range("O6").Value = chk_I_4.Value
        .Range("O7").Value = chk_I_5.Value
        'PIPELINE PRODUCTS
        .Range("R1").Value = Val(cmb_Pipeline.Text)
        .Range("Q3").Value = txt_P_1.Text
        .Range("Q4").Value = txt_P_2.Text
        .Range("Q5").Value = txt_P_3.Text
        .Range("Q6").Value = txt_P_4.Text
        .Range("Q7").Value = txt_P_5.Text
        .Range("R3").Value = cmb_P_Launch_1.Text
        .Range("R4").Value = cmb_P_Launch_2.Text
        .Range("R5").Value = cmb_P_Launch_3.Text
        .Range("R6").Value = cmb_P_Launch_4.Text
        .Range("R7").Value = cmb_P_Launch_5.Text
        .Range("S3").Value = cmb_P_Expiry_1.Text
        .Range("S4").Value = cmb_P_Expiry_2.Text
        .Range("S5").Value = cmb_P_Expiry_3.Text
        .Range("S6").Value = cmb_P_Expiry_4.Text
        .Range("S7").Value = cmb_P_Expiry_5.Text
        .Range("T3").Value = chk_P_1.Value
        .Range("T4").Value = chk_P_2.Value
        .Range("T5").Value = chk_P_3.Value
        .Range("T6").Value = chk_P_4.Value
        .Range("T7").Value = chk_P_5.Value
        
        'COUNTRIES
        .Range("W:W").ClearContents
        If opt_Region.Value Then
            intRow = 2
            intRegionCtry = lst_Ctry_Region.ListIndex + 1
            For intLoop = 1 To wks_Region.Range("G8").Value
                If wks_Region.Cells(intLoop + 13, intRegionCtry + 6) Then
                    .Range("W" & intRow).Value = wks_Region.Range("F" & intLoop + 13).Value
                    intRow = intRow + 1
                End If
            Next intLoop
        Else
            intRow = 2
            For intLoop = 0 To lst_Ctry_Region.ListCount - 1
                If lst_Ctry_Region.Selected(intLoop) Then
                    .Range("W" & intRow).Value = lst_Ctry_Region.List(intLoop)
                    intRow = intRow + 1
                End If
            Next intLoop
        End If
        
        'STRUCTURE
        .Range("AM1").Value = Val(cmb_Levels.Text)
        .Range("AD2:AK11").ClearContents
        For intLoop = 1 To 7
            If Me.Controls("txt_Param_" & intLoop).Text <> "" Then
                .Range("AD" & intLoop + 1).Value = Me.Controls("txt_Param_" & intLoop).Text
                .Range("AE" & intLoop + 1).Value = Me.Controls("chk_" & intLoop).Value
                If .Range("AE" & intLoop + 1).Value Then
                    .Range("AF" & intLoop + 1).Value = Me.Controls("cmb_S_" & intLoop).Text
                Else
                    .Range("AF" & intLoop + 1).Value = 1
                End If
                .Range("AG" & intLoop + 1).Value = Me.Controls("Segment" & intLoop & "1").Text
                .Range("AH" & intLoop + 1).Value = Me.Controls("Segment" & intLoop & "2").Text
                .Range("AI" & intLoop + 1).Value = Me.Controls("Segment" & intLoop & "3").Text
                .Range("AJ" & intLoop + 1).Value = Me.Controls("Segment" & intLoop & "4").Text
                .Range("AK" & intLoop + 1).Value = Me.Controls("Segment" & intLoop & "5").Text
            End If
        Next intLoop
        
        'SOURCE OF BUSINESS OPTION
        If lbl_2.Caption = "P" Then
            wks_Vars.Range("H2").Value = 1
        ElseIf lbl_3.Caption = "P" Then
            wks_Vars.Range("H2").Value = 2
        ElseIf lbl_4.Caption = "P" Then
            wks_Vars.Range("H2").Value = 3
        ElseIf lbl_5.Caption = "P" Then
            wks_Vars.Range("H2").Value = 4
        ElseIf lbl_6.Caption = "P" Then
            wks_Vars.Range("H2").Value = 5
        End If
        
        'INDICATION
        For intLoop = 0 To lst_SelectedIndications.ListCount - 1
            wks_Indication.Range("A" & intLoop + 2).Value = lst_SelectedIndications.List(intLoop)
        Next intLoop
        
        Call Set_All_Sheets
        
    End With
    wks_ForecastFlow.Activate
    Unload Me
Call Application_Event_Handler(True)
End Sub

Private Sub cmd_Next_Click()
If Step_1.Visible = True Then
    Step_1.Visible = False
    Step_2.Visible = False
    Step_3.Visible = True
    cmd_Previous.Visible = True
    
    Call Change_Step_Color("lbl_S2")
ElseIf Step_3.Visible = True Then
    Step_3.Visible = False
    Indication.Visible = True
    cmd_Previous.Visible = True
    Call Change_Step_Color("lbl_S3")
ElseIf Indication.Visible = True Then
    Indication.Visible = False
    Step_4.Visible = True
    cmd_Previous.Visible = True
    Call Change_Step_Color("lbl_S4")
ElseIf Step_4.Visible = True Then
    Step_4.Visible = False
    Step_5.Visible = True
    cmd_Previous.Visible = True
    cmd_Next.Visible = False
    cmd_Create.Visible = True
    Call Change_Step_Color("lbl_S5")
End If
End Sub

Private Sub cmd_Previous_Click()
    If Step_5.Visible = True Then
        Step_5.Visible = False
        Step_4.Visible = True
        cmd_Next.Visible = True
        cmd_Create.Visible = False
        
        Call Change_Step_Color("lbl_S4")
    ElseIf Step_4.Visible = True Then
        Step_4.Visible = False
        Indication.Visible = True
        cmd_Next.Visible = True
        cmd_Create.Visible = False
        
        Call Change_Step_Color("lbl_S3")
    ElseIf Indication.Visible = True Then
        Indication.Visible = False
        Step_3.Visible = True
        cmd_Next.Visible = True
        cmd_Create.Visible = False
        
        Call Change_Step_Color("lbl_S2")
    ElseIf Step_3.Visible = True Then
        Step_1.Visible = True
        Step_2.Visible = True
        Step_3.Visible = False
        cmd_Next.Visible = True
        cmd_Previous.Visible = False
        
        Call Change_Step_Color("lbl_S1")
    End If
End Sub

Function Change_Step_Color(strCtrl As String)
    lbl_S1.BackColor = &HE0E0E0
    lbl_S2.BackColor = &HE0E0E0
    lbl_S3.BackColor = &HE0E0E0
    lbl_S4.BackColor = &HE0E0E0
    lbl_S5.BackColor = &HE0E0E0
    
    Me.Controls(strCtrl).BackColor = &H80FF80
End Function

Private Sub cmd_Region_Mapping_Click()
    frm_Regions.Show
End Sub

Private Sub cmd_Select_Click()
    For intLoop = 0 To lst_Ctry_Region.ListCount - 1
        lst_Ctry_Region.Selected(intLoop) = True
    Next intLoop
End Sub

Private Sub cmd_Unselect_Click()
    For intLoop = 0 To lst_Ctry_Region.ListCount - 1
        lst_Ctry_Region.Selected(intLoop) = False
    Next intLoop
End Sub

Private Sub opt_Country_Click()
    lst_Ctry_Region.Clear
    With wks_Region
        For intLoop = 1 To .Range("G8").Value
            lst_Ctry_Region.AddItem .Range("F" & intLoop + 13).Value
        Next intLoop
    End With
    cmd_Select.Enabled = True
    cmd_Unselect.Enabled = True
    lst_Ctry_Region.MultiSelect = fmMultiSelectMulti
End Sub

Private Sub opt_Monthly_Click()
    cmb_Start_Month.Enabled = True
    cmb_Till_Month.Enabled = True
End Sub

Private Sub opt_Yearly_Click()
    cmb_Start_Month.Enabled = False
    cmb_Till_Month.Enabled = False
End Sub

Private Sub opt_Region_Click()
    lst_Ctry_Region.Clear
    With wks_Region
        For intLoop = 1 To .Range("G7").Value
            lst_Ctry_Region.AddItem .Cells(13, intLoop + 6)
        Next intLoop
    End With
    cmd_Select.Enabled = False
    cmd_Unselect.Enabled = False
    lst_Ctry_Region.MultiSelect = fmMultiSelectSingle
End Sub

Private Sub Image_Close_Click()
    Call Hide_Unhide_Ctrls("", "", "")
End Sub

'-------------------------------------------------------------------------------------------
'HELP MESSAGES
'-------------------------------------------------------------------------------------------
Private Sub Image11_Click()
    Call Hide_Unhide_Ctrls("FairShare", "Fair Share", "Image11")
End Sub
Private Sub Image12_Click()
    Call Hide_Unhide_Ctrls("Sourced", "Peak share with Source of Business", "Image12")
End Sub
Private Sub Image13_Click()
    Call Hide_Unhide_Ctrls("Steady", "Output Share", "Image13")
End Sub
Private Sub Image14_Click()
    Call Hide_Unhide_Ctrls("Sequence", "Sequential Shares", "Image14")
End Sub
Private Sub Image15_Click()
    Call Hide_Unhide_Ctrls("Steal", "Share Theft", "Image15")
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

Private Sub UserForm_Activate()
    cmb_S_1.AddItem "1"
    cmb_S_1.AddItem "2"
    cmb_S_1.AddItem "3"
    cmb_S_1.AddItem "4"
    cmb_S_1.AddItem "5"
    
    cmb_S_1.ListIndex = 0
    
    cmb_S_2.AddItem "1"
    cmb_S_2.AddItem "2"
    cmb_S_2.AddItem "3"
    cmb_S_2.AddItem "4"
    cmb_S_2.AddItem "5"
    
    cmb_S_2.ListIndex = 0
    
    cmb_S_3.AddItem "1"
    cmb_S_3.AddItem "2"
    cmb_S_3.AddItem "3"
    cmb_S_3.AddItem "4"
    cmb_S_3.AddItem "5"
    
    cmb_S_3.ListIndex = 0
    
    cmb_S_4.AddItem "1"
    cmb_S_4.AddItem "2"
    cmb_S_4.AddItem "3"
    cmb_S_4.AddItem "4"
    cmb_S_4.AddItem "5"
    
    cmb_S_4.ListIndex = 0
    
    cmb_S_5.AddItem "1"
    cmb_S_5.AddItem "2"
    cmb_S_5.AddItem "3"
    cmb_S_5.AddItem "4"
    cmb_S_5.AddItem "5"
    
    cmb_S_5.ListIndex = 0
    
    cmb_S_6.AddItem "1"
    cmb_S_6.AddItem "2"
    cmb_S_6.AddItem "3"
    cmb_S_6.AddItem "4"
    cmb_S_6.AddItem "5"
    
    cmb_S_6.ListIndex = 0
    
    cmb_S_7.AddItem "1"
    cmb_S_7.AddItem "2"
    cmb_S_7.AddItem "3"
    cmb_S_7.AddItem "4"
    cmb_S_7.AddItem "5"
    
    cmb_S_7.ListIndex = 0
    
    cmb_S_8.AddItem "1"
    cmb_S_8.AddItem "2"
    cmb_S_8.AddItem "3"
    cmb_S_8.AddItem "4"
    cmb_S_8.AddItem "5"
    
    cmb_S_8.ListIndex = 0
    
    cmb_S_9.AddItem "1"
    cmb_S_9.AddItem "2"
    cmb_S_9.AddItem "3"
    cmb_S_9.AddItem "4"
    cmb_S_9.AddItem "5"
    
    cmb_S_9.ListIndex = 0
    
    cmb_S_10.AddItem "1"
    cmb_S_10.AddItem "2"
    cmb_S_10.AddItem "3"
    cmb_S_10.AddItem "4"
    cmb_S_10.AddItem "5"
    
    cmb_S_10.ListIndex = 0
    
    cmb_Levels.AddItem "1"
    cmb_Levels.AddItem "2"
    cmb_Levels.AddItem "3"
    cmb_Levels.AddItem "4"
    cmb_Levels.AddItem "5"
    cmb_Levels.AddItem "6"
    cmb_Levels.AddItem "7"
    cmb_Levels.AddItem "8"
    cmb_Levels.AddItem "9"
    cmb_Levels.AddItem "10"
    
    cmb_Levels.ListIndex = 0
    
    cmb_Inline.AddItem "0"
    cmb_Inline.AddItem "1"
    cmb_Inline.AddItem "2"
    cmb_Inline.AddItem "3"
    cmb_Inline.AddItem "4"
    cmb_Inline.AddItem "5"
    
    cmb_Inline.ListIndex = 0
    
    cmb_Pipeline.AddItem "0"
    cmb_Pipeline.AddItem "1"
    cmb_Pipeline.AddItem "2"
    cmb_Pipeline.AddItem "3"
    cmb_Pipeline.AddItem "4"
    cmb_Pipeline.AddItem "5"
    
    cmb_Pipeline.ListIndex = 0
    
    cmb_Start_Month.AddItem "Jan"
    cmb_Start_Month.AddItem "Feb"
    cmb_Start_Month.AddItem "Mar"
    cmb_Start_Month.AddItem "Apr"
    cmb_Start_Month.AddItem "May"
    cmb_Start_Month.AddItem "Jun"
    cmb_Start_Month.AddItem "Jul"
    cmb_Start_Month.AddItem "Aug"
    cmb_Start_Month.AddItem "Sep"
    cmb_Start_Month.AddItem "Oct"
    cmb_Start_Month.AddItem "Nov"
    cmb_Start_Month.AddItem "Dec"
    
    cmb_Start_Month.ListIndex = 0
    
    cmb_Till_Month.AddItem "Jan"
    cmb_Till_Month.AddItem "Feb"
    cmb_Till_Month.AddItem "Mar"
    cmb_Till_Month.AddItem "Apr"
    cmb_Till_Month.AddItem "May"
    cmb_Till_Month.AddItem "Jun"
    cmb_Till_Month.AddItem "Jul"
    cmb_Till_Month.AddItem "Aug"
    cmb_Till_Month.AddItem "Sep"
    cmb_Till_Month.AddItem "Oct"
    cmb_Till_Month.AddItem "Nov"
    cmb_Till_Month.AddItem "Dec"
    
    cmb_Till_Month.ListIndex = 0
    
    cmb_Start_Year.AddItem "2009"
    cmb_Start_Year.AddItem "2010"
    cmb_Start_Year.AddItem "2011"
    cmb_Start_Year.AddItem "2012"
    cmb_Start_Year.AddItem "2013"
    cmb_Start_Year.AddItem "2014"
    cmb_Start_Year.AddItem "2015"
    cmb_Start_Year.AddItem "2016"
    
    cmb_Start_Year.ListIndex = 0
    
    Call Hide_Unhide_Ctrls("Steady", "Output Share", "Image13")
    Call Change_Label_Text("lbl_4")
    
    Step_3.Visible = False
    Indication.Visible = False
    Step_4.Visible = False
    Step_5.Visible = False
    
    opt_Region.Value = True
    
    opt_Monthly.Value = True
    
    cmd_Previous.Visible = False
    cmd_Create.Visible = False
    
    cmd_Region_Mapping.Visible = False
    cmd_Product_Mapping.Visible = False
End Sub

Function Segment_1_Selection()
    Segment11.Enabled = False
    Segment12.Enabled = False
    Segment13.Enabled = False
    Segment14.Enabled = False
    Segment15.Enabled = False
    
    Segment11.BackColor = &HE0E0E0
    Segment12.BackColor = &HE0E0E0
    Segment13.BackColor = &HE0E0E0
    Segment14.BackColor = &HE0E0E0
    Segment15.BackColor = &HE0E0E0
    
    If chk_1.Value = True And cmb_S_1.Text <> "" Then
        If cmb_S_1.Text >= 1 Then
            Segment11.Enabled = True
            Segment11.BackColor = &HC0FFFF
        End If
        If cmb_S_1.Text >= 2 Then
            Segment12.Enabled = True
            Segment12.BackColor = &HC0FFFF
        End If
        If cmb_S_1.Text >= 3 Then
            Segment13.Enabled = True
            Segment13.BackColor = &HC0FFFF
        End If
        If cmb_S_1.Text >= 4 Then
            Segment14.Enabled = True
            Segment14.BackColor = &HC0FFFF
        End If
        If cmb_S_1.Text >= 5 Then
            Segment15.Enabled = True
            Segment15.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_2_Selection()
    Segment21.Enabled = False
    Segment22.Enabled = False
    Segment23.Enabled = False
    Segment24.Enabled = False
    Segment25.Enabled = False
    
    Segment21.BackColor = &HE0E0E0
    Segment22.BackColor = &HE0E0E0
    Segment23.BackColor = &HE0E0E0
    Segment24.BackColor = &HE0E0E0
    Segment25.BackColor = &HE0E0E0
    
    If chk_2.Value = True And cmb_S_2.Text <> "" Then
        If cmb_S_2.Text >= 1 Then
            Segment21.Enabled = True
            Segment21.BackColor = &HC0FFFF
        End If
        If cmb_S_2.Text >= 2 Then
            Segment22.Enabled = True
            Segment22.BackColor = &HC0FFFF
        End If
        If cmb_S_2.Text >= 3 Then
            Segment23.Enabled = True
            Segment23.BackColor = &HC0FFFF
        End If
        If cmb_S_2.Text >= 4 Then
            Segment24.Enabled = True
            Segment24.BackColor = &HC0FFFF
        End If
        If cmb_S_2.Text >= 5 Then
            Segment25.Enabled = True
            Segment25.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_3_Selection()
    Segment31.Enabled = False
    Segment32.Enabled = False
    Segment33.Enabled = False
    Segment34.Enabled = False
    Segment35.Enabled = False
    
    Segment31.BackColor = &HE0E0E0
    Segment32.BackColor = &HE0E0E0
    Segment33.BackColor = &HE0E0E0
    Segment34.BackColor = &HE0E0E0
    Segment35.BackColor = &HE0E0E0

    If chk_3.Value = True And cmb_S_3.Text <> "" Then
        If cmb_S_3.Text >= 1 Then
            Segment31.Enabled = True
            Segment31.BackColor = &HC0FFFF
        End If
        If cmb_S_3.Text >= 2 Then
            Segment32.Enabled = True
            Segment32.BackColor = &HC0FFFF
        End If
        If cmb_S_3.Text >= 3 Then
            Segment33.Enabled = True
            Segment33.BackColor = &HC0FFFF
        End If
        If cmb_S_3.Text >= 4 Then
            Segment34.Enabled = True
            Segment34.BackColor = &HC0FFFF
        End If
        If cmb_S_3.Text >= 5 Then
            Segment35.Enabled = True
            Segment35.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_4_Selection()
    Segment41.Enabled = False
    Segment42.Enabled = False
    Segment43.Enabled = False
    Segment44.Enabled = False
    Segment45.Enabled = False
    
    Segment41.BackColor = &HE0E0E0
    Segment42.BackColor = &HE0E0E0
    Segment43.BackColor = &HE0E0E0
    Segment44.BackColor = &HE0E0E0
    Segment45.BackColor = &HE0E0E0
    
    If chk_4.Value = True And cmb_S_4.Text <> "" Then
        If cmb_S_4.Text >= 1 Then
            Segment41.Enabled = True
            Segment41.BackColor = &HC0FFFF
        End If
        If cmb_S_4.Text >= 2 Then
            Segment42.Enabled = True
            Segment42.BackColor = &HC0FFFF
        End If
        If cmb_S_4.Text >= 3 Then
            Segment43.Enabled = True
            Segment43.BackColor = &HC0FFFF
        End If
        If cmb_S_4.Text >= 4 Then
            Segment44.Enabled = True
            Segment44.BackColor = &HC0FFFF
        End If
        If cmb_S_4.Text >= 5 Then
            Segment45.Enabled = True
            Segment45.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_5_Selection()
    Segment51.Enabled = False
    Segment52.Enabled = False
    Segment53.Enabled = False
    Segment54.Enabled = False
    Segment55.Enabled = False
    
    Segment51.BackColor = &HE0E0E0
    Segment52.BackColor = &HE0E0E0
    Segment53.BackColor = &HE0E0E0
    Segment54.BackColor = &HE0E0E0
    Segment55.BackColor = &HE0E0E0
    
    If chk_5.Value = True And cmb_S_5.Text <> "" Then
        If cmb_S_5.Text >= 1 Then
            Segment51.Enabled = True
            Segment51.BackColor = &HC0FFFF
        End If
        If cmb_S_5.Text >= 2 Then
            Segment52.Enabled = True
            Segment52.BackColor = &HC0FFFF
        End If
        If cmb_S_5.Text >= 3 Then
            Segment53.Enabled = True
            Segment53.BackColor = &HC0FFFF
        End If
        If cmb_S_5.Text >= 4 Then
            Segment54.Enabled = True
            Segment54.BackColor = &HC0FFFF
        End If
        If cmb_S_5.Text >= 5 Then
            Segment55.Enabled = True
            Segment55.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_6_Selection()
    Segment61.Enabled = False
    Segment62.Enabled = False
    Segment63.Enabled = False
    Segment64.Enabled = False
    Segment65.Enabled = False
    
    Segment61.BackColor = &HE0E0E0
    Segment62.BackColor = &HE0E0E0
    Segment63.BackColor = &HE0E0E0
    Segment64.BackColor = &HE0E0E0
    Segment65.BackColor = &HE0E0E0
    
    If chk_6.Value = True And cmb_S_6.Text <> "" Then
        If cmb_S_6.Text >= 1 Then
            Segment61.Enabled = True
            Segment61.BackColor = &HC0FFFF
        End If
        If cmb_S_6.Text >= 2 Then
            Segment62.Enabled = True
            Segment62.BackColor = &HC0FFFF
        End If
        If cmb_S_6.Text >= 3 Then
            Segment63.Enabled = True
            Segment63.BackColor = &HC0FFFF
        End If
        If cmb_S_6.Text >= 4 Then
            Segment64.Enabled = True
            Segment64.BackColor = &HC0FFFF
        End If
        If cmb_S_6.Text >= 5 Then
            Segment65.Enabled = True
            Segment65.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_7_Selection()
    Segment71.Enabled = False
    Segment72.Enabled = False
    Segment73.Enabled = False
    Segment74.Enabled = False
    Segment75.Enabled = False
    
    Segment71.BackColor = &HE0E0E0
    Segment72.BackColor = &HE0E0E0
    Segment73.BackColor = &HE0E0E0
    Segment74.BackColor = &HE0E0E0
    Segment75.BackColor = &HE0E0E0
    
    If chk_7.Value = True And cmb_S_7.Text <> "" Then
        If cmb_S_7.Text >= 1 Then
            Segment71.Enabled = True
            Segment71.BackColor = &HC0FFFF
        End If
        If cmb_S_7.Text >= 2 Then
            Segment72.Enabled = True
            Segment72.BackColor = &HC0FFFF
        End If
        If cmb_S_7.Text >= 3 Then
            Segment73.Enabled = True
            Segment73.BackColor = &HC0FFFF
        End If
        If cmb_S_7.Text >= 4 Then
            Segment74.Enabled = True
            Segment74.BackColor = &HC0FFFF
        End If
        If cmb_S_7.Text >= 5 Then
            Segment75.Enabled = True
            Segment75.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_8_Selection()
    Segment81.Enabled = False
    Segment82.Enabled = False
    Segment83.Enabled = False
    Segment84.Enabled = False
    Segment85.Enabled = False
    
    Segment81.BackColor = &HE0E0E0
    Segment82.BackColor = &HE0E0E0
    Segment83.BackColor = &HE0E0E0
    Segment84.BackColor = &HE0E0E0
    Segment85.BackColor = &HE0E0E0
    
    If chk_8.Value = True And cmb_S_8.Text <> "" Then
        If cmb_S_8.Text >= 1 Then
            Segment81.Enabled = True
            Segment81.BackColor = &HC0FFFF
        End If
        If cmb_S_8.Text >= 2 Then
            Segment82.Enabled = True
            Segment82.BackColor = &HC0FFFF
        End If
        If cmb_S_8.Text >= 3 Then
            Segment83.Enabled = True
            Segment83.BackColor = &HC0FFFF
        End If
        If cmb_S_8.Text >= 4 Then
            Segment84.Enabled = True
            Segment84.BackColor = &HC0FFFF
        End If
        If cmb_S_8.Text >= 5 Then
            Segment85.Enabled = True
            Segment85.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_9_Selection()
    Segment91.Enabled = False
    Segment92.Enabled = False
    Segment93.Enabled = False
    Segment94.Enabled = False
    Segment95.Enabled = False
    
    Segment91.BackColor = &HE0E0E0
    Segment92.BackColor = &HE0E0E0
    Segment93.BackColor = &HE0E0E0
    Segment94.BackColor = &HE0E0E0
    Segment95.BackColor = &HE0E0E0
    
    If chk_9.Value = True And cmb_S_9.Text <> "" Then
        If cmb_S_9.Text >= 1 Then
            Segment91.Enabled = True
            Segment91.BackColor = &HC0FFFF
        End If
        If cmb_S_9.Text >= 2 Then
            Segment92.Enabled = True
            Segment92.BackColor = &HC0FFFF
        End If
        If cmb_S_9.Text >= 3 Then
            Segment93.Enabled = True
            Segment93.BackColor = &HC0FFFF
        End If
        If cmb_S_9.Text >= 4 Then
            Segment94.Enabled = True
            Segment94.BackColor = &HC0FFFF
        End If
        If cmb_S_9.Text >= 5 Then
            Segment95.Enabled = True
            Segment95.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Segment_10_Selection()
    Segment101.Enabled = False
    Segment102.Enabled = False
    Segment103.Enabled = False
    Segment104.Enabled = False
    Segment105.Enabled = False
    
    Segment101.BackColor = &HE0E0E0
    Segment102.BackColor = &HE0E0E0
    Segment103.BackColor = &HE0E0E0
    Segment104.BackColor = &HE0E0E0
    Segment105.BackColor = &HE0E0E0
    
    If chk_10.Value = True And cmb_S_10.Text <> "" Then
        If cmb_S_10.Text >= 1 Then
            Segment101.Enabled = True
            Segment101.BackColor = &HC0FFFF
        End If
        If cmb_S_10.Text >= 2 Then
            Segment102.Enabled = True
            Segment102.BackColor = &HC0FFFF
        End If
        If cmb_S_10.Text >= 3 Then
            Segment103.Enabled = True
            Segment103.BackColor = &HC0FFFF
        End If
        If cmb_S_10.Text >= 4 Then
            Segment104.Enabled = True
            Segment104.BackColor = &HC0FFFF
        End If
        If cmb_S_10.Text >= 5 Then
            Segment105.Enabled = True
            Segment105.BackColor = &HC0FFFF
        End If
    End If
End Function
Function Inline_Segment_Selection()
    txt_I_1.Enabled = False
    txt_I_2.Enabled = False
    txt_I_3.Enabled = False
    txt_I_4.Enabled = False
    txt_I_5.Enabled = False
    
    txt_I_1.BackColor = &HE0E0E0
    txt_I_2.BackColor = &HE0E0E0
    txt_I_3.BackColor = &HE0E0E0
    txt_I_4.BackColor = &HE0E0E0
    txt_I_5.BackColor = &HE0E0E0
    
    cmb_I_Launch_1.Enabled = False
    cmb_I_Launch_2.Enabled = False
    cmb_I_Launch_3.Enabled = False
    cmb_I_Launch_4.Enabled = False
    cmb_I_Launch_5.Enabled = False
    
    cmb_I_Launch_1.BackColor = &HE0E0E0
    cmb_I_Launch_2.BackColor = &HE0E0E0
    cmb_I_Launch_3.BackColor = &HE0E0E0
    cmb_I_Launch_4.BackColor = &HE0E0E0
    cmb_I_Launch_5.BackColor = &HE0E0E0
    
    cmb_I_Expiry_1.Enabled = False
    cmb_I_Expiry_2.Enabled = False
    cmb_I_Expiry_3.Enabled = False
    cmb_I_Expiry_4.Enabled = False
    cmb_I_Expiry_5.Enabled = False
    
    cmb_I_Expiry_1.BackColor = &HE0E0E0
    cmb_I_Expiry_2.BackColor = &HE0E0E0
    cmb_I_Expiry_3.BackColor = &HE0E0E0
    cmb_I_Expiry_4.BackColor = &HE0E0E0
    cmb_I_Expiry_5.BackColor = &HE0E0E0
    
    
    chk_I_1.Enabled = False
    chk_I_2.Enabled = False
    chk_I_3.Enabled = False
    chk_I_4.Enabled = False
    chk_I_5.Enabled = False
    
        If cmb_Inline.Text >= 1 Then
            txt_I_1.Enabled = True
            txt_I_1.BackColor = &HC0FFFF
            cmb_I_Launch_1.Enabled = True
            cmb_I_Launch_1.BackColor = &HC0FFFF
            chk_I_1.Enabled = True
            cmb_I_Expiry_1.Enabled = True
            cmb_I_Expiry_1.BackColor = &HC0FFFF
        End If
    
        If cmb_Inline.Text >= 2 Then
            txt_I_2.Enabled = True
            txt_I_2.BackColor = &HC0FFFF
            cmb_I_Launch_2.Enabled = True
            cmb_I_Launch_2.BackColor = &HC0FFFF
            chk_I_2.Enabled = True
            cmb_I_Expiry_2.Enabled = True
            cmb_I_Expiry_2.BackColor = &HC0FFFF
        End If
    
        If cmb_Inline.Text >= 3 Then
            txt_I_3.Enabled = True
            txt_I_3.BackColor = &HC0FFFF
            cmb_I_Launch_3.Enabled = True
            cmb_I_Launch_3.BackColor = &HC0FFFF
            chk_I_3.Enabled = True
            cmb_I_Expiry_3.Enabled = True
            cmb_I_Expiry_3.BackColor = &HC0FFFF
        End If
    
        If cmb_Inline.Text >= 4 Then
            txt_I_4.Enabled = True
            txt_I_4.BackColor = &HC0FFFF
            cmb_I_Launch_4.Enabled = True
            cmb_I_Launch_4.BackColor = &HC0FFFF
            chk_I_4.Enabled = True
            cmb_I_Expiry_4.Enabled = True
            cmb_I_Expiry_4.BackColor = &HC0FFFF
        End If
    
        If cmb_Inline.Text >= 5 Then
            txt_I_5.Enabled = True
            txt_I_5.BackColor = &HC0FFFF
            cmb_I_Launch_5.Enabled = True
            cmb_I_Launch_5.BackColor = &HC0FFFF
            chk_I_5.Enabled = True
            cmb_I_Expiry_5.Enabled = True
            cmb_I_Expiry_5.BackColor = &HC0FFFF
        End If
End Function
Function Pipeline_Segment_Selection()

    txt_P_1.Enabled = False
    txt_P_2.Enabled = False
    txt_P_3.Enabled = False
    txt_P_4.Enabled = False
    txt_P_5.Enabled = False
    
    txt_P_1.BackColor = &HE0E0E0
    txt_P_2.BackColor = &HE0E0E0
    txt_P_3.BackColor = &HE0E0E0
    txt_P_4.BackColor = &HE0E0E0
    txt_P_5.BackColor = &HE0E0E0
    
    cmb_P_Launch_1.Enabled = False
    cmb_P_Launch_2.Enabled = False
    cmb_P_Launch_3.Enabled = False
    cmb_P_Launch_4.Enabled = False
    cmb_P_Launch_5.Enabled = False
    
    cmb_P_Launch_1.BackColor = &HE0E0E0
    cmb_P_Launch_2.BackColor = &HE0E0E0
    cmb_P_Launch_3.BackColor = &HE0E0E0
    cmb_P_Launch_4.BackColor = &HE0E0E0
    cmb_P_Launch_5.BackColor = &HE0E0E0
    
    cmb_P_Expiry_1.Enabled = False
    cmb_P_Expiry_2.Enabled = False
    cmb_P_Expiry_3.Enabled = False
    cmb_P_Expiry_4.Enabled = False
    cmb_P_Expiry_5.Enabled = False
    
    cmb_P_Expiry_1.BackColor = &HE0E0E0
    cmb_P_Expiry_2.BackColor = &HE0E0E0
    cmb_P_Expiry_3.BackColor = &HE0E0E0
    cmb_P_Expiry_4.BackColor = &HE0E0E0
    cmb_P_Expiry_5.BackColor = &HE0E0E0
    
    
    chk_P_1.Enabled = False
    chk_P_2.Enabled = False
    chk_P_3.Enabled = False
    chk_P_4.Enabled = False
    chk_P_5.Enabled = False
    
    If cmb_Pipeline.Text >= 1 Then
        txt_P_1.Enabled = True
        txt_P_1.BackColor = &HC0FFFF
        cmb_P_Launch_1.Enabled = True
        cmb_P_Launch_1.BackColor = &HC0FFFF
        chk_P_1.Enabled = True
        cmb_P_Expiry_1.Enabled = True
        cmb_P_Expiry_1.BackColor = &HC0FFFF
    End If
    
    If cmb_Pipeline.Text >= 2 Then
        txt_P_2.Enabled = True
        txt_P_2.BackColor = &HC0FFFF
        cmb_P_Launch_2.Enabled = True
        cmb_P_Launch_2.BackColor = &HC0FFFF
        chk_P_2.Enabled = True
        cmb_P_Expiry_2.Enabled = True
        cmb_P_Expiry_2.BackColor = &HC0FFFF
    End If
    
    If cmb_Pipeline.Text >= 3 Then
        txt_P_3.Enabled = True
        txt_P_3.BackColor = &HC0FFFF
        cmb_P_Launch_3.Enabled = True
        cmb_P_Launch_3.BackColor = &HC0FFFF
        chk_P_3.Enabled = True
        cmb_P_Expiry_3.Enabled = True
        cmb_P_Expiry_3.BackColor = &HC0FFFF
    End If
    
    If cmb_Pipeline.Text >= 4 Then
        txt_P_4.Enabled = True
        txt_P_4.BackColor = &HC0FFFF
        cmb_P_Launch_4.Enabled = True
        cmb_P_Launch_4.BackColor = &HC0FFFF
        chk_P_4.Enabled = True
        cmb_P_Expiry_4.Enabled = True
        cmb_P_Expiry_4.BackColor = &HC0FFFF
    End If
    
    If cmb_Pipeline.Text >= 5 Then
        txt_P_5.Enabled = True
        txt_P_5.BackColor = &HC0FFFF
        cmb_P_Launch_5.Enabled = True
        cmb_P_Launch_5.BackColor = &HC0FFFF
        chk_P_5.Enabled = True
        cmb_P_Expiry_5.Enabled = True
        cmb_P_Expiry_5.BackColor = &HC0FFFF
    End If
End Function

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
    Image16.Top = Me.Controls(strHelp).Top ' - 3
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

Private Sub UserForm_QueryClose(Cancel As Integer, CloseMode As Integer)
    If CloseMode = 0 Then
        wks_Home.Range("A3").Value = "Cancel"
    Else
        wks_Home.Range("A3").Value = ""
    End If
End Sub

'INDICATION
Private Sub cmd_Add_Click()
    Dim intLoop As Integer
    Dim intLoop2 As Integer
    Dim intFlag As Integer
    For intLoop = 0 To lst_Indication.ListCount - 1
        If lst_Indication.Selected(intLoop) Then
            intFlag = 0
            For intLoop2 = 0 To lst_SelectedIndications.ListCount - 1
                If lst_Indication.List(intLoop) = lst_SelectedIndications.List(intLoop2) Then
                    intFlag = 1
                End If
            Next intLoop2
            If intFlag = 0 Then
                lst_SelectedIndications.AddItem lst_Indication.List(intLoop)
            End If
        End If
    Next intLoop
End Sub

Private Sub cmd_Remove_Click()
    Dim intLoop As Integer
    For intLoop = 0 To lst_SelectedIndications.ListCount - 1
        If lst_SelectedIndications.Selected(intLoop) Then
            lst_SelectedIndications.RemoveItem intLoop
        End If
    Next intLoop
End Sub

Private Sub lbl_Indication_Click()
    Indication.Visible = True
End Sub

Private Sub cmd_Close_Click()
    Indication.Visible = False
End Sub

Private Sub txt_Search_Change()
    Dim intLoop As Integer
    If txt_Search.Text = "" Then
        lst_Indication.Clear
        For intLoop = 1 To 270
            lst_Indication.AddItem wks_IndicationMaster.Range("A" & intLoop).Value
        Next intLoop
    Else
        lst_Indication.Clear
        For intLoop = 1 To 270
            If Find_Text_Indication(txt_Search.Text, wks_IndicationMaster.Range("A" & intLoop).Value) <> 0 Then
                lst_Indication.AddItem wks_IndicationMaster.Range("A" & intLoop).Value
            End If
        Next intLoop
    End If
End Sub

Function Find_Text_Indication(strWhat As String, strIn As String)
    On Error GoTo ErrFound
    Find_Text_Indication = Application.WorksheetFunction.Find(LCase(strWhat), LCase(strIn), 1)
    Exit Function
ErrFound:
    Find_Text_Indication = 0
End Function
