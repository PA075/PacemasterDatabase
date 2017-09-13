Attribute VB_Name = "mod_Z_Interpolator"
Option Base 1

Function Interpolate_Data(Rng_Data As Range, Intervals As Integer)
    Dim intLoop As Integer
    Dim intInitial As Variant, intSecond As Variant, intSum As Variant
    Dim intP As Variant, intQ As Variant, intDifference As Variant
    Dim intVariable1 As Variant, intVariable2 As Variant
    Dim intNumber As Variant
    Dim intT As Variant
    Dim intColumns As Integer
    Dim intSplitCount As Integer
    Dim arr_Values() As Variant
    Dim arr_Cumm_Values() As Variant
    Dim arr_Numbers() As Variant
    Dim arr_Intervals() As Variant
    Dim arr_Final() As Variant
    Dim arr_QTRLY() As Variant
    
    intColumns = Rng_Data.Columns.Count
    intSplitCount = Intervals * intColumns
    Dim str As String
    str = Rng_Data.Address
    ReDim arr_Numbers(1 To intColumns)
    ReDim arr_Values(1 To intColumns)
    ReDim arr_Cumm_Values(1 To intColumns)
    ReDim arr_Intervals(1 To intSplitCount)
    ReDim arr_Final(1 To intSplitCount)
    ReDim arr_QTRLY(1 To 32)
'1 TO Number of inputs
    For intLoop = 1 To intColumns
        arr_Numbers(intLoop) = intLoop
    Next intLoop
'MONTH ARRAY
    arr_Intervals(1) = 1 / Intervals
    For intLoop = 2 To intSplitCount
        arr_Intervals(intLoop) = arr_Intervals(intLoop - 1) + (1 / Intervals)
    Next intLoop
'CUMMULATIVE VALUES
    arr_Cumm_Values(1) = Rng_Data.Cells(1, 1)
    arr_Values(1) = Rng_Data.Cells(1, 1)
    For intLoop = 2 To intColumns
        arr_Cumm_Values(intLoop) = arr_Cumm_Values(intLoop - 1) + Rng_Data.Cells(1, intLoop)
        arr_Values(intLoop) = Rng_Data.Cells(1, intLoop)
    Next intLoop
'INITIAL VALUE
    intInitial = Rng_Data.Cells(1, 1)
'SECOND VALUE
    intSecond = Rng_Data.Cells(1, 2)
'STAT FORMULAE
    intP = intSecond - intInitial
    intQ = 0.5 * (3 * intInitial - intSecond)
'INTERPOLATE FOR FIRST
    intSum = 0
    For intLoop = 1 To Intervals
        intSum = intSum + ((intP * arr_Intervals(intLoop) + intQ) / Intervals)
    Next intLoop
    If intSum = 0 Then
        intDifference = 1
    Else
        intDifference = intInitial / intSum
    End If
    For intLoop = 1 To Intervals
        arr_Final(intLoop) = ((intP * arr_Intervals(intLoop) + intQ) / Intervals) * intDifference
        If arr_Final(intLoop) <= 0 Then arr_Final(intLoop) = 0
    Next intLoop
'INTERPOLATE FOR SECOND
    If intColumns > 1 Then
        intSum = 0
        For intLoop = Intervals + 1 To Intervals + Intervals
            intSum = intSum + ((intP * arr_Intervals(intLoop) + intQ) / Intervals)
        Next intLoop
        If intSum = 0 Then
            intDifference = 1
        Else
            intDifference = intSecond / intSum
        End If
        For intLoop = Intervals + 1 To Intervals + Intervals
            arr_Final(intLoop) = ((intP * arr_Intervals(intLoop) + intQ) / Intervals) * intDifference
            If arr_Final(intLoop) <= 0 Then arr_Final(intLoop) = 0
        Next intLoop
    End If
