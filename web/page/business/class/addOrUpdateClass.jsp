<%@ page import="java.sql.Connection" %>
<%@ include file="/page/utils/database.jsp"%>
<%--
  Created by IntelliJ IDEA.
  User: mikey
  Date: 4/22/19
  Time: 11:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/page/common/base.jsp"%>
<%
    //修改 添加
    String class_id = request.getParameter("class_id");

    Classes classe = null;

    Connection conn = getConn();

    User user = (User) session.getAttribute("user");

    if (class_id!=null&&class_id!=""){

        String sql = "select * from sys_classes where class_id = ?";

        PreparedStatement preparedStatement = conn.prepareStatement(sql);

        preparedStatement.setString(1,class_id);

        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()){
            classe = new Classes();

            classe.setClassId(resultSet.getString("class_id"));
            classe.setClassName(resultSet.getString("class_name"));
            classe.setDepId(resultSet.getString("dep_id"));
            classe.setClassMajor(resultSet.getString("class_major"));
            classe.setClassGrade(resultSet.getString("class_grade"));
        }

        System.out.println("修改班级："+class_id+"\t"+classe);
        close(preparedStatement,resultSet);
    }

    String sql = "select * from sys_department";

    PreparedStatement preparedStatement_dept = conn.prepareStatement(sql);

    ResultSet resultSet = preparedStatement_dept.executeQuery();

    List<Department> departments = new ArrayList<Department>();

    while (resultSet.next()){
        Department department = new Department();

        department.setDepId(resultSet.getString("dep_id"));
        department.setDepName(resultSet.getString("dep_name"));

        departments.add(department);
    }

    close(resultSet,preparedStatement_dept,conn);
%>
<!DOCTYPE html>
<html lang="zh-cn">
<body>
<div class="panel admin-panel">
    <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>班级信息</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="<%=path%>/action/business/class/<%=class_id!=null?"action_updateClass.jsp":"action_addClass.jsp"%>">
            <div class="clear"></div>
            <%--班级编号、所属二级学院、班级名称、年级、专业--%>
            <div class="form-group">
                <div class="label">
                    <label>班级编号：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="class_id" <%if (classe!=null){out.print("readonly='readonly'");}%> value="<%=classe!=null?classe.getClassId():""%>"  data-validate="required:班级编号不能为空" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>班级名称：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="class_name"  value="<%=classe!=null?classe.getClassName():""%>"  data-validate="required:班级名称不能为空" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>二级学院：</label>
                </div>
                <div class="field">
                    <%--<input type="text" class="input w50" name="dep_id"  value="<%=classe!=null?classe.getDepId():""%>"  data-validate="required:二级学院不能为空" />--%>
                        <select name="dep_id" class="input w50" readonly="readonly">
                            <%
                                for (Department dept:departments) {
                            %>
                            <option <%if (classe!=null&&classe.getDepId().equals(dept.getDepId())||(classe==null&&user.getInstructor().getDepId().equals(dept.getDepId()))){
                                    out.print("selected='selected'");
                                        }
                                    %>
                                    value="<%=dept.getDepId()%>"><%=dept.getDepName()%></option>
                            <%
                                }
                            %>
                        </select>
                        <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>所属专业：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="class_major"  value="<%=classe!=null?classe.getClassMajor():""%>"  data-validate="required:所属专业不能为空" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label>所在年级：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="class_grade" value="<%=classe!=null?classe.getClassGrade():""%>"  data-validate="required:所属年级不能为空;" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body></html>

