Sub PulisciDati()
    Dim ws As Worksheet
    Dim foglio As String
    
    ' Imposta il foglio su "Risultato" o un altro a tua scelta
    foglio = "Risultato"
    
    ' Verifica se il foglio esiste
    On Error Resume Next
    Set ws = Sheets(foglio)
    On Error GoTo 0
    
    ' Se il foglio esiste, lo pulisce
    If Not ws Is Nothing Then
        ws.Cells.Clear
        MsgBox "Dati puliti con successo nel foglio '" & foglio & "'!", vbInformation
    Else
        MsgBox "Il foglio '" & foglio & "' non esiste.", vbCritical
    End If
End Sub
