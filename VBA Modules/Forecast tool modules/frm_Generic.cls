VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Generic 
   Caption         =   "Generic Forecast"
   ClientHeight    =   6435
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   16605
   OleObjectBlob   =   "frm_Generic.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Generic"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmb_Product_Change()
    Dim intProduct As Integer, intCtrl As Integer, blnFlag As Boolean
    
    intProduct = Val(cmb_Product.Text)
    
    ScrollBar1.Value = 0
    If intProduct <= 10 Then
        ScrollBar1.Max = 0
    ElseIf intProduct <= 20 Then
        ScrollBar1.Max = 1
    ElseIf intProduct <= 30 Then
        ScrollBar1.Max = 2
    ElseIf intProduct <= 40 Then
        ScrollBar1.Max = 3
    ElseIf intProduct <= 50 Then
        ScrollBar1.Max = 4
    End If
        
    For intCtrl = 1 To 50
        blnFlag = True
        If intCtrl > intProduct Then blnFlag = False
        'OPTION BUTTONS
        Call Change_Color_Codes("OptionButton" & intCtrl, blnFlag)
        Call Change_Color_Codes("OptionButton" & intCtrl + 50, blnFlag)
        Call Change_Color_Codes("OptionButton" & intCtrl + 100, blnFlag)
        Call Change_Color_Codes("OptionButton" & intCtrl + 150, blnFlag)
        
        'CHECK BOXES
        Call Change_Color_Codes("CheckBox" & intCtrl, blnFlag)
        Call Change_Color_Codes("CheckBox" & intCtrl + 50, blnFlag)
        
        'TEXTBOXES
        Call Change_Color_Codes("TextBox" & intCtrl, blnFlag)
        
        'COMBOBOX
        Call Change_Color_Codes("ComboBox" & intCtrl, blnFlag)
    Next intCtrl
End Sub

Private Sub cmb_Scenario_Change()
    txt_Sce4.Enabled = False
    txt_Sce5.Enabled = False
    
    txt_Sce4.BackColor = &HE0E0E0
    txt_Sce5.BackColor = &HE0E0E0
    
    If Val(cmb_Scenario.Text) >= 4 Then
        txt_Sce4.Enabled = True
        txt_Sce4.BackColor = &HC0FFFF
    End If
    If Val(cmb_Scenario.Text) >= 5 Then
        txt_Sce5.Enabled = True
        txt_Sce5.BackColor = &HC0FFFF
    End If
End Sub

Private Sub cmb_StartYear_Change()
    Dim intLoop As Integer
    cmb_TillYear.Clear
    For intLoop = Val(cmb_StartYear.Text) To Year(Now())
        cmb_TillYear.AddItem intLoop
    Next intLoop
    cmb_EndYear.Clear
    For intLoop = Val(cmb_StartYear.Text) To Val(cmb_StartYear.Text) + 29
        cmb_EndYear.AddItem intLoop
    Next intLoop
    cmb_TillYear.ListIndex = 0
    cmb_EndYear.ListIndex = 0
End Sub

Private Sub cmd_Back_Click()
    Frame_SKU.Visible = False
    cmd_SKU.Visible = True
    cmd_Back.Visible = False
End Sub

Private Sub cmd_Cancel_Click()
    wks_Home.Range("A3").Value = "Cancel"
    Unload Me
End Sub

Private Sub cmd_Create_Click()
Dim intCtrl As Integer, intLoop As Integer, intNext As Integer, intValue As Integer, intCell As Integer

''If lst_SelectedIndications.ListCount = 0 Then
''    MsgBox "Please select an Indication to create forecast", vbInformation + vbOKOnly, "PharmaACE"
''    Indication.Visible = True
''    Exit Sub
''End If

