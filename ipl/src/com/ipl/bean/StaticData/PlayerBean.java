package com.ipl.bean.StaticData;

public class PlayerBean
{
    private int playerId;

    private String firstName;

    private String lastName;

    private int roleId;

    private String role;

    private int categoryId;

    private String category;

    private PointsBean pointsBean;

    public PointsBean getPointsBean()
    {
        return pointsBean;
    }

    public void setPointsBean(PointsBean pointsBean)
    {
        this.pointsBean = pointsBean;
    }

    public int getPlayerId()
    {
        return playerId;
    }

    public void setPlayerId(int playerId)
    {
        this.playerId = playerId;
    }

    public String getFirstName()
    {
        return firstName;
    }

    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }

    public String getLastName()
    {
        return lastName;
    }

    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }

    public int getRoleId()
    {
        return roleId;
    }

    public void setRoleId(int roleId)
    {
        this.roleId = roleId;
    }

    public String getRole()
    {
        return role;
    }

    public void setRole(String role)
    {
        this.role = role;
    }

    public int getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(int categoryId)
    {
        this.categoryId = categoryId;
    }

    public String getCategory()
    {
        return category;
    }

    public void setCategory(String category)
    {
        this.category = category;
    }

}
