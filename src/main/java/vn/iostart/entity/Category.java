package vn.iostart.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryid;

    @Column(name = "CategoryName", columnDefinition = "nvarchar(255) not null")
    private String categoryname;

    @Column(name = "Images", columnDefinition = "nvarchar(500) null")
    private String images;

    @Column(name = "Status")
    private int status;

    public Category() {}

    public int getCategoryid() { return categoryid; }
    public void setCategoryid(int categoryid) { this.categoryid = categoryid; }
    public String getCategoryname() { return categoryname; }
    public void setCategoryname(String categoryname) { this.categoryname = categoryname; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
}