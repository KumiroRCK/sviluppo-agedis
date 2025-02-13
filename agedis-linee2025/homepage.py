from flask import Flask, render_template, request, send_file
import pandas as pd

app = Flask(__name__)
file_path = 'LINEE 2025 - CONDIVISO.xlsx'

# Caricare i dati
anagrafica = pd.read_excel(file_path, sheet_name='AnagraficaArticoli')
dashboard = pd.read_excel(file_path, sheet_name='Dashboard_Ordini')
proposte = pd.read_excel(file_path, sheet_name='Proposte_Inviate')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/anagrafica')
def mostra_anagrafica():
    dati = anagrafica.to_dict('records')
    return render_template('tabella.html', titolo="Anagrafica Articoli", dati=dati)

@app.route('/dashboard')
def mostra_dashboard():
    dati = dashboard.to_dict('records')
    return render_template('tabella.html', titolo="Dashboard Ordini", dati=dati)

@app.route('/proposte')
def mostra_proposte():
    dati = proposte.to_dict('records')
    return render_template('tabella.html', titolo="Proposte Inviate", dati=dati)

@app.route('/export/<sheet_name>')
def export(sheet_name):
    if sheet_name == 'anagrafica':
        df = anagrafica
    elif sheet_name == 'dashboard':
        df = dashboard
    elif sheet_name == 'proposte':
        df = proposte
    else:
        return "Foglio non trovato"

    export_path = f'/tmp/{sheet_name}.csv'
    df.to_csv(export_path, index=False)
    return send_file(export_path, as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)
