using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class LawyerPayout
{
    public Guid Id { get; set; }
    public Guid LawyerId { get; set; }
    public decimal Amount { get; set; }
    public PaymentMethod PaymentMethod { get; set; }
    public string? ProviderReference { get; set; }
    public PayoutStatus Status { get; set; } = PayoutStatus.Pending;
    public List<Guid> ConsultationIds { get; set; } = new();
    public DateTime CreatedAt { get; set; }
    public DateTime? CompletedAt { get; set; }

    // Navigation
    public User Lawyer { get; set; } = null!;
}
