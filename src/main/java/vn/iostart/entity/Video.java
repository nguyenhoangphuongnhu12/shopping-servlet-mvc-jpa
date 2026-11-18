package vn.iostart.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "Videos")
public class Video implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "VideoId")
    private int videoId;

    @Column(name = "Title", columnDefinition = "NVARCHAR(255)")
    private String title;

    @Column(name = "Poster", columnDefinition = "NVARCHAR(255)")
    private String poster;

    @Column(name = "VideoUrl", columnDefinition = "NVARCHAR(255)")
    private String videoUrl;

    @Column(name = "Views")
    private int views;

    @Column(name = "Description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "Active")
    private boolean active;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    public Video() {}

    public int getVideoId() { return videoId; }
    public void setVideoId(int videoId) { this.videoId = videoId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}