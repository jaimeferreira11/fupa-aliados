class RespuestaModel {
  String estado;

  dynamic datos;

  String error;

  RespuestaModel({
    this.estado,
    this.datos,
    this.error,
  });

  static RespuestaModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return RespuestaModel(
      estado: json['estado'],
      datos: json['datos'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado'] = this.estado;
    data['error'] = this.error;
    data['datos'] = this.datos;
    return data;
  }
}
