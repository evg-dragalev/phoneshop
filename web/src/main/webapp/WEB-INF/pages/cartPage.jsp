<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>
<template:page>
  <jsp:attribute name="scripts">
    <script src="<c:url value="/resources/js/addToCartForm.js"/>"></script>
  </jsp:attribute>
  <jsp:body>
    <template:header cartQuantity="${cartQuantity}" cartSubTotal="${cartSubTotal}"/>

    <div class="mt-5 mr-5 ml-5">
      <nav class="navbar navbar-light bg-light justify-content-between">
        <h4>Phone</h4>
      </nav>

      <div class="row justify-content-between mt-3 mb-3">
          <a class="btn btn-primary col-2" href="${pageContext.servletContext.contextPath}/productList">Back to product
            list</a>

        <a class="btn btn-primary col-1" href="${pageContext.servletContext.contextPath}/productList">Order</a>
      </div>

      <c:choose>
        <c:when test="${not empty cart.products}">
          <div class="row">
            <form:form action="${pageContext.servletContext.contextPath}/cart" method="put" modelAttribute="updateCartForm" cssClass="col">
              <table class="table">
                <thead>
                <tr>
                  <td scope="col">Image</td>
                  <td scope="col">Brand</td>
                  <td scope="col">Model</td>
                  <td scope="col">Color</td>
                  <td scope="col">Display size</td>
                  <td scope="col">Price</td>
                  <td scope="col">Quantity</td>
                  <td scope="col">Action</td>
                </tr>
                </thead>
                <c:forEach var="cartEntry" items="${cart.products.values()}">
                  <tr>
                    <td class="align-middle">
                      <a href="${pageContext.servletContext.contextPath}/productDetails/${cartEntry.phone.id}">
                        <img src="https://raw.githubusercontent.com/andrewosipenko/phoneshop-ext-images/master/${cartEntry.phone.imageUrl}"
                             height="80">
                      </a>
                    </td>
                    <td class="align-middle">${cartEntry.phone.brand}</td>
                    <td class="align-middle">
                      <a href="${pageContext.servletContext.contextPath}/productDetails/${cartEntry.phone.id}">${cartEntry.phone.model}</a>
                    </td>
                    <td class="align-middle">
                      <template:colors colors="${cartEntry.phone.colors}"/>
                    </td>
                    <td class="align-middle">${cartEntry.phone.displaySizeInches}"</td>
                    <td class="align-middle">
                      <c:choose>
                        <c:when test="${not empty cartEntry.phone.price}">$${cartEntry.phone.price}</c:when>
                        <c:otherwise>unknown</c:otherwise>
                      </c:choose>
                    </td>
                    <td class="align-middle">
                      <div class="input-group">
                        <form:input path="quantities[${cartEntry.phone.id}].phoneId"
                                    value="${updateCartForm.quantities[cartEntry.phone.id].phoneId}"
                                    hidden="hidden"/>
                        <form:input path="quantities[${cartEntry.phone.id}].quantity"
                                           cssClass="form-control quantity-input ${not empty errors['quantities['.concat(cartEntry.phone.id).concat('].quantity')]?'is-invalid':''}"
                                           value="${updateCartForm.quantities[cartEntry.phone.id].quantity}"/>
                        <div class="invalid-tooltip">
                          <c:forEach items="${errors['quantities['.concat(cartEntry.phone.id).concat('].quantity')]}" var="message"><p class="mb-0">${message}</p></c:forEach>
                        </div>
                      </div>
                    </td>
                    <td class="align-middle">
                      <div class="btn-group-toggle" data-toggle="buttons">
                        <label class="btn btn-light ${updateCartForm.quantities[cartEntry.phone.id].toDelete? 'active':''}">
                          <form:checkbox path="quantities[${cartEntry.phone.id}].toDelete" value="${updateCartForm.quantities[cartEntry.phone.id].toDelete}"/>Delete
                        </label>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </table>

              <div class="row justify-content-end mt-3 mb-3">
                <input type="submit" class="btn btn-primary col-1" value="Update"/>
                <a href="#" class="btn btn-primary col-1 ml-3">Order</a>
              </div>
            </form:form>

          </div>

        </c:when>
        <c:otherwise>
          <div class="row">
            <div class="col">
              <h3 class="text-secondary text-center">Your cart is empty</h3>
            </div>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </jsp:body>
</template:page>

