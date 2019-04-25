<%--
  Created by IntelliJ IDEA.
  program: Leave_sys
  Author: 麦奇
  Email： 1625017540@qq.com
  Date: 4/23/19
  Time: 9:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/page/common/base.jsp"%>
<%@ include file="/page/utils/database.jsp"%>
<%
    List<User> users = null;

    User user = null;

    Student student = null;

    String start1 = request.getParameter("start");//开始下标

    String total1 = request.getParameter("total");//当前页记录数

    Integer start=start1!=null&&start1!=""?Integer.parseInt(start1):0;
    Integer total=total1!=null&&total1!=""?Integer.parseInt(total1):Integer.MAX_VALUE;


    Connection conn = getConn();

    String sql = "select * from sys_user su ,sys_student ss where su.user_id = ss.user_id limit ?,?";

    PreparedStatement preparedStatement = conn.prepareStatement(sql);

    preparedStatement.setInt(1,start);
    preparedStatement.setInt(2,total);

    ResultSet resultSet = preparedStatement.executeQuery();

    users = new ArrayList<User>();

   while (resultSet.next()){
       user = new User();

       user.setUserId(resultSet.getInt("user_id"));
       user.setUsername(resultSet.getString("user_name"));
       user.setUserPassword(resultSet.getString("user_password"));
       user.setUserType(resultSet.getInt("user_type"));
       user.setUserAvailable(resultSet.getInt("user_available"));

       student = new Student();

       student.setStuId(resultSet.getString("stu_id"));
       student.setUserId(resultSet.getInt("user_id"));
       student.setClassId(resultSet.getString("class_id"));
       student.setStuName(resultSet.getString("stu_name"));
       student.setStuSex(resultSet.getString("stu_sex"));
       student.setStuAddress(resultSet.getString("stu_address"));
       student.setStuTelephone(resultSet.getString("stu_telephone"));
       student.setStuContact(resultSet.getString("stu_contact"));
       student.setStuContactTel(resultSet.getString("stu_contactTel"));

       user.setStudent(student);

       users.add(user);
   }

   request.setAttribute("students",users);

   process(request,response,"/page/business/student/studentList.jsp");

%>