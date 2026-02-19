using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class Consultation
{
    public Guid Id { get; set; }
    public Guid ClientId { get; set; }
    public Guid? LawyerId { get; set; }
    public Guid? LegalTopicId { get; set; }
    public ConsultationStatus Status { get; set; } = ConsultationStatus.Requested;
    public ConsultationType Type { get; set; }
    public int? DurationMinutes { get; set; }
    public string ProblemDescription { get; set; } = string.Empty;
    public string? AiTriageResult { get; set; } // JSON
    public DateTime? StartedAt { get; set; }
    public DateTime? EndedAt { get; set; }
    public int? ClientRating { get; set; }
    public string? ClientReview { get; set; }
    public string? AiSummary { get; set; }
    public decimal TotalFee { get; set; }
    public decimal PlatformFee { get; set; }
    public decimal LawyerPayout { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation
    public User Client { get; set; } = null!;
    public User? Lawyer { get; set; }
    public LegalTopic? LegalTopic { get; set; }
    public ICollection<Message> Messages { get; set; } = new List<Message>();
    public ICollection<Payment> Payments { get; set; } = new List<Payment>();
}