Call Application_Events_Handler(False)
    intLoop = 51
    intNext = 1
    intValue = ScrollBar2.Value
   wks_Vars.Range("B18").Value = 1
   wks_Vars.Range("B20").Value = 1
   wks_Vars.Range("B22").Value = 1
   wks_Vars1.Range("N1").Value = 1
   wks_Vars1.Range("N2").Value = 1
   wks_Vars1.Range("N3").Value = 1
   
   wks_SKU_info.Range("B2:AY16").ClearContents
    
    Call Data_Clear
    
    'INDICATION
    For intLoop = 0 To lst_SelectedIndications.ListCount
        wks_Indication.Range("A" & intLoop + 2).Value = lst_SelectedIndications.List(intLoop)
    Next intLoop
    'Project details
    With wks_M_List
        .Range("B2").Value = Me.txt_Project.Text
        If Me.opt_Mnth = True Then
            .Range("B3").Value = "Monthly"
        Else
            .Range("B3").Value = "Yearly"
        End If
        
        If Me.opt_BDL = True Then
            .Range("B4").Value = "BD&L"
        Else
            .Range("B4").Value = "Internal"
        End If
        If Me.opt_TRx = True Then
            .Range("B8").Value = "TRx"
        Else
            .Range("B8").Value = "Units"
        End If
        
        .Range("B5").Value = Me.cmb_StartMonth.Text
        .Range("C5").Value = Me.cmb_StartYear.Text
        .Range("B6").Value = Me.cmb_TillMonth.Text
        .Range("C6").Value = Me.cmb_TillYear.Text
        .Range("C7").Value = Me.cmb_EndYear.Text
        .Range("C9").Value = Val(Me.cmb_Product.Text)
        .Range("C60").Value = Val(Me.cmb_Scenario.Text)
        .Range("B64").Value = Me.txt_Sce4.Text
        .Range("B65").Value = Me.txt_Sce5.Text
    End With
    'Brand
    For intCtrl = 1 To 50
        If Me.Controls("CheckBox" & intCtrl).Value = True Then
            wks_M_List.Range("L" & 9 + intNext).Value = True
        Else
            wks_M_List.Range("L" & 9 + intNext).Value = False
        End If
        intNext = intNext + 1
    Next intCtrl
     'Market
     intNext = 1
    For intCtrl = 101 To 150
        If Me.Controls("OptionButton" & intCtrl).Value = True Then
            wks_M_List.Range("G" & 9 + intNext).Value = "Market"
        Else
            wks_M_List.Range("G" & 9 + intNext).Value = "Competitor"
        End If
        intNext = intNext + 1
    Next intCtrl
    intNext = 1
    For intCtrl = 51 To 100
        'Master List
            'Product
        wks_M_List.Range("B" & 9 + intNext).Value = Me.Controls("TextBox" & intCtrl - 50).Text
        wks_SKU_info.Range("" & wks_SKU_info.Cells(2, 1 + (intCtrl - 50)).Address).Value = Me.Controls("TextBox" & intCtrl).Text
            'Inline/Pipeline
        If Me.Controls("OptionButton" & intCtrl - 50).Value = True Then
            wks_M_List.Range("D" & 9 + intNext).Value = "Inline"
        Else
            wks_M_List.Range("D" & 9 + intNext).Value = "Pipeline"
        End If
            'SKU level
        If Me.Controls("CheckBox" & intCtrl).Value = True Then
            wks_M_List.Range("H" & 9 + intNext).Value = True
        Else
            wks_M_List.Range("H" & 9 + intNext).Value = False
        End If
            'SKU count
        wks_M_List.Range("I" & 9 + intNext).Value = Me.Controls("ComboBox" & intCtrl).Value
        If Me.Controls("ComboBox" & intCtrl).Value = "" Then
            wks_Product_Details.Range("G" & 1 + intNext).Value = 1
        Else
            wks_Product_Details.Range("G" & 1 + intNext).Value = Me.Controls("ComboBox" & intCtrl).Value
        End If
         If wks_M_List.Range("I" & 9 + intNext).Value = "" Then wks_M_List.Range("I" & 9 + intNext).Value = 1
         If wks_Product_Details.Range("G" & 1 + intNext).Value = "" Then wks_Product_Details.Range("G" & 1 + intNext).Value = 1
            
            'competitors
        wks_M_List.Range("K" & 9 + intNext).Value = Me.Controls("ComboBox" & intCtrl - 50).Value
        intLoop = intLoop + 10
        intNext = intNext + 1
    Next intCtrl
    'SHOW CONTROLS
    If intValue = 0 Then intLoop = 51
    If intValue = 1 Then intLoop = 151
    If intValue = 2 Then intLoop = 251
    If intValue = 3 Then intLoop = 351
    If intValue = 4 Then intLoop = 451
    intValue = intValue * 10 + 51
    intLoop = 51
    For intCtrl = intValue To intValue + wks_M_List.Range("C9").Value - 1
        'TEXTBOXES
        intCell = 1
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop, intCtrl, intCell)
        intCell = 2
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 1, intCtrl, intCell)
        intCell = 3
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 2, intCtrl, intCell)
        intCell = 4
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 3, intCtrl, intCell)
        intCell = 5
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 4, intCtrl, intCell)
        intCell = 6
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 5, intCtrl, intCell)
        intCell = 7
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 6, intCtrl, intCell)
        intCell = 8
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 7, intCtrl, intCell)
        intCell = 9
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 8, intCtrl, intCell)
        intCell = 10
        Call Adjust_Top_Left_Control_3("TextBox" & intLoop + 9, intCtrl, intCell)
