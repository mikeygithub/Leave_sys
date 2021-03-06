package com.mikey.entity;

import java.util.List;

public class Classes {
    private String classId;

    private String className;

    private String depId;

    private String classMajor;

    private String classGrade;

    private Department departments;

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId == null ? null : classId.trim();
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public String getDepId() {
        return depId;
    }

    public void setDepId(String depId) {
        this.depId = depId == null ? null : depId.trim();
    }

    public String getClassMajor() {
        return classMajor;
    }

    public void setClassMajor(String classMajor) {
        this.classMajor = classMajor == null ? null : classMajor.trim();
    }

    public String getClassGrade() {
        return classGrade;
    }

    public void setClassGrade(String classGrade) {
        this.classGrade = classGrade == null ? null : classGrade.trim();
    }

    public Department getDepartments() {
        return departments;
    }

    public void setDepartments(Department departments) {
        this.departments = departments;
    }

    @Override
    public String toString() {
        return "Classes{" +
                "classId='" + classId + '\'' +
                ", className='" + className + '\'' +
                ", depId='" + depId + '\'' +
                ", classMajor='" + classMajor + '\'' +
                ", classGrade='" + classGrade + '\'' +
                ", departments=" + departments +
                '}';
    }
}