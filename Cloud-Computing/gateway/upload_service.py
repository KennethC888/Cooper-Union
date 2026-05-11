from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/api/upload", methods=["POST"])
def upload():
    return jsonify({"status": "received", "service": "upload_service"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)