''        If wks_SKU_info.Range("" & wks_SKU_info.Cells(1 + Val(Me.Controls("ComboBox" & intCtrl).Text) + 1, 1 + (intCtrl - 50)).Address).Value = "" Then
''            wks_SKU_info.Range("" & wks_SKU_info.Cells(1 + Val(Me.Controls("ComboBox" & intCtrl).Text) + 1, 1 + (intCtrl - 50)).Address).Value = "All"
''        End If
        intLoop = intLoop + 10
    Next intCtrl
    Unload Me
    
    wks_Vars.Range("B18,B20,B22,E18,E20,E22").Value = 1
    wks_Vars.Calculate
    wks_Vars1.Range("AB2:AD100").ClearContents
    ''Project_Details
    With wks_ProjectDetails
        .Range("A2").Value = txt_Project.Text
        If opt_Mnth.Value = True Then
            .Range("B2").Value = "Monthly"
        Else
            .Range("B2").Value = "Yearly"
        End If
        If opt_BDL.Value = True Then
            .Range("C2").Value = "BDL"
        Else
            .Range("C2").Value = "Internal"
        End If
        .Range("D2").Value = cmb_StartMonth.Text
        .Range("E2").Value = cmb_StartYear.Value
        .Range("F2").Value = cmb_TillMonth.Text
        .Range("G2").Value = cmb_TillYear.Value
        .Range("H2").Value = cmb_EndYear.Value
        If opt_TRx.Value = True Then
            .Range("I2").Value = "TRx"
        Else
            .Range("I2").Value = "Units"
        End If
        .Range("J2").Value = cmb_Product.Value
        .Range("K2").Value = cmb_Scenario.Value
  End With
''  Scenario
    With wks_Scenario
        .Range("A2").Value = 1
        .Range("A3").Value = 2
        .Range("A4").Value = 3
        
        .Range("B2").Value = "Base"
        .Range("B3").Value = "Low"
        .Range("B4").Value = "High"
        
        If Val(cmb_Scenario.Text) >= 4 Then
            .Range("A5").Value = 4
            .Range("B5").Value = Me.txt_Sce4.Text
        Else
            .Range("A5:B5").Value = ""
        End If
        If Val(cmb_Scenario.Text) >= 5 Then
            .Range("A6").Value = 5
            .Range("B6").Value = Me.txt_Sce5.Text
        Else
            .Range("A6:B6").Value = ""
        End If
    End With
