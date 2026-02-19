using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class Payment
{
    public Guid Id { get; set; }
    public Guid? ConsultationId { get; set; }
    public Guid? DocumentId { get; set; }
    public Guid PayerId { get; set; }
    public Guid? PayeeId { get; set; }
    public decimal Amount { get; set; }
    public decimal PlatformFee { get; set; }
    public string Currency { get; set; } = "GHS";
    public PaymentMethod PaymentMethod { get; set; }
    public string? PaymentProvider { get; set; }
    public string? ProviderReference { get; set; }
    public PaymentStatus Status { get; set; } = PaymentStatus.Pending;
    public DateTime? HeldAt { get; set; }
    public DateTime? CompletedAt { get; set; }
    public DateTime? RefundedAt { get; set; }
    public string? Metadata { get; set; } // JSON
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation
    public Consultation? Consultation { get; set; }
    public User Payer { get; set; } = null!;
    public User? Payee { get; set; }
}
