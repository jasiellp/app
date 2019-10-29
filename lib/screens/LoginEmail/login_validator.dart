import 'dart:async';

class LoginValidators {

  final validateCpfCnpj = StreamTransformer<String, String>.fromHandlers(
      handleData: (cpfCnpj, sink){
        cpfCnpj = cpfCnpj.trim().replaceAll("/", "").replaceAll("-", "")
            .replaceAll(" ", "").replaceAll(".", "").replaceAll(",", "");
        if(cpfCnpj.length <= 16 && cpfCnpj.length >= 9){
          sink.add(cpfCnpj);
        } else {
          sink.addError("Insira um CPF/CNPJ válido");
        }
      }
  );

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink){
        email = email.trim().toLowerCase();
        if(email.contains("@") && email.contains(".com")){
          sink.add(email);
        } else {
          sink.addError("Insira um e-mail válido");
        }
      }
  );

  final validateSenha = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink){
        if(password.length >= 6){
          sink.add(password);
        } else {
          sink.addError("Senha inválida, deve conter pelo menos 6 caracteres");
        }
      }
  );

  final validateNome = StreamTransformer<String, String>.fromHandlers(
      handleData: (nome, sink){
        if(nome.length >= 3){
          sink.add(nome);
        } else {
          sink.addError("Nome inválido, deve conter pelo menos 3 caracteres");
        }
      }
  );

}