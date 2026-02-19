namespace LawConnect.Domain.Entities;

public class LawyerSpecialization
{
    public Guid LawyerProfileId { get; set; }
    public Guid LegalTopicId { get; set; }

    // Navigation
    public LawyerProfile LawyerProfile { get; set; } = null!;
    public LegalTopic LegalTopic { get; set; } = null!;
}
