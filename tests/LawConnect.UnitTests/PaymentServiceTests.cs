using LawConnect.Infrastructure.Services;

namespace LawConnect.UnitTests;

public class PaymentServiceTests
{
    private readonly PaymentService _sut = new();

    [Fact]
    public async Task InitiatePaymentAsync_ReturnsMockReference()
    {
        var result = await _sut.InitiatePaymentAsync(50.00m, "GHS", "+233201234567", "REF-001");
        Assert.StartsWith("MOCK-PAY-", result);
    }

    [Fact]
    public async Task VerifyPaymentAsync_ReturnsTrue()
    {
        var result = await _sut.VerifyPaymentAsync("REF-001");
        Assert.True(result);
    }
}