'LOOP FOR REST OF THE MONTHS
    intT = 3
    If intColumns > 2 Then
        intVariable1 = cubic_spline_edited(arr_Numbers, arr_Cumm_Values, arr_Intervals(2 * Intervals))
        If intVariable1 < 0 Then intVariable1 = 0
        For intLoop = (2 * Intervals) + 1 To intSplitCount
            intVariable2 = cubic_spline_edited(arr_Numbers, arr_Cumm_Values, arr_Intervals(intLoop))
            If intVariable2 < 0 Then intVariable2 = 0
            arr_Final(intLoop) = intVariable2 - intVariable1
            If arr_Final(intLoop) <= 0 Then arr_Final(intLoop) = 0
            If arr_Values(intT) = 0 Then arr_Final(intLoop) = 0
            If intLoop Mod Intervals = 0 Then intT = intT + 1
            intVariable1 = intVariable2
        Next intLoop
    End If
'FINAL
    Interpolate_Data = arr_Final
End Function

Function Interpolate_Data1(Rng_Data As Range, Intervals As Integer)
    Dim intLoop As Integer
    Dim intInitial As Variant, intSecond As Variant, intSum As Variant
    Dim intP As Variant, intQ As Variant, intDifference As Variant
    Dim intVariable1 As Variant, intVariable2 As Variant
    Dim intNumber As Variant
    Dim intT As Variant
    Dim intColumns As Integer
    Dim intSplitCount As Integer
    Dim arr_Values() As Variant
    Dim arr_Cumm_Values() As Variant
    Dim arr_Numbers() As Variant
    Dim arr_Intervals() As Variant
    Dim arr_Final() As Variant
    Dim arr_QTRLY() As Variant
    
        intColumns = Rng_Data.Columns.Count
        intSplitCount = Intervals * intColumns
        Dim str As String
        ReDim arr_Numbers(1 To intColumns)
        ReDim arr_Values(1 To intColumns)
        ReDim arr_Cumm_Values(1 To intColumns)
        ReDim arr_Intervals(1 To intSplitCount)
        ReDim arr_Final(1 To intSplitCount)
        ReDim arr_QTRLY(1 To 32)
    '1 TO Number of inputs
        For intLoop = 1 To intColumns
            arr_Numbers(intLoop) = intLoop
        Next intLoop
    'MONTH ARRAY
        arr_Intervals(1) = 1 / Intervals
        For intLoop = 2 To intSplitCount
            arr_Intervals(intLoop) = arr_Intervals(intLoop - 1) + (1 / Intervals)
        Next intLoop
    'CUMMULATIVE VALUES
        arr_Cumm_Values(1) = Rng_Data.Cells(1, 1)
        arr_Values(1) = Rng_Data.Cells(1, 1)
        For intLoop = 2 To intColumns
            arr_Cumm_Values(intLoop) = arr_Cumm_Values(intLoop - 1) + Rng_Data.Cells(1, intLoop)
            arr_Values(intLoop) = Rng_Data.Cells(1, intLoop)
        Next intLoop
    'INITIAL VALUE
        intInitial = Rng_Data.Cells(1, 1)
    'SECOND VALUE
        intSecond = Rng_Data.Cells(1, 2)
    'STAT FORMULAE
        intP = intSecond - intInitial
        intQ = 0.5 * (3 * intInitial - intSecond)
    'INTERPOLATE FOR FIRST
        intSum = 0
        For intLoop = 1 To Intervals
            intSum = intSum + ((intP * arr_Intervals(intLoop) + intQ) / Intervals)
        Next intLoop
        If intSum = 0 Then
            intDifference = 1
        Else
            intDifference = intInitial / intSum
        End If
        For intLoop = 1 To Intervals
            arr_Final(intLoop) = ((intP * arr_Intervals(intLoop) + intQ) / Intervals) * intDifference
            If arr_Final(intLoop) <= 0 Then arr_Final(intLoop) = 0
        Next intLoop
    'INTERPOLATE FOR SECOND
        If intColumns > 1 Then
            intSum = 0
            For intLoop = Intervals + 1 To Intervals + Intervals
                intSum = intSum + ((intP * arr_Intervals(intLoop) + intQ) / Intervals)
            Next intLoop
            If intSum = 0 Then
                intDifference = 1
            Else
                intDifference = intSecond / intSum
            End If
            For intLoop = Intervals + 1 To Intervals + Intervals
                arr_Final(intLoop) = ((intP * arr_Intervals(intLoop) + intQ) / Intervals) * intDifference
                If arr_Final(intLoop) <= 0 Then arr_Final(intLoop) = 0
            Next intLoop
        End If
    'LOOP FOR REST OF THE MONTHS
        intT = 3
        If intColumns > 2 Then
            intVariable1 = cubic_spline_edited(arr_Numbers, arr_Cumm_Values, arr_Intervals(2 * Intervals))
            If intVariable1 < 0 Then intVariable1 = 0
            For intLoop = (2 * Intervals) + 1 To intSplitCount
                intVariable2 = cubic_spline_edited(arr_Numbers, arr_Cumm_Values, arr_Intervals(intLoop))
                If intVariable2 < 0 Then intVariable2 = 0
                arr_Final(intLoop) = intVariable2 - intVariable1
                If arr_Final(intLoop) <= 0 Then arr_Final(intLoop) = 0
                If arr_Values(intT) = 0 Then arr_Final(intLoop) = 0
                If intLoop Mod Intervals = 0 Then intT = intT + 1
                intVariable1 = intVariable2
            Next intLoop
        End If
    'FINAL
        Interpolate_Data1 = arr_Final
