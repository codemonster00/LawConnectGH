namespace LawConnect.Application.DTOs.Documents;

public class DocumentTemplateDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? LegalTopicName { get; set; }
    public string? FieldsSchema { get; set; }
    public decimal Price { get; set; }
}

public class GenerateDocumentRequest
{
    public Guid TemplateId { get; set; }
    public Guid? ConsultationId { get; set; }
    public string Title { get; set; } = string.Empty;
    public Dictionary<string, string> FieldValues { get; set; } = new();
}

public class GeneratedDocumentDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string TemplateName { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public string? FileUrl { get; set; }
    public DateTime CreatedAt { get; set; }
}
