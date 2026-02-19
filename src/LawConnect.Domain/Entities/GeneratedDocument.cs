using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class GeneratedDocument
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public Guid TemplateId { get; set; }
    public Guid? ConsultationId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? FieldValues { get; set; } // JSON
    public string? GeneratedContent { get; set; }
    public string? FileUrl { get; set; }
    public DocumentStatus Status { get; set; } = DocumentStatus.Draft;
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation
    public User User { get; set; } = null!;
    public DocumentTemplate Template { get; set; } = null!;
    public Consultation? Consultation { get; set; }
}
