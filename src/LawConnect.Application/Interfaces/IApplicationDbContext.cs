using LawConnect.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace LawConnect.Application.Interfaces;

public interface IApplicationDbContext
{
    DbSet<User> Users { get; }
    DbSet<OtpCode> OtpCodes { get; }
    DbSet<LawyerProfile> LawyerProfiles { get; }
    DbSet<LegalTopic> LegalTopics { get; }
    DbSet<LawyerSpecialization> LawyerSpecializations { get; }
    DbSet<Consultation> Consultations { get; }
    DbSet<Message> Messages { get; }
    DbSet<DocumentTemplate> DocumentTemplates { get; }
    DbSet<GeneratedDocument> GeneratedDocuments { get; }
    DbSet<Payment> Payments { get; }
    DbSet<LawyerPayout> LawyerPayouts { get; }
    DbSet<KnowYourRightsArticle> KnowYourRightsArticles { get; }
    DbSet<Notification> Notifications { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
