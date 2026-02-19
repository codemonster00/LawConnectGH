import Link from "next/link";
import { ConsultationDto } from "@/lib/types";
import StatusBadge from "./StatusBadge";

export default function ConsultationCard({ consultation: c }: { consultation: ConsultationDto }) {
  return (
    <Link href={`/consultations/${c.id}`} className="block bg-white border border-gray-200 rounded-xl p-4 hover:shadow-md transition">
      <div className="flex items-center justify-between mb-2">
        <span className="text-sm font-semibold text-gray-800">{c.legalTopicName || "General"}</span>
        <StatusBadge status={c.status} />
      </div>
      <p className="text-sm text-gray-600 line-clamp-2">{c.problemDescription}</p>
      <div className="flex items-center justify-between mt-3 text-xs text-gray-500">
        <span>{c.lawyerName ? `Lawyer: ${c.lawyerName}` : "Awaiting match"}</span>
        <span>{new Date(c.createdAt).toLocaleDateString()}</span>
      </div>
    </Link>
  );
}
