"use client";

export default function PhoneInput({
  value,
  onChange,
}: {
  value: string;
  onChange: (v: string) => void;
}) {
  return (
    <div className="flex items-center border border-gray-300 rounded-xl overflow-hidden focus-within:ring-2 focus-within:ring-primary">
      <span className="bg-gray-50 px-3 py-3 text-sm text-gray-600 border-r flex items-center gap-1">
        🇬🇭 +233
      </span>
      <input
        type="tel"
        placeholder="24 000 0000"
        value={value}
        onChange={(e) => onChange(e.target.value.replace(/[^0-9]/g, ""))}
        maxLength={10}
        className="flex-1 px-3 py-3 text-sm outline-none"
      />
    </div>
  );
}
