namespace LawConnect.Domain.Entities;

public class DocumentTemplate
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public Guid? LegalTopicId { get; set; }
    public string? Description { get; set; }
    public string TemplateBody { get; set; } = string.Empty;
    public string? FieldsSchema { get; set; } // JSON
    public decimal Price { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation
    public LegalTopic? LegalTopic { get; set; }
    public ICollection<GeneratedDocument> GeneratedDocuments { get; set; } = new List<GeneratedDocument>();
}
