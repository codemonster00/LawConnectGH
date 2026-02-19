namespace LawConnect.Domain.Entities;

public class LegalTopic
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Icon { get; set; }
    public int DisplayOrder { get; set; }
    public bool IsActive { get; set; } = true;

    // Navigation
    public ICollection<LawyerSpecialization> LawyerSpecializations { get; set; } = new List<LawyerSpecialization>();
    public ICollection<Consultation> Consultations { get; set; } = new List<Consultation>();
    public ICollection<DocumentTemplate> DocumentTemplates { get; set; } = new List<DocumentTemplate>();
    public ICollection<KnowYourRightsArticle> Articles { get; set; } = new List<KnowYourRightsArticle>();
}
