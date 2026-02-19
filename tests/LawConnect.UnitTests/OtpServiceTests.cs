using LawConnect.Infrastructure.Services;

namespace LawConnect.UnitTests;

public class OtpServiceTests
{
    private readonly OtpService _sut = new();

    [Fact]
    public void GenerateOtp_Returns6DigitString()
    {
        var otp = _sut.GenerateOtp();
        Assert.Equal(6, otp.Length);
        Assert.True(int.TryParse(otp, out var num));
        Assert.InRange(num, 100000, 999999);
    }

    [Fact]
    public void GenerateOtp_ReturnsDifferentValues()
    {
        var otps = Enumerable.Range(0, 10).Select(_ => _sut.GenerateOtp()).ToHashSet();
        Assert.True(otps.Count > 1, "OTP should not always return the same value");
    }

    [Fact]
    public async Task SendOtpAsync_ReturnsTrue()
    {
        var result = await _sut.SendOtpAsync("+233201234567", "123456");
        Assert.True(result);
    }
}