''   Product_Details
     intNext = 1
    
    With wks_Product_Details
        
        For intCtrl = 51 To 100
            .Range("A" & 1 + intNext).Value = Me.Controls("TextBox" & intCtrl - 50).Text
            wks_Vars1.Range("AB" & 1 + intNext).Value = Me.Controls("TextBox" & intCtrl - 50).Text
            If Me.Controls("OptionButton" & intCtrl - 50).Value = True Then
                .Range("B" & 1 + intNext).Value = "Inline"
            Else
                .Range("B" & 1 + intNext).Value = "Pipeline"
            End If
            If Me.Controls("OptionButton" & 50 + intCtrl).Value = True Then
                .Range("E" & 1 + intNext).Value = "Market"
            Else
                .Range("E" & 1 + intNext).Value = "Competitor"
            End If
            If Me.Controls("CheckBox" & intCtrl).Value = True Then
                .Range("F" & 1 + intNext).Value = True
            Else
                .Range("F" & 1 + intNext).Value = False
            End If
'            .Range("G" & 1 + intNext).Value = Me.Controls("ComboBox" & intCtrl).Value
            .Range("I" & 1 + intNext).Value = Me.Controls("ComboBox" & intCtrl - 50).Value
            If Me.Controls("CheckBox" & intCtrl - 50).Value = True Then
                .Range("J" & 1 + intNext).Value = True
            Else
                .Range("J" & 1 + intNext).Value = False
            End If
            intNext = intNext + 1
        Next intCtrl
    End With
''  sku information
    intCtrl = 1 'textbox 51 to 550
    With wks_SKU_info
        For intLoop = 2 To 51 'Product
            For intNext = 2 To 11 'SKU - text box
                .Cells(intNext, intLoop).Value = Me.Controls("TextBox" & intCtrl + 50).Text
                If Me.Controls("TextBox" & intCtrl + 50).Text = "" Then
                    wks_Vars1.Range("AD" & 1 + intCtrl).Value = "All"
                Else
                    wks_Vars1.Range("AD" & 1 + intCtrl).Value = Me.Controls("TextBox" & intCtrl + 50).Text
                End If
                intCtrl = intCtrl + 1
            Next intNext
        Next intLoop
        For intLoop = 2 To wks_M_List.Range("C9").Value + 1
            If .Cells(2, intLoop).Value = "" Then .Cells(2, intLoop).Value = "All"
        Next intLoop
    End With
    wks_Forecast.Calculate
    Call Create_Forecast_Master
Call Application_Events_Handler(True)
End Sub

Private Sub cmd_SKU_Click()
    Frame_SKU.Visible = True
    cmd_SKU.Visible = False
    cmd_Back.Visible = True
    
    ScrollBar2.Value = 0
    Call Scroll_Changed_Adjust_Controls_2(0)
End Sub

Private Sub ComboBox51_Change()
    Call Combo_Box_Changed(51)
End Sub
Private Sub ComboBox52_Change()
    Call Combo_Box_Changed(52)
End Sub
Private Sub ComboBox53_Change()
    Call Combo_Box_Changed(53)
End Sub
Private Sub ComboBox54_Change()
    Call Combo_Box_Changed(54)
End Sub
Private Sub ComboBox55_Change()
    Call Combo_Box_Changed(55)
End Sub
Private Sub ComboBox56_Change()
    Call Combo_Box_Changed(56)
End Sub
Private Sub ComboBox57_Change()
    Call Combo_Box_Changed(57)
End Sub
Private Sub ComboBox58_Change()
    Call Combo_Box_Changed(58)
End Sub
Private Sub ComboBox59_Change()
    Call Combo_Box_Changed(59)
End Sub
Private Sub ComboBox60_Change()
    Call Combo_Box_Changed(60)
End Sub
Private Sub ComboBox61_Change()
    Call Combo_Box_Changed(61)
End Sub
Private Sub ComboBox62_Change()
    Call Combo_Box_Changed(62)
End Sub
Private Sub ComboBox63_Change()
    Call Combo_Box_Changed(63)
