Attribute VB_Name = "mod_Kill_Process"
Option Explicit

#If VBA7 Then
    Declare PtrSafe Function GetCurrentProcessId Lib "kernel32" () As Long
#Else
    Declare Function GetCurrentProcessId Lib "kernel32" () As Long
#End If


Function Kill_Process_Excel()
    Dim oServ As Object
    Dim cProc As Variant
    Dim oProc As Object
    Dim errReturnCode As Object
    Dim thisAPP As Object
    Set thisAPP = ThisWorkbook.Application

    Set oServ = GetObject("winmgmts:")
    Set cProc = oServ.ExecQuery("Select * from Win32_Process where ProcessID=" & thisAPP.Run("GetCurrentProcessId"))

    For Each oProc In cProc

        'Rename EXCEL.EXE in the line below with the process that you need to Terminate.
        'NOTE: It is 'case sensitive
        If LCase(oProc.Name) = "excel.exe" Then
''            MsgBox "KILL"   ' used to display a message for testing pur
            errReturnCode = oProc.Terminate()
        End If
    Next
End Function

Function Kill_Process_ObjExcel(thisAPP As Object)
    Dim oServ As Object
    Dim cProc As Variant
    Dim oProc As Object
    Dim errReturnCode As Object

    Set oServ = GetObject("winmgmts:")
    Set cProc = oServ.ExecQuery("Select * from Win32_Process where ProcessID=" & thisAPP.Run("GetCurrentProcessId"))

    For Each oProc In cProc

        'Rename EXCEL.EXE in the line below with the process that you need to Terminate.
        'NOTE: It is 'case sensitive
        If LCase(oProc.Name) = "excel.exe" Then
''            MsgBox "KILL"   ' used to display a message for testing pur
            errReturnCode = oProc.Terminate()
        End If
    Next
End Function
