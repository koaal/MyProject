<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./inc/tags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<title><spring:message code="common.project.title" /></title>
<script type="text/javascript">
	if (top != self) {
		if (top.location != self.location)
			top.location = self.location;
	}
</script>
</head>
<style>
#login p {
	margin: 0;
	line-height: 12px;
}
</style>
<body id="cas">

	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" valign="middle">

				<table class="login_table_bg" width="100%" height="50" border="0" cellspacing="0" cellpadding="0" id="login">
					<tr>
						<td>
							<div id="mainlayout">
								<div id="heading">
									<div class="titel">
										<spring:message code="common.project.title" />
									</div>
								</div>

								<div id="container">

									<div class="middle middlecommon">
										<div class="innercontentcommon" id="innercontent">
											<form action="${ctx}/login.do" method="post">
												<table width="100%" cellspacing="0" id="loginpagetable">
													<tbody>
														<tr>
															<td class="titel_font">用户登录</td>
														</tr>

														<c:if test="${not empty shiroLoginFailure}">
															<tr>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td style="color: red">登录失败，请重试</td>
															</tr>
														</c:if>

														<tr>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>
																<table width="272" cellspacing="0" id="logintable">
																	<tbody>
																		<tr>
																			<td width="42%" align="right">用户名:</td>
																			<td width="58%"><input name="username" class="username" type="text" /></td>
																		</tr>
																		<tr>
																			<td align="right">密码:</td>
																			<td><input name="password" class="password" type="password" /></td>
																		</tr>
																		<tr>
																			<td align="left">&nbsp;</td>
																			<td align="left"><input name="submit" type="submit" class="login-button" value="登录" /></td>
																		</tr>
																	</tbody>
																</table>
															</td>
														</tr>

													</tbody>
												</table>
											</form>
										</div>
									</div>
								</div>
								<div id="footer">
									<div class="innercontentcommon2" id="innercontent2">
										<div class="innercontentcommon3"></div>
										请使用火狐浏览器(3.0或以上版本)
									</div>
								</div>
							</div>

							<div id="footer"></div>

						</td>
					</tr>
				</table>

			</td>
		</tr>
	</table>

</body>
</html>