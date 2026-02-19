using FluentValidation;
using LawConnect.Application.DTOs.Consultations;

namespace LawConnect.Application.Validators;

public class CreateConsultationRequestValidator : AbstractValidator<CreateConsultationRequest>
{
    public CreateConsultationRequestValidator()
    {
        RuleFor(x => x.ProblemDescription).NotEmpty().MinimumLength(20).MaximumLength(5000);
        RuleFor(x => x.Type).IsInEnum();
    }
}
