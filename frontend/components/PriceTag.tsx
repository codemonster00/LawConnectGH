export default function PriceTag({ amount, className = "" }: { amount: number; className?: string }) {
  return (
    <span className={`font-semibold text-primary ${className}`}>
      GHS {amount.toFixed(2)}
    </span>
  );
}