End Sub
Private Sub ComboBox64_Change()
    Call Combo_Box_Changed(64)
End Sub
Private Sub ComboBox65_Change()
    Call Combo_Box_Changed(65)
End Sub
Private Sub ComboBox66_Change()
    Call Combo_Box_Changed(66)
End Sub
Private Sub ComboBox67_Change()
    Call Combo_Box_Changed(67)
End Sub
Private Sub ComboBox68_Change()
    Call Combo_Box_Changed(68)
End Sub
Private Sub ComboBox69_Change()
    Call Combo_Box_Changed(69)
End Sub
Private Sub ComboBox70_Change()
    Call Combo_Box_Changed(70)
End Sub
Private Sub ComboBox71_Change()
    Call Combo_Box_Changed(71)
End Sub
Private Sub ComboBox72_Change()
    Call Combo_Box_Changed(72)
End Sub
Private Sub ComboBox73_Change()
    Call Combo_Box_Changed(73)
End Sub
Private Sub ComboBox74_Change()
    Call Combo_Box_Changed(74)
End Sub
Private Sub ComboBox75_Change()
    Call Combo_Box_Changed(75)
End Sub
Private Sub ComboBox76_Change()
    Call Combo_Box_Changed(76)
End Sub
Private Sub ComboBox77_Change()
    Call Combo_Box_Changed(77)
End Sub
Private Sub ComboBox78_Change()
    Call Combo_Box_Changed(78)
End Sub
Private Sub ComboBox79_Change()
    Call Combo_Box_Changed(79)
End Sub
Private Sub ComboBox80_Change()
    Call Combo_Box_Changed(80)
End Sub
Private Sub ComboBox81_Change()
    Call Combo_Box_Changed(81)
End Sub
Private Sub ComboBox82_Change()
    Call Combo_Box_Changed(82)
End Sub
Private Sub ComboBox83_Change()
    Call Combo_Box_Changed(83)
End Sub
Private Sub ComboBox84_Change()
    Call Combo_Box_Changed(84)
End Sub
Private Sub ComboBox85_Change()
    Call Combo_Box_Changed(85)
End Sub
Private Sub ComboBox86_Change()
    Call Combo_Box_Changed(86)
End Sub
Private Sub ComboBox87_Change()
    Call Combo_Box_Changed(87)
End Sub
Private Sub ComboBox88_Change()
    Call Combo_Box_Changed(88)
End Sub
Private Sub ComboBox89_Change()
    Call Combo_Box_Changed(89)
End Sub
Private Sub ComboBox90_Change()
    Call Combo_Box_Changed(90)
End Sub
Private Sub ComboBox91_Change()
    Call Combo_Box_Changed(91)
End Sub
Private Sub ComboBox92_Change()
    Call Combo_Box_Changed(92)
End Sub
Private Sub ComboBox93_Change()
    Call Combo_Box_Changed(93)
End Sub
Private Sub ComboBox94_Change()
    Call Combo_Box_Changed(94)
End Sub
Private Sub ComboBox95_Change()
    Call Combo_Box_Changed(95)
End Sub
Private Sub ComboBox96_Change()
    Call Combo_Box_Changed(96)
End Sub
Private Sub ComboBox97_Change()
    Call Combo_Box_Changed(97)
End Sub
Private Sub ComboBox98_Change()
    Call Combo_Box_Changed(98)
End Sub
Private Sub ComboBox99_Change()
    Call Combo_Box_Changed(99)
End Sub
Private Sub ComboBox100_Change()
    Call Combo_Box_Changed(100)
End Sub

Private Sub ScrollBar1_Change()
    Call Scroll_Changed_Adjust_Controls(ScrollBar1.Value)
End Sub

Private Sub ScrollBar2_Change()
    Call Scroll_Changed_Adjust_Controls_2(ScrollBar2.Value)
End Sub

