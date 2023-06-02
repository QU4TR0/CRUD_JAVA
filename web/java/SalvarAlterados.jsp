<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         // 1) Receber os dados vindos do formulário]o
         int codigo;
         String nome, marca;
         double preco;
         codigo = Integer.parseInt(request.getParameter("codigo"));
         nome = request.getParameter("nome");
         marca = request.getParameter("marca");
         String p = request.getParameter("preco");  //12,5
         preco = Double.parseDouble(p.replace("," , "."));  //12.5
         //preco = Double.parseDouble(request.getParameter("preco"));
         
         try {
         // 2) Conectar com o Banco de Dados
         
         Class.forName("com.mysql.jdbc.Driver");
         Connection conexao = DriverManager.getConnection ("jdbc:mysql://localhost:3307/bancoterca","root","01202129");

         // 3) Enviar os dados para a tabela do banco de dados
         
         PreparedStatement st = conexao.prepareStatement("UPDATE produtos SET nome = ?, marca = ?, preco = ? WHERE codigo = ?");
         st.setString(1, nome);
         st.setString(2, marca);
         st.setDouble(3, preco);
         st.setInt(4, codigo);
         st.executeUpdate(); // executa o INSERT na tabela do BD
         out.print("<h1>Dados alterados com sucesso!</h1><br><a href='../telas/AlterarProdutos.html'>Alterar outro produto</a>");
         
         
         // 4) Desconectar do banco de dados
         
         conexao.close();
         } catch(ClassNotFoundException x){
            out.print("Você não colocou o drive JDBC no projeto" + x.getMessage());   
         } catch(SQLException x) {
            out.print("Você digitou alguma coisa de SQL errado" + x.getMessage());
         }
        %>
    </body>
</html>
