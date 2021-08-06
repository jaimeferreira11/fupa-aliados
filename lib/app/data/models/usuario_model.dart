import 'package:fupa_aliados/app/data/models/sanatorio_model.dart';

class UsuarioModel {
  final String username;
  final String password;
  final String name;
  final String lastname;
  String email;
  String phonenumber;
  final String iddevice;
  final String image;
  final String tipodoc;
  final String capitan;

  final int tipobeneficiario;
  final int idpersona;
  final bool activated;
  final bool esCliente;
  final SanatorioModel sanatorio;
  final bool mostrarcantidad;

  UsuarioModel(
      {this.username,
      this.password,
      this.name,
      this.lastname,
      this.email,
      this.phonenumber,
      this.iddevice,
      this.image,
      this.tipodoc,
      this.capitan,
      this.tipobeneficiario,
      this.idpersona,
      this.activated,
      this.sanatorio,
      this.mostrarcantidad,
      this.esCliente});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phonenumber': phonenumber,
      'iddevice': iddevice,
      'image': image,
      'tipodoc': tipodoc,
      'capitan': capitan,
      'tipobeneficiario': tipobeneficiario,
      'idpersona': idpersona,
      'activated': activated,
      'esCliente': esCliente,
      'mostrarcantidad': mostrarcantidad ?? false,
      "sanatorio": sanatorio.toJson(),
    };
  }

  static UsuarioModel fromJson(Map<String, dynamic> map) {
    String avatar;

    if (map['image'] != null) {
      if (map['image'].indexOf('http') == -1) {
        avatar =
            'https://apps.fundacionparaguaya.org.py/fupapp-rest/public/image/profile/' +
                map['image'];
      } else {
        avatar = map['image'];
      }
    }
    // /image/profile/
    return UsuarioModel(
        username: map['username'],
        password: map['password'],
        name: map['name'],
        lastname: map['lastname'],
        email: map['email'],
        phonenumber: map['phonenumber'],
        iddevice: map['iddevice'],
        image: avatar,
        tipodoc: map['tipodoc'],
        capitan: map['capitan'],
        tipobeneficiario: map['tipobeneficiario'],
        idpersona: map['idpersona'],
        activated: map['activated'],
        mostrarcantidad: map['mostrarcantidad'] ?? false,
        sanatorio: map["sanatorio"] == null
            ? null
            : SanatorioModel.fromJson(map["sanatorio"]),
        esCliente: map['esCliente']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['password'] = this.password;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    data['image'] = this.image;
    data['idpersona'] = this.idpersona;
    data['tipobeneficiario'] = this.tipobeneficiario;
    data['tipodoc'] = this.tipodoc;
    data['esCliente'] = this.esCliente;
    data['mostrarcantidad'] = this.mostrarcantidad ?? false;
    return data;
  }

  @override
  String toString() {
    return 'Usuario(username: $username, password: $password, name: $name, lastname: $lastname, email: $email, phonenumber: $phonenumber, iddevice: $iddevice, image: $image, tipodoc: $tipodoc, capitan: $capitan, tipobeneficiario: $tipobeneficiario, idpersona: $idpersona, esCliente: $esCliente, activated: $activated)';
  }
}
