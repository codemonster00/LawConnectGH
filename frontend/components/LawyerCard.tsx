import Link from "next/link";
import { LawyerProfileDto } from "@/lib/types";
import RatingStars from "./RatingStars";
import PriceTag from "./PriceTag";

export default function LawyerCard({ lawyer }: { lawyer: LawyerProfileDto }) {
  return (
    <div className="bg-white border border-gray-200 rounded-xl p-4 hover:shadow-lg transition">
      <div className="flex items-start gap-3">
        <div className="w-14 h-14 bg-primary/10 rounded-full flex items-center justify-center text-xl font-bold text-primary shrink-0">
          {lawyer.fullName.charAt(0)}
        </div>
        <div className="flex-1 min-w-0">
          <h3 className="font-bold text-gray-900 truncate">{lawyer.fullName}</h3>
          {lawyer.lawFirm && <p className="text-xs text-gray-500">{lawyer.lawFirm}</p>}
          <div className="flex flex-wrap gap-1 mt-2">
            {lawyer.specializations.slice(0, 3).map((s) => (
              <span key={s} className="bg-primary/10 text-primary text-xs px-2 py-0.5 rounded-full">
                {s}
              </span>
            ))}
          </div>
          <div className="flex items-center justify-between mt-3">
            <RatingStars rating={lawyer.ratingAvg} count={lawyer.ratingCount} />
            <PriceTag amount={lawyer.consultationFee15Min} className="text-sm" />
          </div>
          <div className="flex items-center justify-between mt-3">
            <span className={`text-xs ${lawyer.isAvailable ? "text-success" : "text-gray-400"}`}>
              {lawyer.isAvailable ? "● Available" : "○ Unavailable"}
            </span>
            <Link
              href={`/lawyers/${lawyer.id}`}
              className="bg-primary text-white text-xs px-4 py-2 rounded-full font-semibold hover:bg-primary-light transition"
            >
              Book Consultation
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
