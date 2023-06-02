<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Alteração de Produtos</title>
    </head>
    <body>
        <%
          //1) receber o nome do produto
          int codigo;
          codigo = Integer.parseInt(request.getParameter("codigo"));
          
          try {
          //2) conectar no banco de dados
          Class.forName("com.mysql.jdbc.Driver");
          Connection conexao = DriverManager.getConnection ("jdbc:mysql://localhost:3307/bancoterca","root","01202129");
          //3) buscar o nome do produto na tabela
          PreparedStatement st = conexao.prepareStatement("SELECT * FROM produtos p WHERE codigo = ?");
          st.setInt(1, codigo);
          
          ResultSet resultado = st.executeQuery();
          //4) Se o produto for encontrado, exibir os dados
          // Senão, exibir uma mensagem avisando que o produto não foi encontrado
          if (resultado.next()){
        %>
        <form method="post" action="SalvarAlterados.jsp">
            <p>
                <label for="codigo">Código:</label>
                <input type="number" readonly id="codigo" name="codigo" value="<%= resultado.getInt("codigo") %>">
            </p>
            <p>
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= resultado.getString("nome") %>">
            </p>
            <p>
                <label for="marca">Marca:</label>
                <input type="text" id="marca" name="marca" value="<%= resultado.getString("marca") %>">
            </p>
            <p>
                <label for="preco"> Preço: </label>
                <input type="text" name="preco" id="preco" pattern="[0-9]{1,9}\.[0-9]{1,2}$" value="<%= resultado.getString("preco").replace("." , ",") %>">
            </p>
            <p>
                <input type="submit" value="Salvar Alterações">
            </p>
        </form>
        <%
            } else {
                out.print("Produto não econtrado!");
            }
          //5) Fechar a conexão com o banco de dados
          conexao.close();
          } catch(ClassNotFoundException x){
            out.print("Você não colocou o drive JDBC no projeto" + x.getMessage());   
          } catch(SQLException x) {
            out.print("Você digitou alguma coisa de SQL errado" + x.getMessage());
         }
        %>
    </body>
</html>
