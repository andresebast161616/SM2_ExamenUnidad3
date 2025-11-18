import 'package:flutter_test/flutter_test.dart';

// Definición local de Usuario para pruebas
class Usuario {
  final String id;
  final String nombre;
  final String username;
  final String correo;
  final String telefono;
  final String rol;
  final String contrasena;

  Usuario({
    required this.id,
    required this.nombre,
    required this.username,
    required this.correo,
    required this.telefono,
    required this.rol,
    required this.contrasena,
  });
}

class MockFirestoreService {
  static bool retornarUsuarioCorrecto = true;
  static Set<String> correosRegistrados = {};
  static bool simularCorreoExistente = false;

  static Future<Usuario?> loginUsuario(String correo, String contrasena) async {
    if (!retornarUsuarioCorrecto) return null;
    if (correo == "usuario@demo.com" && contrasena == "abc123") {
      return Usuario(
        id: "10",
        nombre: "Demo User",
        username: "demouser",
        correo: correo,
        telefono: "5551234567",
        rol: "editor",
        contrasena: "hashDemo",
      );
    }
    return null;
  }

  static Future<bool> correoExiste(String correo) async {
    if (simularCorreoExistente) return true;
    return correosRegistrados.contains(correo);
  }

  static Future<bool> registrarUsuario(Usuario usuario) async {
    if (await correoExiste(usuario.correo)) {
      return false;
    }
    correosRegistrados.add(usuario.correo);
    return true;
  }

  static Future<Usuario?> obtenerUsuarioPorId(String id) async => null;
}

enum AuthState { idle, loading, success, error }

class AuthViewModelMock {
  AuthState state = AuthState.idle;
  Usuario? currentUser;
  String errorMessage = '';

  Future<void> login(String correo, String contrasena) async {
    if (correo.isEmpty || contrasena.isEmpty) {
      state = AuthState.error;
      errorMessage = 'Los campos no pueden estar vacíos';
      return;
    }

    state = AuthState.loading;

    final usuario = await MockFirestoreService.loginUsuario(correo, contrasena);

    if (usuario != null) {
      currentUser = usuario;
      state = AuthState.success;
    } else {
      state = AuthState.error;
      errorMessage = 'Credenciales incorrectas';
    }
  }
}

void main() {

  group('Pruebas unitarias del AuthViewModel', () {
    late AuthViewModelMock viewModel;

    setUp(() {
      viewModel = AuthViewModelMock();
    });

    test('Login exitoso con datos nuevos', () async {
      await viewModel.login("usuario@demo.com", "abc123");
      expect(viewModel.state, AuthState.success);
      expect(viewModel.currentUser?.nombre, "Demo User");
      expect(viewModel.currentUser?.rol, "editor");
    });

    test('Login fallido con contraseña incorrecta', () async {
      await viewModel.login("usuario@demo.com", "contraseña_erronea");
      expect(viewModel.state, AuthState.error);
      expect(viewModel.errorMessage, "Credenciales incorrectas");
    });

    test('Login fallido con correo incorrecto', () async {
      await viewModel.login("otro@correo.com", "abc123");
      expect(viewModel.state, AuthState.error);
      expect(viewModel.errorMessage, "Credenciales incorrectas");
    });

    test('Login fallido con campos vacíos', () async {
      await viewModel.login("", "");
      expect(viewModel.state, AuthState.error);
      expect(viewModel.errorMessage.isNotEmpty, true);
    });
  });

  group('Pruebas unitarias de creación de usuario', () {
    setUp(() {
      MockFirestoreService.correosRegistrados.clear();
      MockFirestoreService.simularCorreoExistente = false;
    });

    test('Registrar usuario con datos diferentes', () async {
      final nuevoUsuario = Usuario(
        id: "20",
        nombre: "Prueba Registro",
        username: "pruebauser",
        correo: "registro@demo.com",
        telefono: "1234567890",
        rol: "invitado",
        contrasena: "pass987",
      );
      final resultado = await MockFirestoreService.registrarUsuario(nuevoUsuario);
      expect(resultado, true);
      expect(MockFirestoreService.correosRegistrados.contains("registro@demo.com"), true);
    });

    test('No registrar usuario si el correo ya existe (nuevo caso)', () async {
      MockFirestoreService.simularCorreoExistente = true;
      final usuarioExistente = Usuario(
        id: "21",
        nombre: "Ya Existe",
        username: "existenteuser",
        correo: "existente@demo.com",
        telefono: "0987654321",
        rol: "invitado",
        contrasena: "pass321",
      );
      final resultado = await MockFirestoreService.registrarUsuario(usuarioExistente);
      expect(resultado, false);
    });
  });
}
