<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>Lista Contas</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

	function deuCerto(dadosDaResposta) {
	  alert("Conta paga com sucesso!");
	}
	<!--
	function pagaAgora(id) {
	  $.get("pagaConta?id="+id, deuCerto);
	}
	-->
	function pagaAgora(id) {
		$.post("pagaConta", {'id' : id}, function() {
		  $("#conta_"+id).html("Paga");	
		  $("#dataPagamento_"+id).val(${conta.dataPagamento.time});
		});
	}

</script>

</head>
<body>

    <table style="height: 10px; width: 775px;" border="1">
        <tr>
        <th>Código</th>
        <th>Descrição</th>
        <th>Valor</th>
        <th>Tipo</th>
        <th>Paga?</th>
        <th>Data de pagamento</th>
        <th>Ações</th>
        
        </tr>

        <c:forEach items="${contas}" var="conta">
        <tr>
            <td>${conta.id}</td>
            <td>${conta.descricao}</td>
            <td>${conta.valor}</td>
            <td>${conta.tipo}</td>
            <td id="conta_${conta.id}">
                <c:if test="${conta.paga eq false}">
                    Não paga
                </c:if>
                <c:if test="${conta.paga eq true }">
                    Paga!
                </c:if>
            </td>
            <td id= "dataPagamento_"><fmt:formatDate value="${conta.dataPagamento.time}" pattern="dd/MM/yyyy"/></td>
            <td>
            	<a href="removeConta?id=${conta.id}">Deletar</a> |
            	<a href="mostraConta?id=${conta.id}">Alterar</a> |
            	<c:if test="${conta.paga eq false }">
	            	<!-- 
	            	<a href="pagaConta?id=${conta.id}">Pagar</a>
	            	 --> 
	            	<a href="#" onclick="pagaAgora(${conta.id});">Pagar</a>
            	</c:if> 
            </td>            
        </tr>        
        </c:forEach>        
        
    </table>
    
    <a href="logout">Logout</a>

</body>
</html>
