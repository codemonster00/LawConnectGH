using LawConnect.Infrastructure.Services;

namespace LawConnect.UnitTests;

public class AiServiceTests
{
    private readonly AiService _sut = new();

    [Fact]
    public async Task TriageConsultationAsync_ReturnsJsonResult()
    {
        var result = await _sut.TriageConsultationAsync("I have a land dispute with my neighbor over boundary markers");
        Assert.Contains("suggestedTopic", result);
        Assert.Contains("urgency", result);
    }

    [Fact]
    public async Task GenerateDocumentAsync_ReplacesPlaceholders()
    {
        var template = "Dear {{name}}, your case number is {{caseNumber}}.";
        var fields = new Dictionary<string, string>
        {
            { "name", "Kwame Asante" },
            { "caseNumber", "LC-2024-001" }
        };
        var result = await _sut.GenerateDocumentAsync(template, fields);
        Assert.Contains("Kwame Asante", result);
        Assert.Contains("LC-2024-001", result);
        Assert.DoesNotContain("{{name}}", result);
    }

    [Fact]
    public async Task SummarizeConsultationAsync_ReturnsSummary()
    {
        var messages = new[] { "Hello", "I need help with my tenancy", "Let me review your lease" };
        var result = await _sut.SummarizeConsultationAsync(messages);
        Assert.Contains("3 messages", result);
    }
}
