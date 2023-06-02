<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../css/formata_tabela.css">
        <title>Consultar Produtos</title>
    </head>
    <body>
        <%
            //1) receber o nome do produto
            String nome;
            nome = request.getParameter("nome");

            try {
                //2) conectar no banco de dados
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost:3307/bancoterca", "root", "01202129");
                //3) buscar o nome do produto na tabela
                PreparedStatement st = conexao.prepareStatement("SELECT * FROM produtos p WHERE nome LIKE ?");
                st.setString(1, "%" + nome + "%");

                ResultSet resultado = st.executeQuery();
                //4) Se o produto for encontrado, exibir os dados
                // Sen�o, exibir uma mensagem avisando que o produto n�o foi encontrado
                out.print("<table>");
                out.print("<tr><th>C�digo</th><th>Nome</th><th>Marca</th><th>Pre�o</th><th>Exclus�o</th><th>Altera��o</th></tr>");
                while (resultado.next()) { //Fa�a enquanto tiver produtos na vari�vel resultado
                   out.print("<tr><td>" + resultado.getString("codigo") + "</td><td>" + resultado.getString("nome") + "</td><td>" + resultado.getString("marca") + "</td><td>" + resultado.getString("preco") + "</td><td><a href='ExcluirProdutos.jsp?codigo=" + resultado.getString("codigo") + "'>Excluir</a></td><td><a href='BuscarProdutos.jsp?codigo=" + resultado.getString("codigo") +"'>Alterar</a></td></tr>");
                }
                out.print("</table>");
                //5) Fechar a conex�o com o banco de dados
                conexao.close();
            } catch (ClassNotFoundException x) {
                out.print("Voc� n�o colocou o drive JDBC no projeto" + x.getMessage());
            } catch (SQLException x) {
                out.print("Voc� digitou alguma coisa de SQL errado" + x.getMessage());
            }
        %>
    </body>
</html>
