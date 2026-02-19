namespace LawConnect.Application.Interfaces;

public interface IPaymentService
{
    Task<string> InitiatePaymentAsync(decimal amount, string currency, string phoneNumber, string reference);
    Task<bool> VerifyPaymentAsync(string reference);
}
