class AuthController {
  // Funciones para autenticación (registro, inicio de sesión, cierre de sesión, etc.)
  Future<bool> login(String email, String password) async {
    // Lógica de autenticación que conecte con el repositorio o servicio
    return email == "test@example.com" && password == "password";
  }
}
