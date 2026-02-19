using LawConnect.Application.Interfaces;
using LawConnect.Domain.Entities;
using LawConnect.Domain.Enums;
using Microsoft.EntityFrameworkCore;

namespace LawConnect.Infrastructure.Persistence;

public class ApplicationDbContext : DbContext, IApplicationDbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

    public DbSet<User> Users => Set<User>();
    public DbSet<OtpCode> OtpCodes => Set<OtpCode>();
    public DbSet<LawyerProfile> LawyerProfiles => Set<LawyerProfile>();
    public DbSet<LegalTopic> LegalTopics => Set<LegalTopic>();
    public DbSet<LawyerSpecialization> LawyerSpecializations => Set<LawyerSpecialization>();
    public DbSet<Consultation> Consultations => Set<Consultation>();
    public DbSet<Message> Messages => Set<Message>();
    public DbSet<DocumentTemplate> DocumentTemplates => Set<DocumentTemplate>();
    public DbSet<GeneratedDocument> GeneratedDocuments => Set<GeneratedDocument>();
    public DbSet<Payment> Payments => Set<Payment>();
    public DbSet<LawyerPayout> LawyerPayouts => Set<LawyerPayout>();
    public DbSet<KnowYourRightsArticle> KnowYourRightsArticles => Set<KnowYourRightsArticle>();
    public DbSet<Notification> Notifications => Set<Notification>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // User
        modelBuilder.Entity<User>(e =>
        {
            e.HasKey(u => u.Id);
            e.Property(u => u.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(u => u.PhoneNumber).HasMaxLength(20);
            e.Property(u => u.Email).HasMaxLength(255);
            e.Property(u => u.FullName).HasMaxLength(100);
            e.Property(u => u.PasswordHash).HasMaxLength(500);
            e.Property(u => u.AvatarUrl).HasMaxLength(500);
            e.Property(u => u.Region).HasMaxLength(100);
            e.Property(u => u.City).HasMaxLength(100);
            e.Property(u => u.PreferredLanguage).HasMaxLength(10).HasDefaultValue("en");
            e.Property(u => u.IsActive).HasDefaultValue(true);
            e.Property(u => u.CreatedAt).HasDefaultValueSql("now()");
            e.Property(u => u.UpdatedAt).HasDefaultValueSql("now()");
            e.Property(u => u.Role).HasConversion<string>().HasMaxLength(20);
            e.HasIndex(u => u.PhoneNumber).IsUnique();
            e.HasIndex(u => u.Email).IsUnique().HasFilter("\"Email\" IS NOT NULL");
            e.HasQueryFilter(u => !u.IsDeleted);
        });

        // OtpCode
        modelBuilder.Entity<OtpCode>(e =>
        {
            e.HasKey(o => o.Id);
            e.Property(o => o.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(o => o.PhoneOrEmail).HasMaxLength(255);
            e.Property(o => o.Code).HasMaxLength(10);
            e.Property(o => o.Purpose).HasConversion<string>().HasMaxLength(20);
            e.Property(o => o.CreatedAt).HasDefaultValueSql("now()");
            e.HasOne(o => o.User).WithMany(u => u.OtpCodes).HasForeignKey(o => o.UserId).OnDelete(DeleteBehavior.Cascade);
            e.HasIndex(o => new { o.PhoneOrEmail, o.Code, o.Purpose });
        });

        // LawyerProfile
        modelBuilder.Entity<LawyerProfile>(e =>
        {
            e.HasKey(l => l.Id);
            e.Property(l => l.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(l => l.BarNumber).HasMaxLength(50);
            e.Property(l => l.Bio).HasMaxLength(2000);
            e.Property(l => l.LawFirm).HasMaxLength(200);
            e.Property(l => l.ConsultationFee15Min).HasColumnType("decimal(10,2)");
            e.Property(l => l.ConsultationFee30Min).HasColumnType("decimal(10,2)");
            e.Property(l => l.TotalEarnings).HasColumnType("decimal(12,2)");
            e.Property(l => l.VerificationStatus).HasConversion<string>().HasMaxLength(20).HasDefaultValue(VerificationStatus.Pending);
            e.Property(l => l.IsAvailable).HasDefaultValue(true);
            e.Property(l => l.CreatedAt).HasDefaultValueSql("now()");
            e.Property(l => l.UpdatedAt).HasDefaultValueSql("now()");
            e.HasOne(l => l.User).WithOne(u => u.LawyerProfile).HasForeignKey<LawyerProfile>(l => l.UserId).OnDelete(DeleteBehavior.Cascade);
            e.HasIndex(l => l.BarNumber).IsUnique();
            e.HasIndex(l => l.VerificationStatus);
        });

        // LegalTopic
        modelBuilder.Entity<LegalTopic>(e =>
        {
            e.HasKey(t => t.Id);
            e.Property(t => t.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(t => t.Name).HasMaxLength(100);
            e.Property(t => t.Slug).HasMaxLength(100);
            e.Property(t => t.Description).HasMaxLength(500);
            e.Property(t => t.Icon).HasMaxLength(100);
            e.Property(t => t.IsActive).HasDefaultValue(true);
            e.HasIndex(t => t.Slug).IsUnique();
        });

        // LawyerSpecialization (composite key)
        modelBuilder.Entity<LawyerSpecialization>(e =>
        {
            e.HasKey(ls => new { ls.LawyerProfileId, ls.LegalTopicId });
            e.HasOne(ls => ls.LawyerProfile).WithMany(lp => lp.Specializations).HasForeignKey(ls => ls.LawyerProfileId);
            e.HasOne(ls => ls.LegalTopic).WithMany(lt => lt.LawyerSpecializations).HasForeignKey(ls => ls.LegalTopicId);
        });

        // Consultation
        modelBuilder.Entity<Consultation>(e =>
        {
            e.HasKey(c => c.Id);
            e.Property(c => c.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(c => c.ProblemDescription).HasMaxLength(5000);
            e.Property(c => c.ClientReview).HasMaxLength(2000);
            e.Property(c => c.Status).HasConversion<string>().HasMaxLength(20).HasDefaultValue(ConsultationStatus.Requested);
            e.Property(c => c.Type).HasConversion<string>().HasMaxLength(20);
            e.Property(c => c.TotalFee).HasColumnType("decimal(10,2)");
            e.Property(c => c.PlatformFee).HasColumnType("decimal(10,2)");
            e.Property(c => c.LawyerPayout).HasColumnType("decimal(10,2)");
            e.Property(c => c.CreatedAt).HasDefaultValueSql("now()");
            e.Property(c => c.UpdatedAt).HasDefaultValueSql("now()");
            e.HasOne(c => c.Client).WithMany(u => u.ClientConsultations).HasForeignKey(c => c.ClientId).OnDelete(DeleteBehavior.Restrict);
            e.HasOne(c => c.Lawyer).WithMany(u => u.LawyerConsultations).HasForeignKey(c => c.LawyerId).OnDelete(DeleteBehavior.Restrict);
            e.HasOne(c => c.LegalTopic).WithMany(t => t.Consultations).HasForeignKey(c => c.LegalTopicId).OnDelete(DeleteBehavior.SetNull);
            e.HasIndex(c => c.Status);
            e.HasIndex(c => c.ClientId);
            e.HasIndex(c => c.LawyerId);
        });

        // Message
        modelBuilder.Entity<Message>(e =>
        {
            e.HasKey(m => m.Id);
            e.Property(m => m.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(m => m.Content).HasMaxLength(10000);
            e.Property(m => m.AttachmentUrl).HasMaxLength(500);
            e.Property(m => m.MessageType).HasConversion<string>().HasMaxLength(20);
            e.Property(m => m.CreatedAt).HasDefaultValueSql("now()");
            e.HasOne(m => m.Consultation).WithMany(c => c.Messages).HasForeignKey(m => m.ConsultationId).OnDelete(DeleteBehavior.Cascade);
            e.HasIndex(m => m.ConsultationId);
        });

        // DocumentTemplate
        modelBuilder.Entity<DocumentTemplate>(e =>
        {
            e.HasKey(d => d.Id);
            e.Property(d => d.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(d => d.Name).HasMaxLength(200);
            e.Property(d => d.Slug).HasMaxLength(200);
            e.Property(d => d.Description).HasMaxLength(1000);
            e.Property(d => d.Price).HasColumnType("decimal(10,2)");
            e.Property(d => d.IsActive).HasDefaultValue(true);
            e.Property(d => d.CreatedAt).HasDefaultValueSql("now()");
            e.Property(d => d.UpdatedAt).HasDefaultValueSql("now()");
            e.HasOne(d => d.LegalTopic).WithMany(t => t.DocumentTemplates).HasForeignKey(d => d.LegalTopicId).OnDelete(DeleteBehavior.SetNull);
            e.HasIndex(d => d.Slug).IsUnique();
        });

        // GeneratedDocument
        modelBuilder.Entity<GeneratedDocument>(e =>
        {
            e.HasKey(g => g.Id);
            e.Property(g => g.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(g => g.Title).HasMaxLength(300);
            e.Property(g => g.FileUrl).HasMaxLength(500);
            e.Property(g => g.Status).HasConversion<string>().HasMaxLength(20).HasDefaultValue(DocumentStatus.Draft);
            e.Property(g => g.CreatedAt).HasDefaultValueSql("now()");
            e.Property(g => g.UpdatedAt).HasDefaultValueSql("now()");
            e.HasOne(g => g.Template).WithMany(t => t.GeneratedDocuments).HasForeignKey(g => g.TemplateId);
            e.HasIndex(g => g.UserId);
        });

        // Payment
        modelBuilder.Entity<Payment>(e =>
        {
            e.HasKey(p => p.Id);
            e.Property(p => p.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(p => p.Amount).HasColumnType("decimal(10,2)");
            e.Property(p => p.PlatformFee).HasColumnType("decimal(10,2)");
            e.Property(p => p.Currency).HasMaxLength(5).HasDefaultValue("GHS");
            e.Property(p => p.PaymentMethod).HasConversion<string>().HasMaxLength(20);
            e.Property(p => p.PaymentProvider).HasMaxLength(50);
            e.Property(p => p.ProviderReference).HasMaxLength(200);
            e.Property(p => p.Status).HasConversion<string>().HasMaxLength(20).HasDefaultValue(PaymentStatus.Pending);
            e.Property(p => p.CreatedAt).HasDefaultValueSql("now()");
            e.Property(p => p.UpdatedAt).HasDefaultValueSql("now()");
            e.HasOne(p => p.Consultation).WithMany(c => c.Payments).HasForeignKey(p => p.ConsultationId).OnDelete(DeleteBehavior.SetNull);
            e.HasIndex(p => p.ProviderReference);
        });

        // LawyerPayout
        modelBuilder.Entity<LawyerPayout>(e =>
        {
            e.HasKey(lp => lp.Id);
            e.Property(lp => lp.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(lp => lp.Amount).HasColumnType("decimal(10,2)");
            e.Property(lp => lp.PaymentMethod).HasConversion<string>().HasMaxLength(20);
            e.Property(lp => lp.ProviderReference).HasMaxLength(200);
            e.Property(lp => lp.Status).HasConversion<string>().HasMaxLength(20).HasDefaultValue(PayoutStatus.Pending);
            e.Property(lp => lp.CreatedAt).HasDefaultValueSql("now()");
            e.HasOne(lp => lp.Lawyer).WithMany().HasForeignKey(lp => lp.LawyerId);
        });

        // KnowYourRightsArticle
        modelBuilder.Entity<KnowYourRightsArticle>(e =>
        {
            e.HasKey(a => a.Id);
            e.Property(a => a.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(a => a.Title).HasMaxLength(300);
            e.Property(a => a.Slug).HasMaxLength(300);
            e.Property(a => a.Language).HasMaxLength(10).HasDefaultValue("en");
            e.Property(a => a.CreatedAt).HasDefaultValueSql("now()");
            e.Property(a => a.UpdatedAt).HasDefaultValueSql("now()");
            e.HasOne(a => a.LegalTopic).WithMany(t => t.Articles).HasForeignKey(a => a.LegalTopicId).OnDelete(DeleteBehavior.SetNull);
            e.HasIndex(a => a.Slug).IsUnique();
        });

        // Notification
        modelBuilder.Entity<Notification>(e =>
        {
            e.HasKey(n => n.Id);
            e.Property(n => n.Id).HasDefaultValueSql("gen_random_uuid()");
            e.Property(n => n.Title).HasMaxLength(200);
            e.Property(n => n.Body).HasMaxLength(2000);
            e.Property(n => n.Type).HasMaxLength(50);
            e.Property(n => n.CreatedAt).HasDefaultValueSql("now()");
            e.HasOne(n => n.User).WithMany(u => u.Notifications).HasForeignKey(n => n.UserId).OnDelete(DeleteBehavior.Cascade);
            e.HasIndex(n => new { n.UserId, n.IsRead });
        });

        // Seed Legal Topics
        SeedLegalTopics(modelBuilder);
    }

    private static void SeedLegalTopics(ModelBuilder modelBuilder)
    {
        var topics = new[]
        {
            ("Land & Property", "land-property", "⛏️"),
            ("Tenancy & Rent", "tenancy-rent", "🏠"),
            ("Employment & Labour", "employment-labour", "💼"),
            ("Family & Divorce", "family-divorce", "👨‍👩‍👧"),
            ("Criminal Defense", "criminal-defense", "⚖️"),
            ("Business & Corporate", "business-corporate", "🏢"),
            ("Contracts & Agreements", "contracts-agreements", "📝"),
            ("Debt & Collections", "debt-collections", "💰"),
            ("Inheritance & Wills", "inheritance-wills", "📜"),
            ("Immigration", "immigration", "✈️"),
            ("Human Rights", "human-rights", "🕊️"),
            ("Insurance Claims", "insurance-claims", "🛡️"),
        };

        var entities = topics.Select((t, i) => new LegalTopic
        {
            Id = Guid.NewGuid(),
            Name = t.Item1,
            Slug = t.Item2,
            Icon = t.Item3,
            DisplayOrder = i + 1,
            IsActive = true
        }).ToArray();

        modelBuilder.Entity<LegalTopic>().HasData(entities);
    }
}
