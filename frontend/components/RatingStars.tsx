"use client";

export default function RatingStars({
  rating,
  count,
  interactive = false,
  onRate,
}: {
  rating: number;
  count?: number;
  interactive?: boolean;
  onRate?: (r: number) => void;
}) {
  return (
    <div className="flex items-center gap-1">
      {[1, 2, 3, 4, 5].map((star) => (
        <button
          key={star}
          type="button"
          disabled={!interactive}
          onClick={() => onRate?.(star)}
          className={`text-lg ${interactive ? "cursor-pointer hover:scale-110" : "cursor-default"} ${
            star <= Math.round(rating) ? "text-accent" : "text-gray-300"
          }`}
        >
          ★
        </button>
      ))}
      {count !== undefined && (
        <span className="text-xs text-gray-500 ml-1">({count})</span>
      )}
    </div>
  );
}