End Function

Function cubic_spline_edited(input_column() As Variant, output_column() As Variant, x As Variant)
    'Purpose:   Given a data set consisting of a list of x values
    '           and y values, this function will smoothly interpolate
    '           a resulting output (y) value from a given input (x) value
    ' This counts how many points are in "input" and "output" set of data
    Dim input_count As Integer
    Dim output_count As Integer
    
    input_count = UBound(input_column)
    output_count = UBound(output_column)
    ' Next check to be sure that "input" # points = "output" # points
    If input_count <> output_count Then
        cubic_spline_edited = "Something's messed up!  The number of indeces number of output_columnues don't match!"
        GoTo out
    End If
     
    ReDim xin(input_count) As Single
    ReDim yin(input_count) As Variant
    
    Dim c As Integer
    
    For c = 1 To input_count
        xin(c) = input_column(c)
        yin(c) = output_column(c)
    Next c
    
    '''''''''''''''''''''''''''''''''''''''
    ' values are populated
    '''''''''''''''''''''''''''''''''''''''
    Dim n As Integer 'n=input_count
    Dim i, k As Integer 'these are loop counting integers
    Dim p, qn, sig, un As Variant
    ReDim U(input_count - 1) As Variant
    ReDim yt(input_count) As Variant 'these are the 2nd deriv values
    
    n = input_count
    yt(1) = 0
    U(1) = 0
    
    For i = 2 To n - 1
        sig = (xin(i) - xin(i - 1)) / (xin(i + 1) - xin(i - 1))
        p = sig * yt(i - 1) + 2
        yt(i) = (sig - 1) / p
        U(i) = (yin(i + 1) - yin(i)) / (xin(i + 1) - xin(i)) - (yin(i) - yin(i - 1)) / (xin(i) - xin(i - 1))
        U(i) = (6 * U(i) / (xin(i + 1) - xin(i - 1)) - sig * U(i - 1)) / p
    Next i
        
    qn = 0
    un = 0
    
    yt(n) = (un - qn * U(n - 1)) / (qn * yt(n - 1) + 1)
    
    For k = n - 1 To 1 Step -1
        yt(k) = yt(k) * yt(k + 1) + U(k)
    Next k
    ''''''''''''''''''''
    'now eval spline at one point
    '''''''''''''''''''''
    Dim klo, khi As Integer
    Dim h, B, A As Variant
    ' first find correct interval
    klo = 1
    khi = n
    Do
    k = khi - klo
    If xin(k) > x Then
        khi = k
    Else
        klo = k
    End If
    k = khi - klo
    Loop While k > 1
    h = xin(khi) - xin(klo)
    A = (xin(khi) - x) / h
    B = (x - xin(klo)) / h
    y = A * yin(klo) + B * yin(khi) + ((A ^ 3 - A) * yt(klo) + (B ^ 3 - B) * yt(khi)) * (h ^ 2) / 6
    
    cubic_spline_edited = y
out:
End Function


