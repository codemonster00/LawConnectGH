using LawConnect.Application.Interfaces;

namespace LawConnect.Infrastructure.Services;

public class PaymentService : IPaymentService
{
    // TODO: Integrate with Paystack for mobile money and card payments in Ghana
    public async Task<string> InitiatePaymentAsync(decimal amount, string currency, string phoneNumber, string reference)
    {
        Console.WriteLine($"[PAYMENT] Initiating {currency} {amount} payment for {phoneNumber} | Ref: {reference}");
        await Task.CompletedTask;
        return $"MOCK-PAY-{Guid.NewGuid():N}";
    }

    public async Task<bool> VerifyPaymentAsync(string reference)
    {
        Console.WriteLine($"[PAYMENT] Verifying payment reference: {reference}");
        await Task.CompletedTask;
        return true; // Mock: always succeeds
    }
}
