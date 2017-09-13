Attribute VB_Name = "mod_Clear_Temps"
Function Clear_Temp_Files()
    
On Error Resume Next
    
    Dim FileSys As Object 'FileSystemObject
    Dim objFile As Object 'File
    Dim myFolder As Object
    Dim subF As Object
 
    'set path for files - change for your folder
    Dim myDir As String
    myDir = ThisWorkbook.Path
    
    'set up filesys objects
    Set FileSys = CreateObject("Scripting.FileSystemObject")
    Set myFolder = FileSys.GetFolder(myDir)
 
    'loop through each file and check for name match
    For Each objFile In myFolder.Files
        If objFile.Name <> ThisWorkbook.Name And objFile.Name <> "Template.xlsx" And objFile.Name <> "Generic_Consolidator.xlsb" And objFile.Name <> "Consolidator_Template.xlsx" Then
            Kill objFile
        End If
    Next objFile
    
    Call Remove_Subfolders_Files(myFolder)
    
    Set FileSys = Nothing
    Set myFolder = Nothing
    
End Function

Function Remove_Subfolders_Files(myFolder As Object)
    Dim subF As Object
    Dim objFile As Object
On Error Resume Next
    For Each subF In myFolder.SubFolders
        For Each objFile In subF.Files
            Kill objFile
        Next objFile
        Call Remove_Subfolders_Files(subF)
        RmDir subF
    Next subF
End Function
