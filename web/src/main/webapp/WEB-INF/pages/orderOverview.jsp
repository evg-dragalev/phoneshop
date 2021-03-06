<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/template/order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<template:page>
  <jsp:body>
    <template:header/>
    <div class="m-5">
      <template:nav pageName="Order number: ${order.id}">
        <jsp:attribute name="content">
          <span class="h4"><small class="text-success">Thank you for your order</small></span>
        </jsp:attribute>
      </template:nav>

      <order:order-table order="${order}"/>

      <div class="row">

        <dl class="row">
          <dt class="col-3">First Name</dt>
          <dd class="col-9">${order.firstName}</dd>

          <dt class="col-3">Last name</dt>
          <dd class="col-9">${order.lastName}</dd>

          <dt class="col-3">Address</dt>
          <dd class="col-9">${order.deliveryAddress}</dd>

          <dt class="col-3">Phone</dt>
          <dd class="col-9">${order.contactPhoneNo}</dd>
        </dl>

        <c:if test="${not empty order.additionalInfo}">
          <div class="col-sm-6">
            <p>${order.additionalInfo}</p>
          </div>
        </c:if>
      </div>

      <a href="${pageContext.servletContext.contextPath}/productList" class="btn btn-primary">Back to shopping</a>
    </div>
  </jsp:body>
</template:page>
