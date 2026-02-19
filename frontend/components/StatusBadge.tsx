import { CONSULTATION_STATUSES } from "@/lib/constants";

export default function StatusBadge({ status }: { status: string }) {
  const config = CONSULTATION_STATUSES[status] || { label: status, color: "bg-gray-100 text-gray-800" };
  return (
    <span className={`inline-block px-3 py-1 rounded-full text-xs font-semibold ${config.color}`}>
      {config.label}
    </span>
  );
}
