from flask import Flask, jsonify, make_response

app = Flask(__name__)


@app.route('/')
def hola_aws101_root():
    return jsonify(message='Hola AWS101')


@app.route('/voluntarios')
def voluntarios():
    return jsonify(message='Hola voluntarios')


@app.route('/sponsors')
def sponsors_root():
    return jsonify(message='Hola sponsors de AWS101')


@app.errorhandler(404)
def not_found(e):
    return make_response(jsonify(error='No encontrado'), 404)
