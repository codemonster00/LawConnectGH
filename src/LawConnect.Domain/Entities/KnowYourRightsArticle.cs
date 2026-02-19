namespace LawConnect.Domain.Entities;

public class KnowYourRightsArticle
{
    public Guid Id { get; set; }
    public Guid? LegalTopicId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string Language { get; set; } = "en";
    public bool IsPublished { get; set; }
    public int ViewCount { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation
    public LegalTopic? LegalTopic { get; set; }
}