Private Sub UserForm_Activate()
    Dim intCtrl As Integer, intLoop As Integer
    
    wks_Home.Range("A3").Value = ""
    'HIDE CONTROLS
    cmd_Back.Visible = False
    Frame_SKU.Visible = False
    Indication.Visible = False
    For intCtrl = 1 To 50
        'OPTION BUTTONS
        Me.Controls("OptionButton" & intCtrl).GroupName = "G" & intCtrl
        Me.Controls("OptionButton" & intCtrl + 50).GroupName = "G" & intCtrl
        
        Me.Controls("OptionButton" & intCtrl + 100).GroupName = "G" & intCtrl + 50
        Me.Controls("OptionButton" & intCtrl + 150).GroupName = "G" & intCtrl + 50
        
        Me.Controls("OptionButton" & intCtrl).Visible = False
        Me.Controls("OptionButton" & intCtrl + 50).Visible = False
        Me.Controls("OptionButton" & intCtrl + 100).Visible = False
        Me.Controls("OptionButton" & intCtrl + 150).Visible = False
        
        'CHECK BOXES
        Me.Controls("CheckBox" & intCtrl).Visible = False
        Me.Controls("CheckBox" & intCtrl + 50).Visible = False
        
        'TEXTBOXES
        Me.Controls("TextBox" & intCtrl).Visible = False
        
        'COMBOBOX
        Me.Controls("ComboBox" & intCtrl).Visible = False
    Next intCtrl
    For intCtrl = 51 To 550
        Me.Controls("TextBox" & intCtrl).Enabled = False
        Me.Controls("TextBox" & intCtrl).BackColor = &HE0E0E0
    Next intCtrl
    'TAB INDEX
    txt_Project.TabIndex = 0
    opt_Mnth.TabIndex = 1
    opt_Year.TabIndex = 2
    opt_BDL.TabIndex = 3
    opt_Internal.TabIndex = 4
    Frame1.TabIndex = 5
    Frame2.TabIndex = 6
    Frame3.TabIndex = 7
    cmb_Product.TabIndex = 8
    intCtrl = 9
    For intLoop = 1 To 50
        Me.Controls("TextBox" & intLoop).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("CheckBox" & intLoop).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("OptionButton" & intLoop).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("OptionButton" & intLoop + 50).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("CheckBox" & intLoop + 50).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("OptionButton" & intLoop + 100).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("OptionButton" & intLoop + 150).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("OptionButton" & intLoop).TabIndex = intCtrl
        intCtrl = intCtrl + 1
        Me.Controls("ComboBox" & intLoop).TabIndex = intCtrl
        intCtrl = intCtrl + 1
    Next intLoop
    
    'ADD ITEMS
        'MONTHS
        For intCtrl = 1 To 12
            cmb_StartMonth.AddItem Choose(intCtrl, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
            cmb_TillMonth.AddItem Choose(intCtrl, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
        Next intCtrl
        
        'YEARS
        For intCtrl = 2009 To Year(Now())
            cmb_StartYear.AddItem intCtrl
        Next intCtrl
        
        'PRODUCT LIST
        For intCtrl = 1 To 50
            cmb_Product.AddItem intCtrl
        Next intCtrl
        
        ''çompetitors combo
        For intCtrl = 1 To 50
            For intLoop = 1 To 15
                Me.Controls("ComboBox" & intCtrl).AddItem intLoop
            Next intLoop
            Me.Controls("ComboBox" & intCtrl).ListIndex = 0
        Next intCtrl
        
        'COMBOBOX
        For intCtrl = 51 To 100
            For intLoop = 1 To 10
                Me.Controls("ComboBox" & intCtrl).AddItem intLoop
            Next intLoop
        Next intCtrl
        
        'scenario combo
        With Me.cmb_Scenario
            For intLoop = 3 To 5
                .AddItem intLoop
            Next intLoop
            .ListIndex = 0
        End With
        
    'DEFAULT VALUES
    cmb_StartYear.ListIndex = 0
    cmb_StartMonth.ListIndex = 0
    cmb_TillMonth.ListIndex = 0
    cmb_EndYear.ListIndex = 0
    cmb_Product.ListIndex = 0
    
    opt_Mnth.Value = True
    opt_Year.Enabled = False
    
    lst_Indication.Clear
    For intLoop = 1 To 269
        lst_Indication.AddItem wks_IndicationMaster.Range("A" & intLoop).Value
    Next intLoop
    
    ScrollBar1.Value = 0
    Call Scroll_Changed_Adjust_Controls(0)
    txt_Project.SetFocus
End Sub

Function Scroll_Changed_Adjust_Controls(intValue As Integer)
    Dim intCtrl As Integer, intTop As Integer, intLoop As Integer
    'HIDE CONTROLS
    For intCtrl = 1 To 50
        'OPTION BUTTONS
        Me.Controls("OptionButton" & intCtrl).Visible = False
        Me.Controls("OptionButton" & intCtrl + 50).Visible = False
        Me.Controls("OptionButton" & intCtrl + 100).Visible = False
        Me.Controls("OptionButton" & intCtrl + 150).Visible = False
        
        'CHECK BOXES
        Me.Controls("CheckBox" & intCtrl).Visible = False
        Me.Controls("CheckBox" & intCtrl + 50).Visible = False
        
        'TEXTBOXES
        Me.Controls("TextBox" & intCtrl).Visible = False
        
        'COMBOBOX
        Me.Controls("ComboBox" & intCtrl).Visible = False
    Next intCtrl
    
    'SHOW CONTROLS
    intValue = intValue * 10 + 1
    intTop = 36
    intLoop = 1
    For intCtrl = intValue To intValue + 9
        'PRODUCT COUNT IN LABEL
        Me.Controls("lbl_" & intLoop).Caption = intCtrl
        intLoop = intLoop + 1
        'TEXTBOXES
        Call Adjust_Top_Left_Control("TextBox" & intCtrl, intTop, 252)
        Call Adjust_Top_Left_Control("CheckBox" & intCtrl, intTop, 390)
        
        Call Adjust_Top_Left_Control("OptionButton" & intCtrl, intTop, 444)
        
        Call Adjust_Top_Left_Control("OptionButton" & intCtrl + 50, intTop, 480)
        
        Call Adjust_Top_Left_Control("CheckBox" & intCtrl + 50, intTop, 528)
        
        Call Adjust_Top_Left_Control("OptionButton" & intCtrl + 100, intTop, 582)
        Call Adjust_Top_Left_Control("OptionButton" & intCtrl + 150, intTop, 624)
        
        Call Adjust_Top_Left_Control("ComboBox" & intCtrl, intTop, 684)
        
        intTop = intTop + 24
    Next intCtrl
End Function

Function Scroll_Changed_Adjust_Controls_2(intValue As Integer)
    Dim intCtrl As Integer, intTop As Integer, intLoop As Integer
    intLoop = 51
    'HIDE CONTROLS
    For intCtrl = 51 To 100
        Me.Controls("L" & intCtrl - 50).Visible = False
        Me.Controls("ComboBox" & intCtrl).Visible = False
        
        'TEXTBOXES
        Me.Controls("TextBox" & intLoop).Visible = False
        Me.Controls("TextBox" & intLoop + 1).Visible = False
        Me.Controls("TextBox" & intLoop + 2).Visible = False
        Me.Controls("TextBox" & intLoop + 3).Visible = False
        Me.Controls("TextBox" & intLoop + 4).Visible = False
        Me.Controls("TextBox" & intLoop + 5).Visible = False
        Me.Controls("TextBox" & intLoop + 6).Visible = False
        Me.Controls("TextBox" & intLoop + 7).Visible = False
        Me.Controls("TextBox" & intLoop + 8).Visible = False
        Me.Controls("TextBox" & intLoop + 9).Visible = False
        intLoop = intLoop + 10
    Next intCtrl
    'SHOW CONTROLS
    If intValue = 0 Then intLoop = 51
    If intValue = 1 Then intLoop = 151
    If intValue = 2 Then intLoop = 251
    If intValue = 3 Then intLoop = 351
    If intValue = 4 Then intLoop = 451
    intValue = intValue * 10 + 51
    intTop = 12
    For intCtrl = intValue To intValue + 9
        'PRODUCT NAMES IN LABEL
        With Me.Controls("L" & intCtrl - 50)
            .Visible = True
            .Caption = Me.Controls("TextBox" & intCtrl - 50).Text
            .Left = 12
            .Top = intTop
        End With
        'COMBOBOXES
        With Me.Controls("ComboBox" & intCtrl)
            .Visible = True
            .Left = 78
            .Top = intTop - 2
            If Me.Controls("CheckBox" & intCtrl).Value = True Then
                .Enabled = True
            Else
                .Enabled = False
            End If
        End With
        'TEXTBOXES
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop, intTop, 132, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 1, intTop, 198, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 2, intTop, 264, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 3, intTop, 330, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 4, intTop, 396, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 5, intTop, 462, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 6, intTop, 528, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 7, intTop, 594, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 8, intTop, 660, intCtrl)
        Call Adjust_Top_Left_Control_2("TextBox" & intLoop + 9, intTop, 726, intCtrl)
        
        intLoop = intLoop + 10
        intTop = intTop + 24
    Next intCtrl
End Function

Function Adjust_Top_Left_Control(strControl As String, intTop As Integer, intLeft As Integer)
    With Me.Controls(strControl)
        .Visible = True
        .Left = intLeft
        .Top = intTop
        If Left(strControl, 7) = "TextBox" Then .Width = 110
    End With
End Function

Function Adjust_Top_Left_Control_2(strControl As String, intTop As Integer, intLeft As Integer, intCtrl As Integer)
Dim intCell As Integer
    With Me.Controls(strControl)
        .Visible = True
        .Left = intLeft
        .Top = intTop
        .Width = 60
        If Me.Controls("CheckBox" & intCtrl).Value = True Then
           .Enabled = True
        Else
           .Enabled = False
        End If
    End With
End Function
Function Adjust_Top_Left_Control_3(strControl As String, intCtrl As Integer, intCell As Integer)
    With Me.Controls(strControl)
        'sku info fill
            wks_SKU_info.Range("" & wks_SKU_info.Cells(1 + intCell, 1 + (intCtrl - 50)).Address).Value = .Text
    End With
End Function
Function Adjust_Top_Left_Control_4(strControl As String, intCtrl As Integer, intCell As Integer)
    With Me.Controls(strControl)
        'sku info fill
        .Text = wks_SKU_info.Range("" & wks_SKU_info.Cells(1 + intCell, 1 + (intCtrl - 50)).Address).Value
    End With
End Function

Function Change_Color_Codes(strControl As String, blnFlag As Boolean)
    With Me.Controls(strControl)
        If blnFlag Then
            .Enabled = blnFlag
            .BackColor = &HC0FFFF
        Else
            .Enabled = blnFlag
            .BackColor = &HE0E0E0
        End If
    End With
End Function

Function Combo_Box_Changed(intNumber As Integer)
    Dim intCtrl As Integer, intLoop As Integer, intCount As Integer
    intCtrl = (intNumber - 51) * 10 + 51
    intCount = 1
    For intLoop = intCtrl To intCtrl + 9
        If Val(Me.Controls("ComboBox" & intNumber).Text) >= intCount Then
            Me.Controls("TextBox" & intLoop).Enabled = True
            Me.Controls("TextBox" & intLoop).BackColor = &HC0FFFF
        Else
            Me.Controls("TextBox" & intLoop).Enabled = False
            Me.Controls("TextBox" & intLoop).BackColor = &HE0E0E0
        End If
        intCount = intCount + 1
    Next intLoop
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
        For intLoop = 1 To 269
            lst_Indication.AddItem wks_IndicationMaster.Range("A" & intLoop).Value
        Next intLoop
    Else
        lst_Indication.Clear
        For intLoop = 1 To 269
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
