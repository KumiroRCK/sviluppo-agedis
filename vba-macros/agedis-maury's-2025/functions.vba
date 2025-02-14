Sub CalcolaVendite()
    Dim wsOrigine As Worksheet
    Dim wsRisultato As Worksheet
    Dim puntoVendita As String
    Dim ultimaRiga As Long
    Dim i As Long
    Dim col As Integer
    
    ' Definizioni fogli
    Set wsOrigine = Sheets("Riepilogo")
    Set wsRisultato = Sheets("Risultato")
    
    ' Pulisce il foglio dei risultati
    wsRisultato.Cells.Clear
    
    ' Legge il punto vendita scelto dal menu a tendina
    puntoVendita = Sheets("Dashboard").Range("A1").Value
    
    ' Trova la colonna corrispondente al punto vendita
    col = Application.WorksheetFunction.Match(puntoVendita, wsOrigine.Rows(1), 0)
    
    ' Copia le intestazioni
    wsRisultato.Cells(1, 1).Value = "Descrizione articolo"
    wsRisultato.Cells(1, 2).Value = "Barcode"
    wsRisultato.Cells(1, 3).Value = "40% (arrotondato)"
    wsRisultato.Cells(1, 4).Value = "30% (arrotondato)"
    wsRisultato.Cells(1, 5).Value = "Rimanenza"
    
    ' Calcolo righe
    ultimaRiga = wsOrigine.Cells(wsOrigine.Rows.Count, 1).End(xlUp).Row
    
    ' Ciclo per calcolare i valori
    For i = 2 To ultimaRiga
        wsRisultato.Cells(i, 1).Value = wsOrigine.Cells(i, 1).Value ' Descrizione
        wsRisultato.Cells(i, 2).Value = wsOrigine.Cells(i, 2).Value ' Barcode
        
        ' Calcolo 40% arrotondato per difetto
        wsRisultato.Cells(i, 3).Value = WorksheetFunction.RoundDown(wsOrigine.Cells(i, col).Value * 0.4, 0)
        
        ' Calcolo 30% arrotondato per difetto
        wsRisultato.Cells(i, 4).Value = WorksheetFunction.RoundDown(wsOrigine.Cells(i, col).Value * 0.3, 0)
        
        ' Calcolo Rimanenza
        wsRisultato.Cells(i, 5).Value = wsOrigine.Cells(i, col).Value - _
            (WorksheetFunction.RoundDown(wsOrigine.Cells(i, col).Value * 0.4, 0) + _
             WorksheetFunction.RoundDown(wsOrigine.Cells(i, col).Value * 0.3, 0))
    Next i
    
    MsgBox "Calcolo completato per il punto vendita: " & puntoVendita, vbInformation
End Sub
